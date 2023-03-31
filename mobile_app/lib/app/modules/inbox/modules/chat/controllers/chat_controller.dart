import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../routes/pages.dart';
import '../../../../feed/controllers/feed_controller.dart';
import '../../../controllers/inbox_controller.dart';

class ChatController extends GetxController with GetTickerProviderStateMixin {
  final IChatRepository chatRepository;
  final InboxController inboxController;
  final UserService userService;
  final IAuthUserService authUserStore;
  final FeedController feedController;
  int? collectionKey;

  final FocusNode focusNode = FocusNode();
  final GetQueue _queue = GetQueue();
  String messageCursor = '';
  String prevCursor = '';

  int portfolioOffset = 0;
  final RxBool hasFetchedMessages$ = false.obs;

  final RxBool isTyping = false.obs;
  final lastSeen = Rx<DateTime?>(null);
  final RxList<IrisMessage> totalMessages$ = <IrisMessage>[].obs;

  final RxList<Portfolio> currentPortfolios$ = <Portfolio>[].obs;
  late Rx<TextModel> textCollection;

  late StreamSubscription? streamSubscription;

  final Rx<TextModel?> sharedOrder$ = Rx<TextModel?>(null);
  final ScrollController scrollController = ScrollController();

  Timer? _checkOnlineTimer;
  String avatarUrl = '';

  RxString chatname = ''.obs;
  String id = '';

  String encryptionCode = '';

  IrisCryptr? crypto;

  bool submitting = false;

  // StreamSubscription? _routeListener;

  // void refreshOnRouteAppear() {
  //   _routeListener = IrisStackObserver.stackChange.listen((stackChange) {
  //     if (stackChange.newRoute!.settings.name == Paths.Inbox &&
  //         stackChange.oldRoute is GetPageRoute) {
  //       getCollection();
  //     }
  //   });
  // }

  final _debouncer = Debouncer(delay: const Duration(seconds: 3));

  ChatController({
    required this.chatRepository,
    required this.inboxController,
    required this.userService,
    required this.authUserStore,
    required this.feedController,
  });

  String get chatbarSubtitle {
    final numberOfCurrentUsers = currentCollection$.numberOfCurrentUsers;
    final seenAt = lastSeen.value;
    if (!isPrivateMessage) {
      return '$numberOfCurrentUsers members';
    } else {
      if (seenAt != null) {
        return seenAt
                .isBefore(DateTime.now().subtract(const Duration(minutes: 3)))
            ? 'Active ${timeago.format(seenAt)}'
            : 'Active now';
      } else {
        return '';
      }
    }
  }

  Collection get currentCollection$ =>
      textCollection.value.collection ?? const Collection();

  set currentCollection$(Collection value) =>
      textCollection.value = textCollection.value.copyWith(collection: value);

  List<User>? get currentUsers {
    return textCollection.value.collection?.currentUsers;
  }

  bool get isFirstMessage =>
      totalMessages$.isEmpty && hasFetchedMessages$.value;

  bool get isPrivateMessage {
    if (currentCollection$.collectionType == null) {
      return true;
    }
    return currentCollection$.collectionType == COLLECTION_TYPE.PRIVATE_MESSAGE;
  }

  int? get loggedUserKey {
    return authUserStore.loggedUser?.userKey;
  }

  User get receiverUser {
    if (currentUsers == null || currentUsers!.isEmpty) {
      return Fallback.user;
    } else {
      return currentUsers!.first;
    }
  }

  IrisBubbleType bubbleType(int index, TextModel data, TextModel? before) {
    final after = index >= 1 ? totalMessages$[index - 1] : null;

    final isSameUserTop = previousIsOther(index);

    final isSameUserBottom =
        after?.message.value.user!.userKey == null && index != 0
            ? false
            : after?.message.value.user!.userKey != data.user!.userKey;

    if (isSameUserTop && isSameUserBottom) {
      return IrisBubbleType.topAndBottom;
    } else if (isSameUserTop) {
      return IrisBubbleType.top;
    } else if (isSameUserBottom) {
      return IrisBubbleType.bottom;
    } else {
      return IrisBubbleType.middle;
    }
  }

  void checkUsers() {
    final users = currentCollection$.currentUsers;
    if (users == null || users.isEmpty) {
      updateUsers();
    }
  }

  AnimationController createAnimationController({bool isStart = false}) {
    if (isStart) {
      return AnimationController(
        value: 1,
        vsync: this,
        duration: const Duration(milliseconds: 0),
      );
    } else {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      );
    }
  }

  Future<void> createText(String value, PostInputInfo info) async {
    int? parentKey;

    final Rx<TextModel> text = TextModel(
            textCreateId: DateTime.now().millisecondsSinceEpoch,
            //This is so we can locate it later
            value: value,
            textType: info.createTextType!.textType,
            parentKey: parentKey,
            //TODO: Create authUser object on UserController and remove Store depencency of this controller
            sharedText: info.sharedText!.value,
            user: authUserStore.loggedUser,
            orderedCreatedAt: DateTime.now())
        .obs;

    onUpdateMessageView(IrisMessage(
      message: text,
      animationController: createAnimationController(),
    )); //

    Giff? giff;
    List<http.MultipartFile>? fileUploads;

    if (info.mediaList.isNotEmpty) {
      final AppMedia appMedia = info.mediaList[0];
      if (appMedia.appMediaType == APP_MEDIA_TYPE.GIFF) {
        giff = Giff(
            giffSource: GIFF_SOURCE.GIPHY,
            remoteId: appMedia.giffId,
            url: appMedia.url);
      }
      if (appMedia.appMediaType == APP_MEDIA_TYPE.PHOTO) {
        final http.MultipartFile multiPartFile = http.MultipartFile.fromBytes(
          'photo',
          appMedia.bytes!,
          filename: '${DateTime.now().second}.jpg',
          contentType: MediaType('image', 'jpg'),
        );
        fileUploads = [multiPartFile];
      }
      if (appMedia.appMediaType == APP_MEDIA_TYPE.VIDEO) {
        final http.MultipartFile multiPartFile = http.MultipartFile.fromBytes(
          'video',
          appMedia.bytes!,
          filename: '${DateTime.now().second}.mp4',
          contentType: MediaType('video', 'mp4'),
        );
        fileUploads = [multiPartFile];
      }
    }

    try {
      late final TextModel? newText;
      if (fileUploads != null) {
        newText = await overlayLoader(
            context: Get.overlayContext!,
            asyncFunction: () async {
              return chatRepository.sendMessage(
                giff: giff,
                value: await encrypt(value),
                parentKey: parentKey,
                fileUploads: fileUploads,
                textType: info.createTextType!.textType,
                collectionKey: info.createTextType!.collectionKey,
                isEncrypted: true,
              );
            });
      } else {
        newText = await chatRepository.sendMessage(
          giff: giff,
          value: await encrypt(value),
          parentKey: parentKey,
          fileUploads: fileUploads,
          textType: info.createTextType!.textType,
          sharedTextKey: info.sharedText!.value != null
              ? info.sharedText!.value!.textKey!
              : null,
          collectionKey: info.createTextType!.collectionKey,
          isEncrypted: true,
        );
      }

      if (newText == null) {
        return;
      }

      text.value = newText.copyWith(
          value: await decrypt(newText.value!), collection: currentCollection$);

      await inboxController.markSeen(text);
      inboxController.insertOrUpdateConversationList(text);

      if (Get.isBottomSheetOpen!) {
        Get.back();
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<String> decrypt(String value) {
    return exec(() => crypto!.decrypt(value));
  }

  Future<List<TextModel>> decryptMessageList(List<TextModel> messages) async {
    final tempList = <TextModel>[];
    for (TextModel message in messages) {
      if (message.isEncrypted ?? false) {
        if (message.value != null) {
          final decryptedMessage = await decrypt(message.value!);
          tempList.add(
              message.copyWith(value: decryptedMessage, isEncrypted: false));
        }
      } else {
        tempList.add(message);
      }
    }
    return tempList;
  }

  Future<String> encrypt(String value) async {
    return exec(() => crypto!.encrypt(value));
  }

  Future<T> exec<T>(Function job) {
    return _queue.add(job);
  }

  Future<void> firstLoad() async {
    //stagger it so the first loads happen quickly
    await getMessages(limit: 10);
    await getMessages(limit: 20, queryType: QueryType.loadMore);
  }

  Future<void> getCollection() async {
    await chatRepository.getBasicCollectionDetails(
        collectionKey: collectionKey!,
        queryType: QueryType.loadCache,
        callback: (collection) async {
          if (collection.collectionGuardedInfo == null ||
              collection.collectionGuardedInfo!.encryptionCode == null) {
            return;
          }
          currentCollection$ = collection;
          if (chatname.isEmpty) setChatname(currentCollection$);

          final encryptionCodeRemote =
              collection.collectionGuardedInfo!.encryptionCode;
          if (encryptionCodeRemote != null) {
            crypto = IrisCryptr(secret: encryptionCodeRemote);
          } else {
            throw 'null encrypt code';
          }

          inboxController.markSeen(textCollection);
        },
        onError: (error) {});
  }

  Rx<TextModel>? getMessageById(int? textKey) {
    final irisMessage = totalMessages$.firstWhereOrNull(
        (element) => element.message.value.textKey == textKey);
    return irisMessage?.message;
  }

  Future<void> getMessages(
      {QueryType queryType = QueryType.loadCache, int limit = 10}) async {
    return chatRepository.getMessagesFromCollection(
      collectionKey: collectionKey,
      cursor: messageCursor,
      queryType: queryType,
      limit: limit,
      callback: (data) =>
          onSuccess(data, isLoadMore: queryType == QueryType.loadMore),
      onError: onError,
    );
  }

  bool hasAttachment(PostInputInfo info) {
    if (info.mediaList.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool hasSharedText(PostInputInfo info) {
    if (info.sharedText?.value is TextModel) {
      return true;
    }
    return false;
  }

  void initCheckStatusPolling() {
    _checkStatusOnline(QueryType.loadCache);
    _checkOnlineTimer = Timer.periodic(const Duration(seconds: 15),
        (t) => _checkStatusOnline(QueryType.loadRemote));
  }

  bool isAuthUser(TextModel message) {
    final authUser = authUserStore.loggedUser?.userKey;
    final messageUser = message.user?.userKey;
    if (authUser == null || messageUser == null) {
      return false;
    }
    if (authUser == messageUser) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> loadMore() async {
    if (totalMessages$.length >= 10) {
      await getMessages(queryType: QueryType.loadMore);
    }
  }

  void markSeen() {
    inboxController.markSeen(textCollection);
  }

  void onChatBarTapped() {
    if (currentCollection$.collectionType == COLLECTION_TYPE.PRIVATE_MESSAGE) {
      final user = currentCollection$.currentUsers![0];
      final profileArgs = ProfileArgs(
        user: user,
        heroTag: id,
      );

      Get.toNamed(
        Paths.Feed + Paths.Home + Paths.Profile,
        parameters: {'profileUserKey': user.userKey.toString()},
        arguments: profileArgs,
        id: 1,
      );
    } else if (currentCollection$.collectionType ==
        COLLECTION_TYPE.GROUP_MESSAGE) {
      Get.toNamed(Paths.GroupDetails.createPath([collectionKey!]), id: 1);
    }
  }

  @override
  void onClose() {
    _checkOnlineTimer?.cancel();
    streamSubscription?.cancel();

    for (IrisMessage message in totalMessages$) {
      message.animationController.dispose();
    }

    //TODO: Check if seen is working
    inboxController.markSeenById(collectionKey!);
  }

  void onError(err) {
    IrisExceptionHandler.show(MessagesLoadException());
  } //to prevent twitchy fingers from pressing quickly

  @override
  void onInit() {
    if (Get.parameters['collectionKey'] != null &&
        Get.parameters['collectionKey'] != '') {
      collectionKey = int.parse(Get.parameters['collectionKey']!);
    }

    final args = Get.arguments;
    firstLoad();
    if (args is ChatArgs) {
      avatarUrl = args.avatarUrl;
      id = args.id;

      if (args.message == null ||
          args.chatname.isEmpty ||
          args.encryptionCode.isEmpty) {
        textCollection = Rx(const TextModel());
        exec(getCollection);
        //   getCollection();
      } else {
        chatname.value = args.chatname;
        encryptionCode = args.encryptionCode;
        crypto = IrisCryptr(secret: encryptionCode);
        textCollection = args.message!;
        // firstLoad();
      }
    } else {
      throw InvalidArgsException();
    }

    subscribeNewMessages();
    initCheckStatusPolling();
    updateUnreadMessageCountForAuthUser();
    updateUsers();
    super.onInit();
  }

  Future<void> onNewMessage({required TextModel newText}) async {
    final decryptedMessage = await decrypt(newText.value!);

    onUpdateMessageView(IrisMessage(
      message: newText.copyWith(value: decryptedMessage, createdAt: null).obs,
      animationController: createAnimationController(),
    ));
  }

  void onReactionChange(Reaction? reaction) {
    if (reaction != null) {
      // debugPrint('REACTION CHANGED: $reaction');
      // final message = getMessageById(reaction.textKey);
      // debugPrint('AuthUserReaction: ${message!.value.authUserReaction}');
      // message.value = message.value.copyWith(authUserReaction: reaction);
    }
  }

  void onReactionCreated(Reaction? reaction) {
    if (reaction != null) {
      final message = getMessageById(reaction.textKey);
      if (message != null) {
        final numberOfReactions = message.value.numberOfReactions ?? 0;
        message.value =
            message.value.copyWith(numberOfReactions: numberOfReactions + 1);
      }
    }
  }

  void onReactionRemoved(Reaction? reaction) {
    if (reaction != null) {
      final message = getMessageById(reaction.textKey);
      if (message != null) {
        final numberOfReactions = message.value.numberOfReactions ?? 0;
        if (numberOfReactions > 0) {
          message.value =
              message.value.copyWith(numberOfReactions: numberOfReactions - 1);
        }
      }
    }
  }

  Future<void> onSubmit(PostInputInfo info) async {
    if (submitting == true) {
      return;
    }

    final String value = info.textEditingController!.text;
    if (value.isEmpty || value.trim().isEmpty) {
      if (!hasSharedText(info) && !hasAttachment(info)) {
        return;
      }
    }
    info.textEditingController!.text = '';
    try {
      submitting = true;
      // if (info.textModel == null) {
      await createText(value, info);
      submitting = false;
      // } else {
      //   // await editText(value, info.textModel!.value, info.mediaList,
      //   //     info.isEdited, info.deletedMedia);
      // }
      info.mediaList.clear(); // need to clear mediaList when sending message
      sharedOrder$.value = null;
      scrollToTop();
    } catch (err) {
      submitting = false;
      rethrow;
    }
  }

  Future<void> onSuccess(CollectionsGetResponse data,
      {required bool isLoadMore}) async {
    final collections = data.collections;
    if (collections?.isEmpty ?? true) {
      return;
    }

    final collectionGuardedInfo = collections!.first.collectionGuardedInfo;

    crypto ??= IrisCryptr(secret: collectionGuardedInfo!.encryptionCode!);
    final cursor = collectionGuardedInfo?.messagesConnection?.nextCursor;

    final messages = collectionGuardedInfo?.messagesConnection?.messages ?? [];

    // final List<TextModel> messages =
    //     List<TextModel>.from(dataCollections.map((i) => TextModel.fromJson(i)));

    if (cursor != null && cursor != '') {
      messageCursor = cursor;
    }

    final decryptedMessages = await decryptMessageList(messages);
    if (messages.length != decryptedMessages.length) {
      throw 'failure';
    }
    final messageList = decryptedMessages
        .map((item) => IrisMessage(
              animationController: createAnimationController(isStart: true),
              message: item.obs,
            ))
        .toList();
    if (decryptedMessages.isNotEmpty) {
      if (isLoadMore) {
        if (prevCursor != messageCursor) {
          // to prevent duplicate messages pushed
          totalMessages$.addAll(messageList);
        }
      } else {
        totalMessages$.assignAll(messageList);
      }
    }

    prevCursor = messageCursor;

    if (hasFetchedMessages$.value == false) {
      hasFetchedMessages$.value = true;
    }
  }

  void onTyping(int? collectionKey) {
    isTyping.value = true;
    _debouncer(() {
      isTyping.value = false;
    });
  }

  void onUpdateMessageView(IrisMessage irisMessage) {
    totalMessages$.insert(0, irisMessage);
    irisMessage.animationController.forward();
    markSeen();
  }

  Future<void> onUserTyping() async {
    await chatRepository.userTyping(collectionKey: collectionKey);
  }

  bool previousIsOther(int index) {
    if (index + 1 < totalMessages$.length) {
      final after = totalMessages$[index + 1];
      return after.message.value.user!.userKey !=
          totalMessages$[index].message.value.user!.userKey;
    }
    return false;
  }

  void removeMessageById(int? textKey) {
    totalMessages$
        .removeWhere((element) => element.message.value.textKey == textKey);
  }

  void scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  void setChatname(Collection collection) {
    if (collection.name != null && collection.name!.isNotEmpty) {
      chatname.value = collection.name ?? '';
    } else if (collection.currentUsers != null &&
        collection.currentUsers!.isNotEmpty) {
      if (collection.currentUsers!.length == 1) {
        //authUser is excluded in query
        final User otherUser = collection.currentUsers![0];
        if (otherUser.userKey != null) {
          chatname.value = otherUser.fullName;
        }
      }
    }
  }

  void setCurrentUsers(List<User>? currentUsers) {
    currentCollection$ =
        currentCollection$.copyWith(currentUsers: currentUsers);
  }

  void setSharingOrder(TextModel? sharingOrder) {
    sharedOrder$.value = sharingOrder;
  }

  bool showDate(TextModel message, DateTime? before) {
    final date = message.createdAt?.subtract(const Duration(hours: 2));
    if (date == null) {
      return false;
    }

    final beforeDate = before?.millisecondsSinceEpoch;
    final currentData = date.millisecondsSinceEpoch;
    if (beforeDate == null) {
      return true;
    }
    if (before == null || beforeDate < currentData) {
      return true;
    }

    return false;
  }

  void subscribeNewMessages() {
    streamSubscription = chatRepository.collectionEvents(
      collectionKeys: [collectionKey!],
      events: [
        COLLECTION_EVENT_TYPE.TEXT_CREATED,
        COLLECTION_EVENT_TYPE.TEXT_EDITED,
        COLLECTION_EVENT_TYPE.TEXT_DELETED,
        COLLECTION_EVENT_TYPE.USER_TYPING,
        COLLECTION_EVENT_TYPE.COLLECTION_EDITED,
        COLLECTION_EVENT_TYPE.USER_REMOVED,
        COLLECTION_EVENT_TYPE.USER_ADDED,
        COLLECTION_EVENT_TYPE.REACTION_DELETED,
        COLLECTION_EVENT_TYPE.REACTION_EDITED,
        COLLECTION_EVENT_TYPE.REACTION_CREATED,
      ],
      callback: (event) {
        final shouldNotify = event.userKey != loggedUserKey;

        if (event.eventType == COLLECTION_EVENT_TYPE.USER_TYPING) {
          if (shouldNotify) onTyping(event.collectionKey);
        } else if (event.eventType == COLLECTION_EVENT_TYPE.TEXT_CREATED) {
          if (shouldNotify) {
            onNewMessage(newText: event.text!);
          }
        } else if (event.eventType == COLLECTION_EVENT_TYPE.REACTION_CREATED) {
          if (event.reaction!.userKey != loggedUserKey) {
            onReactionCreated(event.reaction);
          }
        } else if (event.eventType == COLLECTION_EVENT_TYPE.REACTION_DELETED) {
          if (event.reaction!.userKey != loggedUserKey) {
            onReactionRemoved(event.reaction);
          }
        } else if (event.eventType == COLLECTION_EVENT_TYPE.REACTION_EDITED) {
          if (event.reaction!.userKey != loggedUserKey) {
            onReactionChange(event.reaction);
          }
        } else if (event.eventType == COLLECTION_EVENT_TYPE.USER_ADDED) {
          updateUsers();
        } else if (event.eventType == COLLECTION_EVENT_TYPE.USER_REMOVED) {
          updateUsers();
        }
      },
      onError: onError,
    );
  }

  Future<void> updateUnreadMessageCountForAuthUser() async {
    return feedController.updateAppBadges();
  }

  Future<void> updateUsers() async {
    await chatRepository.getCollectionUsers(
        collectionKeys: [collectionKey],
        queryType: QueryType.loadRemote,
        callback: (collectionInfo) {
          currentCollection$ = collectionInfo;

          if (chatname.isEmpty) setChatname(currentCollection$);
        },
        onError: (error) {});
  }

  void _checkStatusOnline(QueryType queryType) {
    if (receiverUser != Fallback.user) {
      chatRepository.getLastSeen(
        userKey: receiverUser.userKey!,
        callback: (data) {
          if (data is User) {
            lastSeen.value = data.lastOnlineAt;
          } else {
            debugPrint('Error on set lastseen');
          }
        },
        onError: onError,
        type: queryType,
      );
    }
  }
}

class IrisMessage {
  final Rx<TextModel> message;
  final AnimationController animationController;

  IrisMessage({required this.message, required this.animationController});
}

extension Rep<E> on List<E> {
  bool replaceIndex(E replacement, int index) {
    this[index] = replacement;
    return true;
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:graphql/client.dart';

import '../../../routes/pages.dart';
import '../../feed/controllers/feed_controller.dart';
import '../modules/groupchat/groupchat_screen.dart';
import '../shared/utils/decrypt_messages_utils.dart';

class InboxController extends GetxController
    with StateMixin<List<Rx<TextModel>>> {
  final IInboxRepository repository;
  final IChatRepository chatRepository;
  final IAuthUserService authUserStore;
  final FeedController feedController;
  final scrollController = ScrollController();
  final listViewController = GlobalKey<IrisListViewState>();
  bool primaryEndReached = false;

  StreamSubscription? streamSubscription;
  String nextCursor = '';

  late StreamSubscription _routeListener;
  bool alreadyLoaded = false;

  final _debouncer = Debouncer(delay: const Duration(seconds: 3));
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  String initialCursor = '';

  InboxController({
    required this.repository,
    required this.chatRepository,
    required this.authUserStore,
    required this.feedController,
  });

  int? get loggedUserKey {
    return authUserStore.loggedUser?.userKey;
  }

  void addToInboxListIfNotExist(
      TextModel newText, User userFromMessage, Collection collection) {
    final newMessageList = List<Rx<TextModel>>.from(state!);
    final pm = getTextByCollectionKey(newText.collection!.collectionKey!);

    ///check if message is on inboxList
    if (pm == null) {
      final data = newText.copyWith(
          collection: collection.copyWith(currentUsers: [userFromMessage]));
      newMessageList.insert(0, data.obs);
      rebuildOnChange(newMessageList);
    }
  }

  Future<void> firstLoad() async {
    await repository.loadPrimary(
      callback: onLoadInitialData,
      onError: onError,
      cursor: initialCursor,
      queryType: QueryType.loadCache,
      limit: 10,
    );

    await loadMore(limit: 30);
  }

  // Future firstLoad() async {
  //   //stagger it so the first loads happen quickly
  //   await onLoadPrimary(limit: 10);
  //   await onLoadPrimary(limit: 30, queryType: QueryType.loadMore);
  //   await onLoadPrimary(limit: 50, queryType: QueryType.loadMore);
  // }

  TextModel? getSharedText(Rx<TextModel> text) {
    return text.value.sharedText;
  }

  /// If the items is empty, return empty status so the view renders onEmtpy() widget
  RxStatus getStatus(items) {
    var status = RxStatus.success();
    if (items.isEmpty) {
      status = RxStatus.empty();
    }
    return status;
  }

  String getSubtitle(Rx<TextModel> text) {
    if (getSharedText(text) != null) {
      if (getSharedText(text)!.order != null) {
        if (getValue(text) != null && getValue(text) != '') {
          return getValue(text)!;
        }
        var visibleText = 'Shared an order';
        if (text.value.sharedText?.order?.symbol != null) {
          visibleText += ' - trading \$${text.value.sharedText?.order?.symbol}';
        }
        return visibleText;
      } else if (text.value.sharedText!.article != null) {
        if (getValue(text) != null && getValue(text) != '') {
          return getValue(text)!;
        }
        return 'Shared an article';
      } else if (text.value.sharedText!.value != null) {
        ///TODO: consider changing wording to 'Shared Brians Post' or 'Shared Brians Order'
        if (getValue(text) != null && getValue(text) != '') {
          return getValue(text)!;
        }
        return 'Shared a post';
      } else if (text.value.sharedText?.dueDiligence != null) {
        ///TODO: consider changing wording to 'Shared Brians Post' or 'Shared Brians Order'
        if (getValue(text) != null && getValue(text) != '') {
          return getValue(text)!;
        }
        return 'Shared a Trade Idea';
      } else {
        return 'Post was deleted';
      }
    } else {
      //the most recent item was a message, show the message
      return text.value.value ?? '';
    }
  }

  Rx<TextModel>? getTextByCollectionKey(int collectionKey) {
    return state!.firstWhereOrNull(
      (item) => item.value.collection!.collectionKey == collectionKey,
    );
  }

  User? getUser(Rx<TextModel> text) {
    if (text.value.collection!.currentUsers != null &&
        text.value.collection!.currentUsers!.isNotEmpty) {
      return text.value.collection!.currentUsers![0];
    } else {
      return Fallback.user; //text.value.user;
    }
  }

  String? getValue(Rx<TextModel> text) {
    return text.value.value;
  }

  void insertOrUpdateConversationList(Rx<TextModel> text) {
    // final List<Rx<TextModel>> data = state!;
    final currentCollection =
        getTextByCollectionKey(text.value.collection!.collectionKey!);

    /// No message found, so, insert text to inbox list
    if (currentCollection == null) {
      if (state!.isEmpty) {
        onCheckNew();
        return;
      }
      state!.insert(0, text);
      rebuildOnChange(state!);
    } else {
      ///otherwise, update
      currentCollection.value = text.value;
    }
  }

  bool isUnread(Rx<TextModel> text) {
    final UserRelation? authUserRelation =
        text.value.collection!.authUserRelation;
    final DateTime? lastSeenAt = authUserRelation?.seenAt;
    final DateTime? lastMessageCreatedAt = text.value.createdAt;
    final messageUserKey = text.value.userKey;
    if (messageUserKey == authUserStore.loggedUser?.userKey) {
      return false;
    } else if (lastSeenAt == null) {
      return true;
    } else if (lastMessageCreatedAt == null) {
      return false;
    } else if (lastSeenAt.millisecondsSinceEpoch <
        lastMessageCreatedAt.millisecondsSinceEpoch) {
      return true;
    }
    return false;
  }

  Future<void> loadMore({int limit = 10}) {
    return repository.loadPrimary(
      callback: onLoadMore,
      onError: onError,
      cursor: nextCursor,
      queryType: QueryType.loadMore,
      limit: limit,
    );
  }

  Future<void> markSeen(Rx<TextModel> text) async {
    final UserRelation? userRelation = await chatRepository.markSeen(
        entityType: USER_RELATION_ENTITY_TYPE.COLLECTION,
        entityKeys: text.value.collection!.collectionKey!,
        seen: true);
    final DateTime? seenAt = userRelation?.seenAt;

    final newRelation = text.value.collection!.authUserRelation == null
        ? userRelation
        : text.value.collection!.authUserRelation!.copyWith(seenAt: seenAt);

    text.value = text.value.copyWith(
        collection:
            text.value.collection!.copyWith(authUserRelation: newRelation));
  }

  Future<void> markSeenById(int id) async {
    final textCollection = getTextByCollectionKey(id);
    if (textCollection != null) {
      markSeen(textCollection);
    }
  }

  Future<void> navigateToChat(
      {required Rx<TextModel> text, required String id}) async {
    final user = getUser(text);
    final args = ChatArgs(
      encryptionCode:
          text.value.collection!.collectionGuardedInfo?.encryptionCode ?? '',
      avatarUrl: (text.value.collection!.collectionType ==
                  COLLECTION_TYPE.PRIVATE_MESSAGE
              ? user?.profilePictureUrl
              : text.value.collection!.pictureUrl) ??
          '',
      chatname: (text.value.collection!.collectionType ==
                  COLLECTION_TYPE.PRIVATE_MESSAGE
              ? user?.fullName
              : text.value.collection!.name) ??
          '',
      id: id,
      message: text,
    );
    markSeen(text);
    await Get.toNamed(
      Paths.Feed +
          Paths.Home +
          Paths.MessageCollection.createPath(
              [text.value.collection!.collectionKey]),
      arguments: args,
      id: 1,
    );
  }

  Future<void> onCheckMoreMessages(MessagesGetRecentResponse data) async {
    final messages = data.messages ?? [];

    /// If there are no new messages, do not modify the cursor
    if (messages.isEmpty) {
      return;
    }

    ///update the newMessagesCursor
    initialCursor = data.newCursor ?? '';

    /// Update nextCursor only if is the first message received.
    /// If this is the first message, nextCursor will be empty
    if (nextCursor.isEmpty) {
      nextCursor = data.nextCursor ?? '';
    }

    final currentMessages = state!;

    currentMessages.removeWhere((currentMessage) => messages.any((newMessage) =>
        newMessage.collection!.collectionKey ==
        currentMessage.value.collection!.collectionKey));

    await rebuildOnChange(
      currentMessages
        ..insertAll(0, messages.map((message) => message.obs).toList()),
    );
  }

  Future<void> onCheckNew() {
    return repository.loadPrimary(
      callback: onCheckMoreMessages,
      onError: onError,
      cursor: initialCursor,
      queryType: QueryType.loadRemote,
    );
  }

  @override
  void onClose() {
    _routeListener.cancel();
    streamSubscription?.cancel();
    super.onClose();
  }

  void onError(err) {
    if (kDebugMode) {
      print(err);
    }
    IrisExceptionHandler.show(InboxLoadDataException());
  }

  @override
  void onInit() {
    _routeListener = IrisStackObserver.stackChange.listen((stackChange) {
      if (stackChange.newRoute?.settings.name ==
              Paths.Feed + Paths.Home + Paths.Inbox &&
          stackChange.oldRoute is GetPageRoute) {
        if (alreadyLoaded == true) {
          updateUnreadMessageCountForAuthUser();
          onCheckNew();
        }
      }
    });
    firstLoad();
    subscribeInbox();
    onLoadFollowingUsers();
    alreadyLoaded = true;
    super.onInit();
  }

  void onLoadFollowingUsers() {
    Repository(
        local: chatRepository.getAuthUser(
            requestedFields: '', fetchPolicy: FetchPolicy.cacheFirst),
        remote: chatRepository.getAuthUser(
            requestedFields: '', fetchPolicy: FetchPolicy.networkOnly));
  }

  Future<void> onLoadInitialData(MessagesGetRecentResponse data) async {
    nextCursor = data.nextCursor ?? '';
    initialCursor = data.newCursor ?? '';
    final messages = data.messages ?? [];
    await rebuildOnChange(
      messages.map((message) => message.obs).toList(),
    );
  }

  Future<void> onLoadMore(MessagesGetRecentResponse serverResponse) async {
    if (serverResponse.nextCursor?.isNotEmpty ?? false) {
      nextCursor = serverResponse.nextCursor ?? '';
      final messages = serverResponse.messages ?? [];
      await rebuildOnChange(
        state!
          ..addAll(
            messages.map((message) => message.obs).toList(),
          ),
      );
    }
  }

  Future<void> onNewMessage({required TextModel newText}) async {
    if (state!.isEmpty) {
      onCheckNew();
      return;
    }
    final newMessageList = List<Rx<TextModel>>.from(state!);
    final pm = getTextByCollectionKey(newText.collection!.collectionKey!);

    /// If there are no messages yet, we can't add them directly through the subscription because
    /// [Query.messagesGetRecent] in backend is not able to deliver nextCursor.
    /// If no cursor is added, when loadMore is called it will add the message back
    /// to the InboxList, as the query will fetch data with an empty cursor.
    /// So we call onLoadPrimary because it will deliver the message with the cursor

    ///Message not found, create it
    if (pm == null) {
      newMessageList.insert(0, newText.obs);
    } else {
      var message = newText.value;
      if (newText.isEncrypted!) {
        message = await compute(
          DecryptMessages.decrypt,
          DecryptData(
              message: newText.value!,
              encryptionCode:
                  newText.collection!.collectionGuardedInfo!.encryptionCode!),
        );
      } else {
        message = newText.value;
      }
      pm.value = pm.value.copyWith(
        value: message,
        createdAt: newText.createdAt,
        orderedCreatedAt: newText.orderedCreatedAt,
        textKey: newText.textKey,
        userKey: newText.userKey,
      );
    }

    newMessageList.sort((a, b) =>
        b.value.orderedCreatedAt!.compareTo(a.value.orderedCreatedAt!));

    rebuildOnChange(newMessageList);
  }

  void onSuccess(MessagesGetRecentResponse serverResponse) {
    nextCursor = serverResponse.nextCursor ?? '';
    rebuildOnChange(
      serverResponse.messages?.map((message) => message.obs).toList() ?? [],
    );
  }

  void onTyping(int? collectionKey) {
    setIsTyping(collectionKey, true);
    _debouncer(() {
      setIsTyping(collectionKey, null);
    });
  }

  void openPannel() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) => const CustomBottomSheet(
        child: GroupChatScreen(),
      ),
      isScrollControlled: true,
    );
  }

  /// This method checks if the value of the added data is different from the value of the current state.
  /// It serves functions that do not use [getResponse] from a [Repository], but only data from the local cache,
  /// or just from the internet.
  Future<void> rebuildOnChange(List<Rx<TextModel>> data) async {
    //compute is failing
    final value = await DecryptMessages.decryptMessageList(data);
    // final value = await compute(
    //     DecryptMessages.decryptMessageList, data.map((e) => e.value).toList());

    change(value, status: getStatus(data));
  }

  void removeConversation(int? collectionKey) {
    if (collectionKey != null) {
      chatRepository.collectionRemoveEntities(
          collectionKey: collectionKey,
          entityType: COLLECTION_REQUEST_ENTITY_TYPE.USER,
          entityKeys: [authUserStore.loggedUser?.userKey]);
      removeFromInbox(collectionKey: collectionKey);
    }
  }

  void removeFromInbox({required int collectionKey}) {
    final newMessageList = List<Rx<TextModel>>.from(state!);
    newMessageList.removeWhere(
        (element) => element.value.collection?.collectionKey == collectionKey);
    rebuildOnChange(newMessageList);
  }

  void setInitialCursor(String value) {
    initialCursor = value;
  }

  void setIsTyping(collectionKey, value) {
    final originText = getTextByCollectionKey(collectionKey);
    if (originText != null) {
      final TextModel newText = originText.value.copyWith(
          collection: originText.value.collection!.copyWith(isTyping: value));

      originText.value = newText;
    }
  }

  void setNotificationSetting(bool notificationSetting, Rx<TextModel> text) {
    final amount = notificationSetting
        ? USER_RELATION_NOTIFICATION_AMOUNT.ALL
        : USER_RELATION_NOTIFICATION_AMOUNT.NONE;

    final relation = text.value.collection!.authUserRelation == null
        ? UserRelation(notificationAmount: amount)
        : text.value.collection!.authUserRelation!
            .copyWith(notificationAmount: amount);

    final updatedModel = text.value.copyWith(
      collection: text.value.collection!.copyWith(authUserRelation: relation),
    );

    final message =
        getTextByCollectionKey(text.value.collection!.collectionKey!);

    message!.value = updatedModel;

    chatRepository.setNotificationSettings(
      amountType: amount,
      collectionKeys: [text.value.collection!.collectionKey!],
    );
  }

  Future<void> subscribeInbox() async {
    streamSubscription = repository.collectionEvents(
      events: messageCollectionEvents,
      callback: (event) {
        final shouldNotify = event.userKey != loggedUserKey;
        if (event.eventType == COLLECTION_EVENT_TYPE.USER_TYPING) {
          if (shouldNotify) onTyping(event.collectionKey);
        } else if (event.eventType == COLLECTION_EVENT_TYPE.TEXT_CREATED) {
          if (shouldNotify) {
            updateUnreadMessageCountForAuthUser();
            onNewMessage(newText: event.text!);
          }
        }
        // else if (event.eventType == COLLECTION_EVENT_TYPE.USER_ADDED) {
        //   if (shouldNotify) {
        //     onUserAdded();
        //   }
        // } else if (event.eventType == COLLECTION_EVENT_TYPE.USER_REMOVED) {
        //   if (shouldNotify) {
        //     onUserRemoved();
        //   }
        // }
      },
      onError: onError,
    );
  }

  Future<void> updateUnreadMessageCountForAuthUser() async {
    return feedController.updateAppBadges();
  }
}

// class InboxItemKeys {
//   final int collectionId;
//   final int textId;
//   const InboxItemKeys({required this.collectionId, required this.textId});
// }

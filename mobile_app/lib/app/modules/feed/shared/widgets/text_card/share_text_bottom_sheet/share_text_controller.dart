import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class ShareTextController extends GetxController {
  final IInboxRepository inboxRepository;

  final IChatRepository chatRepository;
  final Rx<TextModel?> sharedText;
  final TextEditingController textEdittingController = TextEditingController();
  late IrisCryptr crypto;
  int offset = 0;

  int searchOffset = 0;
  String cursor = '';
  RxBool isSending = false.obs;
  Rx<Collection?> currentCollection$ = Rx<Collection?>(null);

  RxList<TextModel?> inboxList$ = <TextModel>[].obs;
  RxList<TextModel?> selectedInbox$ = <TextModel>[].obs;
  final displayItemList$ = [].obs;

  RxList<User> followerList$ = <User>[].obs;

  RxList<User> selectedFollowerList$ = <User>[].obs;
  RxBool loadingInbox = false.obs;

  // to check if loading finished
  RxBool loadingFollower = false.obs;
  bool hasMoreFollower = true;
  bool isResultFromSearch = false;
  IAuthUserService authUserStore = Get.find();

  // int messages
  ShareTextController(
      {required this.inboxRepository,
      required this.chatRepository,
      required this.sharedText}) {
    loadData();
  }

  directShare(int userKey, {String icon = ''}) async {
    var message = textEdittingController.text;
    if (icon != '') {
      message = icon;
    }
    if (message == '') return;
    final Collection? collection = await chatRepository
        .privateMessageCollectionFindOrCreate(userKey: userKey);
    final encryptionCode = collection!.collectionGuardedInfo!.encryptionCode!;
    crypto = IrisCryptr(secret: encryptionCode);
    await chatRepository.sendMessage(
      value: await crypto.encrypt(message),
      textType: TEXT_TYPE.MESSAGE,
      sharedTextKey: sharedText.value!.textKey,
      collectionKey: collection.collectionKey,
      isEncrypted: true,
    );
  }

  RxList getDisplayItems() {
    final int? textAuthorUserKey =
        sharedText.value!.user != null ? sharedText.value!.user!.userKey : null;
    final sharedTextType = sharedText.value!.textType;
    if (loadingInbox.value) {
      if (inboxList$.isNotEmpty) {
        final containedIndex = inboxList$.firstWhere(
            (inbox) => getUser(inbox!)!.userKey == textAuthorUserKey,
            orElse: () => const TextModel());
        if (containedIndex!.textKey != null) {
          inboxList$.remove(containedIndex);
          inboxList$.insert(0, containedIndex);
          displayItemList$.assignAll(inboxList$);
        } else if (textAuthorUserKey != null) {
          if (!isResultFromSearch &&
              sharedTextType == TEXT_TYPE.ORDER &&
              textAuthorUserKey != authUserStore.loggedUser?.userKey) {
            displayItemList$.assign(sharedText.value!.user);
            displayItemList$.addAll(inboxList$);
          } else {
            displayItemList$.assignAll(inboxList$);
          }
        } else {
          displayItemList$.assignAll(inboxList$);
        }
        return displayItemList$;
      } else {
        if (loadingFollower.value) {
          final containedIndex = followerList$.firstWhere(
              (user) => user.userKey == textAuthorUserKey,
              orElse: () => const User());
          if (containedIndex.userKey != null) {
            followerList$.remove(containedIndex);
            followerList$.insert(0, containedIndex);
            displayItemList$.assignAll(followerList$);
          } else if (textAuthorUserKey != null) {
            if (!isResultFromSearch &&
                sharedTextType == TEXT_TYPE.ORDER &&
                textAuthorUserKey != authUserStore.loggedUser?.userKey) {
              displayItemList$.assign(sharedText.value!.user!);
              displayItemList$.addAll(followerList$);
            } else {
              displayItemList$.assignAll(followerList$);
            }
          } else {
            displayItemList$.assignAll(followerList$);
          }
          return displayItemList$;
        }
      }
    }
    return displayItemList$;
  }

  User? getUser(TextModel inboxItem) {
    if (inboxItem.collection!.currentUsers != null &&
        inboxItem.collection!.currentUsers!.isNotEmpty) {
      return inboxItem.collection!.currentUsers![0];
    } else {
      return inboxItem.user;
    }
  }

  isSelected(dynamic inbox) {
    if (inbox is TextModel) {
      return selectedInbox$.contains(inbox);
    } else if (inbox is User) {
      return selectedFollowerList$.contains(inbox);
    }
  }

  loadData() async {
    onLoadPrimary();
    onLoadFollowers();
  }

  Future<void> loadMore() async {
    await onLoadPrimary(queryType: QueryType.loadMore);
  }

  Future<void> loadMoreFollower() async {
    await onLoadFollowers(queryType: QueryType.loadMore);
  }

  onClick(dynamic inbox) {
    if (inbox is TextModel) {
      if (selectedInbox$.contains(inbox)) {
        selectedInbox$.remove(inbox);
      } else {
        selectedInbox$.add(inbox);
      }
    } else if (inbox is User) {
      if (selectedFollowerList$.contains(inbox)) {
        selectedFollowerList$.remove(inbox);
      } else {
        selectedFollowerList$.add(inbox);
      }
    }
  }

  void onError(err) {
    IrisExceptionHandler.show(ShareTextException());
  }

  Future<void> onLoadFollowers(
      {QueryType queryType = QueryType.loadCache, String searchTerm = ''}) {
    return inboxRepository.relevantUsersSearch(
        callback: queryType == QueryType.loadMore
            ? onLoadMoreFollowers
            : onSuccessFollowers,
        onError: onError,
        offset: searchOffset,
        limit: 15,
        queryType: queryType,
        searchText: searchTerm);
  }

  void onLoadMore(MessagesGetRecentResponse serverResponse) {
    if (serverResponse.nextCursor?.isNotEmpty ?? false) {
      cursor = serverResponse.nextCursor!;
      inboxList$.addAll(serverResponse.messages ?? []);
    }
  }

  void onLoadMoreFollowers(List<User> serverResponse) {
    if (hasMoreFollower) {
      if (serverResponse.isNotEmpty) {
        followerList$.addAll(serverResponse);
      }

      if (serverResponse.length == 15) {
        searchOffset += 15;
        hasMoreFollower = true;
      } else {
        hasMoreFollower = false;
      }
    }
  }

  Future<void> onLoadPrimary({QueryType queryType = QueryType.loadCache}) {
    return inboxRepository.loadPrimary(
      callback: queryType == QueryType.loadMore ? onLoadMore : onSuccess,
      onError: onError,
      cursor: cursor,
      queryType: queryType,
    );
  }

  Future<void> onSearch(String searchTerm) async {
    searchOffset = 0;
    cursor = '';
    selectedInbox$.clear();
    selectedFollowerList$.clear();
    inboxList$.clear();
    followerList$.clear();
    hasMoreFollower = true;
    if (searchTerm != '') {
      isResultFromSearch = true;
      await onLoadFollowers(searchTerm: searchTerm);
    } else {
      isResultFromSearch = false;
      loadData();
    }
  }

  void onSuccess(MessagesGetRecentResponse serverResponse) {
    final nextCursor = serverResponse.nextCursor ?? '';
    final messages = serverResponse.messages ?? [];
    if (serverResponse.nextCursor != '') {
      cursor = nextCursor;
    }

    inboxList$.assignAll(messages);
    loadingInbox.value = true;
  }

  void onSuccessFollowers(List<User> serverResponse) {
    if (serverResponse.isNotEmpty && hasMoreFollower) {
      followerList$.assignAll(serverResponse);
      if (serverResponse.length == 15) {
        searchOffset += 15;
        hasMoreFollower = true;
      } else {
        hasMoreFollower = false;
      }
    } else if (serverResponse.isEmpty) {
      followerList$.clear();
      hasMoreFollower = false;
    }

    loadingFollower.value = true;
  }

  Future<void> share() async {
    // no inbox selected
    if (selectedInbox$.isEmpty && selectedFollowerList$.isEmpty) {
      return;
    }
    isSending.value = true;
    exitWithTimeout();
    final message = textEdittingController.text;

    final List<int> userKeys =
        selectedFollowerList$.map((user) => user.userKey!).toList();

    final List<Collection> collections =
        selectedInbox$.map((element) => element!.collection!).toList();
    for (final userKey in userKeys) {
      final Collection? collection = await chatRepository
          .privateMessageCollectionFindOrCreate(userKey: userKey);
      final encryptionCode = collection!.collectionGuardedInfo!.encryptionCode!;
      crypto = IrisCryptr(secret: encryptionCode);
      await chatRepository.sendMessage(
        value: await crypto.encrypt(message),
        textType: TEXT_TYPE.MESSAGE,
        sharedTextKey: sharedText.value!.textKey,
        collectionKey: collection.collectionKey,
        isEncrypted: true,
      );
    }

    for (final collection in collections) {
      final encryptionCode = collection.collectionGuardedInfo!.encryptionCode!;
      crypto = IrisCryptr(secret: encryptionCode);
      await chatRepository.sendMessage(
        value: await crypto.encrypt(message),
        textType: TEXT_TYPE.MESSAGE,
        sharedTextKey: sharedText.value!.textKey,
        collectionKey: collection.collectionKey,
        isEncrypted: true,
      );
    }
    // isSending.value = false;
    // Get.back();
  }

  Future<void> exitWithTimeout() async {
    Future.delayed(const Duration(milliseconds: 700)).then((_) => Get.back());
  }
}

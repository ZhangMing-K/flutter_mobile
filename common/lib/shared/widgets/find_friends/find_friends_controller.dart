import 'package:get/get.dart';

import '../../../iris_common.dart';

class FindFriendsController extends GetxController {
  Rx<API_STATUS> apiStatus$ = Rx(API_STATUS.NOT_STARTED);
  final UserService userService = Get.find();
  final FollowService followService = Get.find();
  final bool selectAllByDefault;
  int offset = 0;
  bool recomended;
  RxInt nbrUsersFromContacts$ = 0.obs;
  final IAuthUserService authUserStore = Get.find();
  RxList<User> userContacts$ = RxList([]);
  RxList<int?> selectedUserKeys$ = RxList([]);
  Function? onNextCallBack;
  Function? onEmptyCallback;
  RxBool isEmpty$ = RxBool(false);
  FindFriendsController({
    this.onNextCallBack,
    this.onEmptyCallback,
    this.selectAllByDefault = false,
    this.recomended = false,
  });

  addOrRemovePortfolio(int? userKey) {
    final bool contains = selectedUserKeys$.contains(userKey);
    if (contains) {
      selectedUserKeys$.removeWhere((key) => key == userKey);
    } else {
      selectedUserKeys$.add(userKey);
    }
  }

  getUserContacts() async {
    final authUserKey = authUserStore.loggedUser!.userKey;
    final User? user = await userService.getUserByKey(
        userKey: authUserKey, requestedFields: userRequestedFields());
    if (user == null) return;
    final List<User> allContacts = [
      ...userContacts$,
      ...user.usersFromContacts!
    ];

    isEmpty$.value = user.nbrUsersFromContacts! < 1 || allContacts.isEmpty;
    nbrUsersFromContacts$.value = user.nbrUsersFromContacts!;
    userContacts$.clear();
    userContacts$.assignAll(allContacts);

    if (userContacts$.isEmpty && onEmptyCallback != null) {
      isEmpty$.value = true;
      if (onEmptyCallback != null) onEmptyCallback!();
    }
    if (selectAllByDefault) {
      for (User contact in userContacts$) {
        if (!selectedUserKeys$.contains(contact.userKey)) {
          addOrRemovePortfolio(contact.userKey);
        }
      }
    }
  }

  Future<void> loadMore() async {
    offset += 10;
    await getUserContacts();
  }

  @override
  void onInit() {
    onPage();
    super.onInit();
  }

  onPage() async {
    apiStatus$.value = API_STATUS.PENDING;
    await getUserContacts();
    apiStatus$.value = API_STATUS.FINISHED;
  }

  submit() async {
    if (selectedUserKeys$.isNotEmpty) {
      await followService.bulkRequestToFollowType(
          entityType: FOLLOW_REQUEST_ENTITY_TYPE.USER,
          lookupKeys: selectedUserKeys$);
    }

    if (onNextCallBack != null) onNextCallBack!();
  }

  userRequestedFields() {
    return '''
       userKey
       nbrUsersFromContacts(input:{recomended:false})
       usersFromContacts(input: {limit: 10, offset: $offset, recomended: $recomended}) {
        userKey
        firstName
        lastName
        description
        profilePictureUrl
        connectedBrokerNames
      }
    ''';
  }
}

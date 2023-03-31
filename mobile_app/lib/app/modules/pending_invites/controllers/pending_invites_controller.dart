import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

const String REMINDER_TEXT =
    'Hey, did you get my Iris invite? Here is the link:  ';

class PendingInvitesController extends GetxController {
  RxList<UserContact> pendingInvites$ = RxList([]);
  final UserContactService userContactService = Get.find();
  final IAuthUserService authUserStore = Get.find();
  Rx<API_STATUS> apiStatus$ = Rx(API_STATUS.NOT_STARTED);
  RxBool noPendingInvites$ = RxBool(false);
  int offset = 0;
  final UserService userService = Get.find();
  String? inviteLink;

  getUserPendingInvites() async {
    final authUserKey = authUserStore.loggedUser?.userKey;
    final User? user = await userService.getUserByKey(
        userKey: authUserKey, requestedFields: userRequestedFields());

    if (user == null) return;

    final List<UserContact> allPendingInvites = [
      ...pendingInvites$,
      ...user.userContactsToInvite!,
    ];

    pendingInvites$.clear();
    pendingInvites$.assignAll(allPendingInvites);
  }

  Future<void> loadMore() async {
    offset += 10;
    await getUserPendingInvites();
  }

  @override
  onInit() {
    onPage();
    inviteLink = authUserStore.loggedUser!.inviteLink;

    super.onInit();
  }

  onPage() async {
    apiStatus$.value = API_STATUS.PENDING;
    await getUserPendingInvites();

    noPendingInvites$.value = pendingInvites$.isEmpty;
    apiStatus$.value = API_STATUS.FINISHED;
  }

  sendReminder({required UserContact contact}) async {
    final String message = REMINDER_TEXT + inviteLink!;
    userContactService.sendMessageToContact(
        contactType: contact.contactType,
        contactValue: contact.contactValue,
        message: message);
  }

  userRequestedFields() {
    return '''
      userContactsToInvite(input:{limit:10, offset:$offset, inviteAlreadySent:true}) {
        userContactKey
        firstName
        lastName
        contactType
        contactValue
        friendCount
        sentInviteAt
      }
    ''';
  }
}

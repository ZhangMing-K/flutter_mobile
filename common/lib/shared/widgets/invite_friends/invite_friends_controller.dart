import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../iris_common.dart';

const DEFAULT_EMPTY_TEXT = "Sorry :( you haven't synced your contacts yet";

const EMPTY_TEXT_AFTER_SYNC =
    'We are having trouble syncing your contacts.  Make sure you enable access in your settings';
Iterable<List<T>> chunk<T>(List<T> lst, int n) sync* {
  final gen = List.generate(lst.length ~/ n + 1, (e) => e * n);
  for (int i in gen) {
    if (i < lst.length) {
      yield lst.sublist(i, i + n < lst.length ? i + n : lst.length);
    }
  }
}

class InviteFriendsController extends GetxController {
  Function? onNextCallBack;
  final AuthService authService = Get.find();
  String? inviteLink;
  final IAuthUserService authUserStore = Get.find();
  final UserContactService userContactService = Get.find();
  RxList<UserContact> userContacts$ = RxList([]);
  Rx<API_STATUS> apiStatus$ = Rx(API_STATUS.NOT_STARTED);
  Rx<API_STATUS> searchApiStatus$ = Rx(API_STATUS.NOT_STARTED);
  final UserService userService = Get.find();
  RxBool isEmpty$ = RxBool(false);
  RxInt numberOfPendingInvites$ = RxInt(0);
  RxString searchTerm$ = RxString('');
  RxBool noContacts$ = RxBool(false);
  RxString emptyText$ = RxString(DEFAULT_EMPTY_TEXT);
  int offset = 0;
  Workers? workers;
  final RxBool canOpen = false.obs;

  InviteFriendsController({this.onNextCallBack});

  getUserContacts() async {
    final authUserKey = authUserStore.loggedUser!.userKey;
    final User? user = await userService.getUserByKey(
        userKey: authUserKey, requestedFields: userRequestedFields());
    if (user != null) {
      numberOfPendingInvites$.value = user.nbrUserContactsToInvite!;
      final List<UserContact> allContacts = [
        ...userContacts$,
        ...user.userContactsToInvite!
      ];
      userContacts$.assignAll(allContacts);
    }
  }

  invite({required UserContact contact}) async {
    final String message = DEFAULT_INVITATION_TEXT + inviteLink!;
    userContactService.sendMessageToContact(
        contactType: contact.contactType,
        contactValue: contact.contactValue,
        message: message);
    await userContactService.sendContactInvite(
        userContactKey: contact.userContactKey);

    removeContactFromList(contact.userContactKey);
    numberOfPendingInvites$.value++;
  }

  Future<void> loadMore() async {
    offset += 10;
    await getUserContacts();
  }

  @override
  onInit() {
    inviteLink = authUserStore.loggedUser!.inviteLink;

    workers = Workers([
      ever<bool>(canOpen, (val) {
        if (val) {
          syncContacts(onLoad: true);
        } else {
          Get.back();
        }
      }),
      ever(searchTerm$, onSearchEvent),
    ]);

    requestContacts();
    super.onInit();
  }

  onSearchEvent(String searchTerm) async {
    offset = 0;
    userContacts$.clear();
    searchApiStatus$.value = API_STATUS.PENDING;
    await getUserContacts();
    searchApiStatus$.value = API_STATUS.FINISHED;
  }

  removeContactFromList(int? userContactKey) {
    final List<UserContact> contacts = userContacts$
        .where((uc) => uc.userContactKey != userContactKey)
        .toList();
    userContacts$.clear();
    userContacts$.assignAll(contacts);
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.permanentlyDenied;
    } else {
      return permission;
    }
  }

  Future<void> requestContacts() async {
    if (GetPlatform.isAndroid) {
      final PermissionStatus permissionStatus = await _getPermission();
      if (permissionStatus == PermissionStatus.granted) {
        canOpen(true);
      } else {
        //If permissions have been denied show standard cupertino alert dialog
        Get.dialog(CupertinoAlertDialog(
          title: const Text('Permissions error'),
          content: const Text('Please enable contacts access '
              'permission in system settings'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Get.back(),
            )
          ],
        ));
      }
    } else {
      canOpen(true);
    }
  }

  submit() async {
    onNextCallBack!();
  }

  syncContacts({bool? onLoad}) async {
    try {
      apiStatus$.value = API_STATUS.PENDING;
      isEmpty$.value = false;
      final Iterable<Contact> contacts = await ContactsService.getContacts();
      final List<Contact> contactsList = contacts.toList();
      if (contactsList.isNotEmpty) {
        final List<UserContactInput> args =
            userContactService.transformContacts(contacts: contactsList);

        final chunks = chunk(args, 600).toList();
        final List<Future> futures = [];
        for (var c in chunks) {
          futures
              .add(userContactService.userContactSyncBase64(userContacts: c));
        }
        await Future.wait(futures);
      } else if (onLoad != true) {
        emptyText$.value = EMPTY_TEXT_AFTER_SYNC;
      }
    } catch (err) {
      Get.snackbar('Error', 'There was an issue syncing contacts: $err',
          duration: const Duration(seconds: 3));
    }
    await getUserContacts();
    noContacts$.value = userContacts$.isEmpty;
    apiStatus$.value = API_STATUS.FINISHED;
  }

  userRequestedFields() {
    final String value = searchTerm$.value;
    final String nameFragment = value.isNotEmpty ? 'name: "$value"' : '';

    return '''
      nbrUserContactsToInvite(input:{inviteAlreadySent:true})
      userContactsToInvite(input:{limit:10, offset:$offset, $nameFragment}) {
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

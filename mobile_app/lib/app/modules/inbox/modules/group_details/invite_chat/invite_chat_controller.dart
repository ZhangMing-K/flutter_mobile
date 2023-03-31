import 'package:azlistview/azlistview.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:iris_common/iris_common.dart';

import '../../groupchat/contact_model.dart';

class InviteChatController extends GetxController {
  final IChatRepository chatRepository;
  final int collectionKey;
  final List<int> excludeKeys;
  final Function onAddInvite;
  final IAuthUserService authUserStore;

  // int messages
  final CollectionService collectionService;
  final List<ContactInfo> contacts$ = <ContactInfo>[].obs;
  final List<ContactInfo> selectedContacts$ = <ContactInfo>[].obs;
  final List<List<ContactInfo>> groupedContacts$ = <List<ContactInfo>>[].obs;
  final List<ContactInfo> originalContacts = [];
  Rx<NEW_GROUP_CHAT_STATUS> status$ = NEW_GROUP_CHAT_STATUS.NEW.obs;
  String groupName = '';
  Rx<ReturnTextInfo?> returnTextInfo$ = Rx(null);

  // return text
  final Events events = Get.find();
  InviteChatController({
    required this.chatRepository,
    required this.collectionKey,
    required this.excludeKeys,
    required this.onAddInvite,
    required this.authUserStore,
    required this.collectionService,
  }) {
    loadData();
  }

  clickContact(ContactInfo contact) {
    if (isSelected(contact)) {
      selectedContacts$.remove(contact);
    } else {
      selectedContacts$.add(contact);
    }
  }

  getAccountFollowingRequest() {
    return '''
      userKey
      firstName
      lastName
      accountsFollowing{
        userKey
        firstName
        lastName
        profilePictureUrl
        connectedBrokerNames
      }
    ''';
  }

  String getNameTag(User user) {
    if (user.fullName.length <= 1) {
      return '';
    }
    return user.fullName.substring(0, 1).toUpperCase();
  }

  List<ContactInfo> getSelectedList(ContactInfo model) {
    return selectedContacts$.where((c) => c == model).toList();
  }

  isSelected(ContactInfo contact) {
    final lists = selectedContacts$.where((c) => c == contact).toList();
    if (lists.isNotEmpty && lists[0] == contact) {
      return true;
    }
    return false;
  }

  loadData() async {
    status$.value = NEW_GROUP_CHAT_STATUS.NEW;
    final Repository repository = Repository(
        local: chatRepository.getAuthUser(
            requestedFields: getAccountFollowingRequest(),
            fetchPolicy: FetchPolicy.cacheFirst),
        remote: chatRepository.getAuthUser(
            requestedFields: getAccountFollowingRequest(),
            fetchPolicy: FetchPolicy.networkOnly));
    repository.getResponse((userInfo) {
      List<User> accountsFollowing = userInfo!.accountsFollowing!;
      accountsFollowing = accountsFollowing
          .where((element) => !excludeKeys.contains(element.userKey!))
          .toList();
      accountsFollowing.sort((a, b) {
        if (nameMatchTag(getNameTag(a)) && nameMatchTag(getNameTag(b))) {
          return a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase());
        } else if (nameMatchTag(getNameTag(a)) &&
            !nameMatchTag(getNameTag(b))) {
          return -1;
        }
        return 1;
      });
      final List<ContactInfo> arr =
          accountsFollowing.map((v) => ContactInfo.setUser(v)).toList();
      originalContacts.assignAll(arr);
      _handleList(arr);
    });
  }

  bool nameMatchTag(String nameTag) {
    return RegExp('[A-Z]').hasMatch(nameTag);
  }

  onBack() {
    Get.back();
  }

  onInvite() {
    if (selectedContacts$.isEmpty) {
      Get.snackbar('Error', 'Please select contacts to invite');
      return;
    }
    final List<int> userKeys =
        selectedContacts$.map((element) => element.user!.userKey!).toList();
    onAddInvite(userKeys);
  }

  search(String text) {
    if (text.isEmpty) {
      _handleList(originalContacts);
    } else {
      final List<ContactInfo> list = originalContacts
          .where((v) =>
              v.user!.fullName.toLowerCase().contains(text.toLowerCase()))
          .toList();

      _handleList(list);
    }
  }

  _handleList(List<ContactInfo> list) {
    for (int i = 0, length = list.length; i < length; i++) {
      // final String tag = list[i].user!.fullName.substring(0, 1).toUpperCase();
      final String tag = getNameTag(list[i].user!);
      if (RegExp('[A-Z]').hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = '#';
      }
    }
    contacts$.assignAll(list);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(contacts$);

    // add header.
    contacts$.insert(0, ContactInfo(tagIndex: ''));

    // grouping contacts with susTag.
    final groups = groupBy(contacts$, (ContactInfo e) {
      return e.tagIndex;
    });
    final values = groups.values;
    groupedContacts$.clear();
    for (var element in values) {
      groupedContacts$.add(element);
    }
  }
}

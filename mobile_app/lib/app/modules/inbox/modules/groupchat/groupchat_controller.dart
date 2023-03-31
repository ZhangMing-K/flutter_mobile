import 'dart:typed_data';

import 'package:azlistview/azlistview.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:iris_common/iris_common.dart';

import '../../controllers/inbox_controller.dart';
import 'contact_model.dart';

class GroupChatController extends GetxController {
  final IChatRepository chatRepository = Get.find();
  final IAuthUserService authUserStore = Get.find();

  // int messages

  //TODO: Move it to Bindings

  final InboxController inboxController = Get.find();
  final List<ContactInfo> contacts$ = <ContactInfo>[].obs;

  final List<ContactInfo> selectedContacts$ = <ContactInfo>[].obs;
  final List<List<ContactInfo>> groupedContacts$ = <List<ContactInfo>>[].obs;
  final List<ContactInfo> originalContacts = [];
  final Rx<NEW_GROUP_CHAT_STATUS> status$ = NEW_GROUP_CHAT_STATUS.NEW.obs;
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  String groupName = ''; // form key for group name and description
  String groupDescription = '';

  Rx<http.MultipartFile?> fileUpload$ =
      Rx<http.MultipartFile?>(null); // image picker
  Rx<Uint8List?> groupAvatar$ = Rx<Uint8List?>(null); // group chat picture
  final RxBool isPublic = true.obs; // image widget to show

  final Rx<ReturnTextInfo?> returnTextInfo$ = Rx<ReturnTextInfo?>(null);

  // return text
  final Events events = Get.find();
  final MediaPickController mediaPickController = MediaPickController();

  List<User> get listUsers =>
      List<User>.from(selectedContacts$.map((contact) => contact.user!));

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
      username
      accountsFollowing{
        userKey
        firstName
        lastName
        username
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

  User? getUser(text) {
    if (text.value.collection!.currentUsers != null) {
      return text.value.collection!.currentUsers![0];
    } else {
      return text.value.user;
    }
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
      final List<User> accountsFollowing = userInfo!.accountsFollowing!;
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
    if (status$.value == NEW_GROUP_CHAT_STATUS.CREATE) {
      // back
      status$.value = NEW_GROUP_CHAT_STATUS.PARTICIPANTS;
    } else {
      Get.back();
    }
  }

  onClickNewGroup() {
    status$.value = NEW_GROUP_CHAT_STATUS.PARTICIPANTS;
  }

  onClickNext() async {
    if (status$.value == NEW_GROUP_CHAT_STATUS.PARTICIPANTS) {
      if (selectedContacts$.isNotEmpty) {
        status$.value = NEW_GROUP_CHAT_STATUS.CREATE;
      } else {
        Get.snackbar(
          'Error', // title
          'Please add at least one participant !',
          colorText: Colors.red,
          shouldIconPulse: true,
          barBlur: 20,
          isDismissible: true,
          duration: const Duration(seconds: 3),
        );
      }
    } else if (status$.value == NEW_GROUP_CHAT_STATUS.CREATE) {
      // create
      final userKeys =
          selectedContacts$.map((contact) => contact.user!.userKey).toList();

      if (fbKey.currentState!.saveAndValidate()) {
        final mapValues = fbKey.currentState!.value;
        final groupName = mapValues['groupName'];
        final groupDescription = mapValues['groupDescription'];

        final Collection? collection = await chatRepository.createCollection(
          groupName: groupName,
          description: groupDescription ?? '',
          userKeys: userKeys,
          pictureUpload: fileUpload$.value,
        );

        Get.back();
        if (collection == null) {
          Get.snackbar(
            'Error', // title
            'Something wrong creating group chat !',
            colorText: Colors.red,
            shouldIconPulse: true,
            barBlur: 20,
            isDismissible: true,
            duration: const Duration(seconds: 3),
          );
          return;
        }
        // need this for only currentUser
        final Rx<TextModel> text = TextModel(
                textCreateId: DateTime.now().millisecondsSinceEpoch,
                //This is so we can locate it later
                value: '',
                textType: TEXT_TYPE.GROUP_MESSAGE,
                collection: collection,
                user: authUserStore.loggedUser,
                orderedCreatedAt: DateTime.now())
            .obs;

        /// If the user has not sent messages to the newly created
        /// chat and lost it by accident, this will cause the newly
        /// created chat to appear in their chat list
        inboxController.insertOrUpdateConversationList(text);

        final id = uuid.v4();
        final args = ChatArgs(
          encryptionCode:
              text.value.collection!.collectionGuardedInfo?.encryptionCode ??
                  '',
          avatarUrl: getUser(text)!.profilePictureUrl ?? '',
          chatname: (text.value.collection!.collectionType ==
                      COLLECTION_TYPE.PRIVATE_MESSAGE
                  ? getUser(text)!.fullName
                  : text.value.collection!.name) ??
              '',
          id: id,
          message: text,
        );

        await Get.toNamed(
            Paths.Feed +
                Paths.Home +
                Paths.MessageCollection.createPath([collection.collectionKey]),
            arguments: args,
            id: 1);
        // inboxController.markSeenById(collection.collectionKey!);
      }
    }
  }

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  pickImage() async {
    mediaPickController.pickMedia(() async {
      try {
        final image = await mediaPickController.getImage();
        if (image == null) {
          return;
        }
        final croppedImage =
            await mediaPickController.cropImage(imageFile: image);
        final Uint8List bytes = croppedImage != null
            ? await croppedImage.readAsBytes()
            : await image.readAsBytes();

        final http.MultipartFile multiPartFile = http.MultipartFile.fromBytes(
          'photo',
          bytes,
          filename: '${DateTime.now().second}.jpg',
          contentType: MediaType('image', 'jpg'),
        );
        groupAvatar$.value = bytes;
        fileUpload$.value = multiPartFile;
      } catch (e) {
        debugPrint('e: $e');
      }
    });
  }

  search(String text) {
    if (text.isEmpty) {
      _handleList(originalContacts);
    } else {
      final List<ContactInfo> list = originalContacts
          .where((v) =>
              v.user!.fullName.toLowerCase().contains(text.toLowerCase()) ||
              (v.user!.displayName.toLowerCase().contains(text.toLowerCase())))
          .toList();
      _handleList(list);
    }
  }

  toPrivateChat(ContactInfo contact) async {
    // close modal first

    final Collection? collection = await chatRepository
        .privateMessageCollectionFindOrCreate(userKey: contact.user!.userKey);
    Get.back();
    if (collection == null) {
      Get.snackbar(
        'Error', // title
        'Something wrong creating chat !',
        colorText: Colors.red,
        shouldIconPulse: true,
        barBlur: 20,
        isDismissible: true,
        duration: const Duration(seconds: 3),
      );
      return;
    }
    final Rx<TextModel> text = TextModel(
            textCreateId: DateTime.now().millisecondsSinceEpoch,
            //This is so we can locate it later
            value: '',
            textType: TEXT_TYPE.MESSAGE,
            collection: collection,
            user: authUserStore.loggedUser,
            orderedCreatedAt: DateTime.now())
        .obs;
    //inboxController.onAddCollectionEvent(text);

    final id = uuid.v4();
    final args = ChatArgs(
      encryptionCode: collection.collectionGuardedInfo!.encryptionCode!,
      avatarUrl: getUser(text)!.profilePictureUrl ?? '',
      chatname: (text.value.collection!.collectionType ==
                  COLLECTION_TYPE.PRIVATE_MESSAGE
              ? getUser(text)!.fullName
              : text.value.collection!.name) ??
          '',
      id: id,
      message: text,
    );

    await Get.toNamed(
        Paths.Feed +
            Paths.Home +
            Paths.MessageCollection.createPath([collection.collectionKey]),
        arguments: args,
        id: 1);
    //inboxController.markSeenById(collection.collectionKey!);
  }

  _handleList(List<ContactInfo> list) {
    for (int i = 0, length = list.length; i < length; i++) {
      final userFullName = list[i].user!.fullName;
      if (userFullName.length <= 1) {
        //this is to prevent an error if the name has less than 1 char
        list[i].tagIndex = '#';
        continue;
      }
      final String tag = userFullName.substring(0, 1).toUpperCase();
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

    groupedContacts$.assignAll(groups.values);
  }
}

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:iris_common/iris_common.dart';

import '../../controllers/inbox_controller.dart';
import 'invite_chat/invite_chat_controller.dart';
import 'invite_chat/invite_chat_view.dart';

class GroupDetailsController extends GetxController {
  final IChatRepository repository;

  final InboxController inboxController;
  final IAuthUserService authUserStore;
  MediaPickController mediaPicController = MediaPickController();
  int? collectionKey;

  String? id;

  final connectedPortfolios = 'Not connected'.obs;

  final _localCollection = Rxn<Collection>();

  GroupDetailsController({
    required this.repository,
    required this.inboxController,
    required this.authUserStore,
  });

  String get avatarUrl {
    if (isPrivateMessage) {
      if (currentUsers.isEmpty) {
        return '';
      }
      return currentUsers.first.profilePictureUrl ?? '';
    } else {
      return getCollection?.pictureUrl ?? '';
    }
  }

  List<User> get currentUsers {
    return getCollection?.currentUsers ??
        _localCollection.value?.currentUsers ??
        <User>[];
  }

  String get getAvatar {
    return getCollection?.currentUsers?.first.profilePictureUrl ?? '';
  }

  Collection? get getCollection {
    return getTextCollection?.value.collection;
  }

  List<User> get getCurrentUsers {
    return <User>[
      if (getCollection?.currentUsers != null) ...getCollection!.currentUsers!,
      ...[authUserStore.loggedUser!]
    ];
  }

  USER_RELATION_NOTIFICATION_AMOUNT get getNotificationAmount {
    final amount = getCollection?.authUserRelation?.notificationAmount;
    return (amount != null) ? amount : USER_RELATION_NOTIFICATION_AMOUNT.NONE;
  }

  Rx<TextModel>? get getTextCollection {
    return inboxController.getTextByCollectionKey(collectionKey!);
  }

  bool get isNotificationsOn {
    return getNotificationAmount == USER_RELATION_NOTIFICATION_AMOUNT.ALL;
  }

  bool get isPrivateMessage {
    final type = getCollection?.collectionType;
    if (type == null) return true;
    return type == COLLECTION_TYPE.PRIVATE_MESSAGE;
  }

  int get numberOfCurrentUsers {
    return getCollection!.numberOfCurrentUsers ?? 0;
  }

  String get status {
    final info = getCollection;
    if (isPrivateMessage) {
      return '';
    } else {
      return info?.description ?? '';
    }
  }

  String get username {
    if (isPrivateMessage) {
      if (currentUsers.isEmpty) {
        return Fallback.user.fullName;
      }
      return currentUsers.first.fullName;
    } else {
      return getCollection?.name ?? '';
    }
  }

  Future<void> changeDescription(String text) async {
    if (text.isEmpty) return;
    if (text == getCollection?.description) return;

    repository.updateGroupInfo(
      collectionKey: collectionKey,
      groupName: getCollection?.name ?? '',
      description: text,
      callback: (data) {
        if (data is Collection && getTextCollection != null) {
          getTextCollection!.value = getTextCollection!.value.copyWith(
              collection:
                  getCollection?.copyWith(description: data.description));
        }
      },
      onError: onError,
    );
  }

  Future<void> changeGroupName(String text) async {
    if (text.isEmpty) return;
    if (text == getCollection?.name) return;

    repository.updateGroupInfo(
      collectionKey: collectionKey,
      groupName: text,
      description: getCollection?.description ?? '',
      callback: (data) {
        if (data is Collection && getTextCollection != null) {
          getTextCollection!.value = getTextCollection!.value
              .copyWith(collection: getCollection?.copyWith(name: data.name));
        }
      },
      onError: onError,
    );
  }

  Future<void> changeProfilePic() async {
    final groupPic = await getImage();
    if (groupPic == null) return;

    await overlayLoader(
      context: Get.overlayContext!,
      asyncFunction: () async {
        await repository.updateGroupInfo(
          collectionKey: collectionKey,
          groupName: getCollection?.name ?? '',
          groupPic: groupPic,
          description: getCollection?.description ?? '',
          callback: (data) {
            if (data is Collection && getTextCollection != null) {
              getTextCollection!.value = getTextCollection!.value.copyWith(
                  collection:
                      getCollection?.copyWith(pictureUrl: data.pictureUrl));
            }
          },
          onError: onError,
        );
      },
      opacity: .8,
      loaderColor: IrisColor.primaryColor,
    );
  }

  Future<http.MultipartFile?> getImage() async {
    try {
      final image = await mediaPicController.getImage();
      if (image == null) {
        return null;
      }
      final croppedImage = await mediaPicController.cropImage(imageFile: image);

      final Uint8List bytes = croppedImage != null
          ? await croppedImage.readAsBytes()
          : await image.readAsBytes();

      return http.MultipartFile.fromBytes(
        'photo',
        bytes,
        filename: '${DateTime.now().second}.jpg',
        contentType: MediaType('image', 'jpg'),
      );
    } catch (err) {
      debugPrint(err.toString());
    }
    return null;
  }

  Future<void> onAddInvite(List<int> userKeys) async {
    final collectionRequest = await repository.collectionAddEntities(
        collectionKey: collectionKey,
        entityType: COLLECTION_REQUEST_ENTITY_TYPE.USER,
        entityKeys: userKeys);
    updateCollection();
    Get.back();
    if (collectionRequest.isEmpty) {
      Get.snackbar('Error', 'Invite failed');
    } else {
      Get.snackbar('Success', 'Invite sent successfully');
    }
  }

  void onError(err) {
    IrisExceptionHandler.show(GroupDetailsLoadException());
  }

  @override
  onInit() {
    if (Get.parameters['collectionKey'] != null &&
        Get.parameters['collectionKey'] != '') {
      collectionKey = int.tryParse(Get.parameters['collectionKey']!);
    }

    updateCollection();
    super.onInit();
  }

  void onLeaveChat() {
    repository.collectionRemoveEntities(
        collectionKey: collectionKey,
        entityType: COLLECTION_REQUEST_ENTITY_TYPE.USER,
        entityKeys: [authUserStore.loggedUser?.userKey]);
    inboxController.removeFromInbox(collectionKey: collectionKey!);
    Get.close(2);
  }

  Future<void> onRemoveUser(List<int> userKeys) async {
    // final collectionRequest =
    await repository.collectionRemoveEntities(
        collectionKey: collectionKey,
        entityType: COLLECTION_REQUEST_ENTITY_TYPE.USER,
        entityKeys: userKeys);
    Get.back();
    updateCollection();
  }

  void onShowInvitePage() {
    final List<int> excludeKeys =
        getCollection?.currentUsers?.map((e) => e.userKey!).toList() ?? [];

    ///TODO: WHY THIS CONTROLLER IS NOT ON BINDINGS??????
    final InviteChatController controller = InviteChatController(
      chatRepository: Get.find(),
      authUserStore: Get.find(),
      collectionService: Get.find(),
      collectionKey: collectionKey!,
      excludeKeys: excludeKeys,
      onAddInvite: onAddInvite,
    );
    Get.bottomSheet(
      DraggableScrollableSheet(
        minChildSize: 0.6,
        maxChildSize: 0.91,
        initialChildSize: 0.9,
        expand: true,
        builder: (context, scrollController) {
          return ChatInviteView(
              controller: controller, scrollController: scrollController);
        },
      ),
      isScrollControlled: true,
    );
  }

  void setAmount(USER_RELATION_NOTIFICATION_AMOUNT amount) {
    final relation =
        getTextCollection?.value.collection!.authUserRelation == null
            ? UserRelation(notificationAmount: amount)
            : getTextCollection!.value.collection!.authUserRelation!
                .copyWith(notificationAmount: amount);

    if (getTextCollection?.value != null) {
      getTextCollection!.value = getTextCollection!.value.copyWith(
          collection: getCollection!.copyWith(authUserRelation: relation));
    }
  }

  void setNotificationSetting(bool notificationSetting) {
    final amount = notificationSetting
        ? USER_RELATION_NOTIFICATION_AMOUNT.ALL
        : USER_RELATION_NOTIFICATION_AMOUNT.NONE;

    repository.setNotificationSettings(
        amountType: amount, collectionKeys: [collectionKey!]);
    Future.microtask(() => setAmount(amount));
  }

  void showRemoveConfirmation(String fullName, int userKey) {
    if (getCurrentUsers.length > 2) {
      Get.dialog(
        IrisDialog(
          title: 'Remove User',
          subtitle: 'Are you sure you want to remove $fullName?',
          confirmIsDestructive: true,
          confirmButtonText: 'Remove',
          onConfirm: () {
            Get.back();
            onRemoveUser([userKey]);
          },
          onCancel: () => Get.back(),
        ),
      );
    } else {
      Get.dialog(
        IrisDialog(
          title: 'Cannot Remove',
          subtitle: 'Can\'t remove the last user of a group',
          onCancel: () => Get.back(),
        ),
      );
    }
  }

  Future<void> updateCollection() async {
    await repository.getCollectionUsers(
      collectionKeys: [collectionKey],
      queryType: QueryType.loadRemote,
      callback: (collectionInfo) {
        final portfoliosConnected = collectionInfo
            .collectionGuardedInfo?.currentPortfoliosConnection?.portfolios;
        if (portfoliosConnected != null) {
          connectedPortfolios.value = '';
          for (var element in portfoliosConnected) {
            connectedPortfolios.value =
                connectedPortfolios.value + element.portfolioName! + '\n';
          }
        }

        ///UPDATE ONLY THIS DATA:
        final users = collectionInfo.currentUsers;

        _localCollection.value = collectionInfo;

        if (getTextCollection != null) {
          getTextCollection!.value = getTextCollection!.value.copyWith(
              collection: getTextCollection?.value.collection
                  ?.copyWith(currentUsers: users));
        }
      },
      userKeys: [authUserStore.loggedUser?.userKey],
      onError: onError,
    );
  }
}

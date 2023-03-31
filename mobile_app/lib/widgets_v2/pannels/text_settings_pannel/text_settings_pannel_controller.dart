import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/feed/controllers/feed_controller.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/post_input/post_input.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/text_card_controller.dart';
import 'package:iris_mobile/app/routes/pages.dart';

import 'text_setting_pannel_data.dart';

class TextSettingPannelController extends GetxController {
  //TODO: Make this final
  Rx<TextModel?>? text = const TextModel().obs;
  final RxBool shareView = false.obs;
  final Rx<Share?> shareLink = Rx<Share?>(null);

  final IAuthUserService authUserStore = Get.find();
  final BaseController baseController = Get.find();
  final FollowService followService = Get.find();
  final JediUserService jediUserService = Get.find();
  final TextService textService = Get.find();
  // final FeedStore feedStore = Get.find();
  final TextCardController? textCardController;
  final SocialService socialService = Get.find();
  UserRelationSerivce userRelationService = Get.find();
  final Events events = Get.find();
  TextSettingsPannelData? pannelData;

  Rx<FocusNode> focusNode$ = FocusNode().obs;

  TextSettingPannelController(this.textCardController);

  SHARE_TYPE get shareType {
    if (text?.value?.textType == TEXT_TYPE.ORDER) {
      return SHARE_TYPE.ORDER;
    } else if (text?.value?.textType == TEXT_TYPE.POST) {
      return SHARE_TYPE.POST;
    } else {
      return SHARE_TYPE.ORDER;
    }
  }

  closeBottomSheet() {
    debugPrint('closing bottomsheet');
    Get.back();
  }

  copy(context) async {
    final url = await generateLink();
    closeBottomSheet();
    if (url != null) {
      await FlutterClipboard.copy(url);
      Get.snackbar('Copied to your clipboard!', 'Share this!',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void deletePost() {
    Get.back();
    //events.textDelete(TextDeleteEvent(text: text!.value));
    textService.textDelete(textKey: text!.value!.textKey);
    if (text!.value!.textType == TEXT_TYPE.POST) {
      textCardController!.isVisible(false);
    } else if (text!.value!.textType == TEXT_TYPE.COMMENT) {
      textCardController!.onRemoveCommentEvent(text!.value);
    }
  }

  void editDDCard(Rx<TextModel?> text) {
    Get.toNamed(Paths.DDCardEdit, arguments: text);
  }

  Future<String?> generateLink() async {
    int? entityKey;
    if (text!.value!.textType == TEXT_TYPE.ORDER) {
      entityKey = text!.value!.order!.orderKey;
    } else if (text!.value!.textType == TEXT_TYPE.POST) {
      entityKey = text!.value!.textKey;
    }

    final Share? share = await socialService.shareCreate(
        entityKey: entityKey, shareType: shareType);
    return share?.url;
  }

  hideEntity(bool hide) async {
    USER_RELATION_ENTITY_TYPE? entityType;
    int? entityKey;
    User? user;

    if (text?.value?.textType == TEXT_TYPE.POST) {
      entityKey = text?.value?.user?.userKey;
      entityType = USER_RELATION_ENTITY_TYPE.USER;
      events.userHide(UserHideEvent(user: text?.value?.user));
    } else if (text?.value?.textType == TEXT_TYPE.ORDER) {
      entityKey = text?.value?.portfolioKey;
      entityType = USER_RELATION_ENTITY_TYPE.PORTFOLIO;
      events.portfolioHide(PortfolioHideEvent(
        text: text!.value,
      )); //scott refactor this to take in a portfolio object. message me to talk about this.
    }

    if (user != null && entityType == USER_RELATION_ENTITY_TYPE.USER) {}

    final UserRelation? authUserRelation =
        await userRelationService.userRelationsUpdate(
            entityType: entityType!, entityKeys: [entityKey], hide: hide);
  }

  muteEntity(bool mute) async {
    final entityKey = text?.value?.textKey;
    const entityType = USER_RELATION_ENTITY_TYPE.TEXT;

    final UserRelation? authUserRelation =
        await userRelationService.userRelationsUpdate(
            entityType: entityType, entityKeys: [entityKey], mute: mute);
    text!.value = text!.value!.copyWith(authUserRelation: authUserRelation);
    events.textMute(TextMuteEvent(text: text!.value));
  }

  blockEntity(bool block) async {
    final entityKey = text?.value?.textKey;
    const entityType = USER_RELATION_ENTITY_TYPE.TEXT;

    final UserRelation? authUserRelation =
        await userRelationService.userRelationsUpdate(
            entityType: entityType, entityKeys: [entityKey], block: block);
    text!.value = text!.value!.copyWith(authUserRelation: authUserRelation);
    //events.textMute(TextMuteEvent(text: text!.value));
  }

  //TODO: Made it receive onSubmit
  onDeleteTap() async {
    closeBottomSheet();
    await Get.dialog(
      IrisDialog(
        title: 'Delete?',
        subtitle: 'Are you sure you want to delete this?',
        onCancel: () => Get.back(),
        onConfirm: () => deletePost(),
        confirmButtonText: 'Delete',
        confirmIsDestructive: true,
      ),
    );
  }

  Future<void> onFeatureTap() async {
    closeBottomSheet();
    bool feature = true;
    if (text!.value!.featuredAt != null) {
      feature = false;
    }
    final TextModel? returnText = await textService.textFeature(
        textKey: text!.value!.textKey, feature: feature);
  }

  onTapEdit() {
    debugPrint('Edited');
    closeBottomSheet();

    PostInput.show(
        submitName: 'Edit',
        isFullPage: text!.value!.textType != TEXT_TYPE.COMMENT,
        textType: text!.value!.textType ?? TEXT_TYPE.POST,
        createTextType:
            CreateTextType(textType: text!.value!.textType ?? TEXT_TYPE.POST),
        focusNode: focusNode$.value,
        hintText: 'Add the reason you made this order',
        onSubmit: (info) {
          final TextModel? newData =
              text!.value!.copyWith(value: info.textEditingController!.text);
          text!.call(newData);
          Get.find<FeedController>().onSubmit(info);
        },
        text: text,
        onTyping: () {});

    focusNode$.value.requestFocus();
  }

  share() async {
    int? entityKey;
    if (text!.value!.textType == TEXT_TYPE.ORDER) {
      entityKey = text!.value!.order!.orderKey;
    } else if (text!.value!.textType == TEXT_TYPE.POST) {
      entityKey = text!.value!.textKey;
    }

    final Share? share = await socialService.shareCreate(
        entityKey: entityKey, shareType: shareType);

    shareView.value = true;
    shareLink.value = share;
  }

  userRelationUpdate({bool? hide, bool? mute, bool? block}) async {
    closeBottomSheet();
    if (hide != null) await hideEntity(hide);
    if (mute != null) await muteEntity(mute);
    if (block != null) await blockEntity(block);
  }
}

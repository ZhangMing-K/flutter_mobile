import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../iris_common.dart';

typedef RefreshParentFunction = Function(
    int? userKey, FOLLOW_ACTION actionType, int? portfolioKey);

class FollowerViewController extends GetxController {
  // BaseController baseController = Get.find();
  IFeedRepository feedRepository = Get.find();
  final Events events = Get.find();
  int? userKey;

  int? portfolioKey;
  List<PANNEL_ITEMS>? pannelActions;

  final IAuthUserService authUserStore = Get.find();
  final FollowService followService = Get.find();
  final FollowActionFunction refreshParent;

  FollowerViewController({
    required this.userKey,
    required this.portfolioKey,
    required this.refreshParent,
    required this.pannelActions,
  });

  closePanelFully({required BuildContext context}) async {
    final PanelController pc = context.read();
    if (!pc.isPanelClosed) {
      await pc.close();
    }
  }

  hide(BuildContext context, {bool? hide}) async {
    closePanelFully(context: context);
    final entityType = portfolioKey == null
        ? USER_RELATION_ENTITY_TYPE.USER
        : USER_RELATION_ENTITY_TYPE.PORTFOLIO;
    final entityKey = portfolioKey ?? userKey;

    final UserRelation? authUserRelation =
        await feedRepository.userRelationsUpdate(
            entityType: entityType, entityKeys: [entityKey], hide: hide);
    final user = User(authUserRelation: authUserRelation);
    if (entityType == USER_RELATION_ENTITY_TYPE.USER) {
      events.userHide(UserHideEvent(user: user));
      Get.snackbar('Successfully ${hide! ? 'hid' : 'un-hid'} this user',
          'You ${hide ? 'will not' : 'will'} see posts from this user in your feed');
    }

    if (entityType == USER_RELATION_ENTITY_TYPE.PORTFOLIO) {
      refreshParent(
          authUserRelation: authUserRelation, portfolioKey: portfolioKey);
      Get.snackbar(
          'Successfully ${hide! ? 'hid' : 'un-hid'} orders for this portfolio',
          'You ${hide ? 'will not' : 'will'} see orders from this portfolio in your feed');
    }
  }

  removeFollower(context) async {
    final User? user = await followService.removeFollower(
        userKey: userKey, portfolioKey: portfolioKey);

    // baseController.closePanelFully(c: context); // cause `looking up a deactivated widget's ancestor is unsafe` issue
    refreshParent(
        userKey: userKey,
        actionType: FOLLOW_ACTION.REMOVE,
        portfolioKey: portfolioKey);

    return user;
  }

  unfollow(context) async {
    final result = await overlayLoader(
        context: Get.overlayContext!,
        asyncFunction: () async {
          return followService.unfollow(
              entityType: portfolioKey != null
                  ? FOLLOW_REQUEST_ENTITY_TYPE.PORTFOLIO
                  : FOLLOW_REQUEST_ENTITY_TYPE.USER,
              entityKey: portfolioKey ?? userKey);
        });

    if (result != null) {
      refreshParent(
          userKey: userKey,
          actionType: FOLLOW_ACTION.REMOVE,
          portfolioKey: portfolioKey);
      Get.back();
    } else {
      Get.snackbar('Error', 'It was not possible to perform this action');
    }

    // baseController.closePanelFully(c: context); // cause `looking up a deactivated widget's ancestor is unsafe` issue
    // if (refreshParent != null) {

    // }
  }
}

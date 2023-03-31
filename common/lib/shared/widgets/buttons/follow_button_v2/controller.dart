import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class FollowButtonController extends GetxController {
  final IAuthUserService authUserStore = Get.find();
  final FollowService followService = Get.find();

  Rx<FOLLOW_STATUS?> followStatus$ = Rx<FOLLOW_STATUS?>(null);
  final Events events = Get.find();
  FOLLOW_REQUEST_ENTITY_TYPE? entityType;
  int? entityKey;
  late bool includeFollowerView;
  Rx<UserRelation?> authUserRelation$ = Rx<UserRelation?>(null);

  get followerPannelItems {
    return authUserRelation$.value?.hideAt == null
        ? [PANNEL_ITEMS.STOP_FOLLOWING, PANNEL_ITEMS.HIDE]
        : [PANNEL_ITEMS.STOP_FOLLOWING, PANNEL_ITEMS.UNHIDE];
  }

  refreshButton(
      {int? userKey,
      int? portfolioKey,
      FOLLOW_ACTION? actionType,
      UserRelation? authUserRelation}) {
    if (actionType == FOLLOW_ACTION.REMOVE) {
      followStatus$.value = FOLLOW_STATUS.NOT_FOLLOWING;
    }

    if (authUserRelation != null) authUserRelation$.value = authUserRelation;
  }

  requestToFollow(context) async {
    final followStatus = followStatus$.value;
    if (followStatus == FOLLOW_STATUS.NOT_FOLLOWING) {
      followStatus$.value = FOLLOW_STATUS.PENDING;

      if (entityType == FOLLOW_REQUEST_ENTITY_TYPE.USER) {
        followStatus$.value = FOLLOW_STATUS.APPROVED;
        events.userFollow(UserFollowEvent(followStatus: followStatus$.value));
      }
      final followRequest = await followService.requestToFollowType(
          lookupKey: entityKey, entityType: entityType!);

      if (followRequest?.accountUser?.authUserFollowInfo?.followStatus !=
          null) {
        if (entityType == FOLLOW_REQUEST_ENTITY_TYPE.USER) {
          followStatus$.value =
              followRequest!.accountUser!.authUserFollowInfo!.followStatus;
        } else if (entityType == FOLLOW_REQUEST_ENTITY_TYPE.PORTFOLIO) {
          followStatus$.value =
              followRequest!.portfolio!.authUserFollowInfo!.followStatus;
        }
      }
    } else if (followStatus == FOLLOW_STATUS.APPROVED) {
      if (includeFollowerView) {
        FollowerView.openPannel(
            userKey: entityKey,
            context: context,
            pannelActions: followerPannelItems,
            refreshParent: refreshButton);
      }
    } else if (followStatus == FOLLOW_STATUS.PENDING) {
      FollowerView.openPannel(
          userKey: entityKey,
          context: context,
          pannelActions: followerPannelItems,
          refreshParent: refreshButton);
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../app/routes/pages.dart';

class FollowRequestCardController extends GetxController {
  FollowRequestCardController(
      {required this.onAction, required this.followRequest$});
  final Function(FollowRequest? notification)? onAction;
  final Rx<FollowRequest?> followRequest$;

  final FollowService followService = Get.find();

  Future<void> approve() async {
    await respondToRequest(action: FOLLOW_REQUEST_ACTION.APPROVE);
    followRequest$.value =
        followRequest$.value!.copyWith(status: FOLLOW_REQUEST_STATUS.APPROVED);
    return;
  }

  Future<void> denied() async {
    await respondToRequest(action: FOLLOW_REQUEST_ACTION.DENY);
    followRequest$.value =
        followRequest$.value!.copyWith(status: FOLLOW_REQUEST_STATUS.DENIED);
    return;
  }

  onTapCard(String id) {
    // Get.toNamed(Paths.Profile.createPath(
    //     [followRequest$.value!.followerUser!.userKey]));
    routeToActionUserProfile(id);
  }

  respondToRequest({required FOLLOW_REQUEST_ACTION action}) async {
    final followRequestKey = followRequest$.value!.followRequestKey;
    if (action == FOLLOW_REQUEST_ACTION.APPROVE) {
      followRequest$.value =
          followRequest$.value!.copyWith(approvedAt: DateTime.now());
    } else {
      followRequest$.value =
          followRequest$.value!.copyWith(deniedAt: DateTime.now());
    }
    onAction?.call(followRequest$.value);
    try {
      await followService.respondToFollowRequest(
          followRequestKey: followRequestKey, action: action);
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  routeToActionUserProfile(String id) {
    final profileArgs = ProfileArgs(
      user: followRequest$.value?.followerUser ?? const User(),
      heroTag: id,
    );
    Get.toNamed(
      Paths.Feed + Paths.Home + Paths.Profile,
      parameters: {
        'profileUserKey': followRequest$.value!.followerUser!.userKey.toString()
      },
      arguments: profileArgs,
      id: 1,
    );
  }
}

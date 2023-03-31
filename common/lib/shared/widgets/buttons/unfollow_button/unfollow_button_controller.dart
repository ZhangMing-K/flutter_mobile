import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class UnfollowButtonController extends GetxController {
  final IAuthUserService authUserStore = Get.find();
  final FollowService followService = Get.find();

  Rx<FOLLOW_STATUS?> followStatus$ = Rx<FOLLOW_STATUS?>(null);

  FOLLOW_REQUEST_ENTITY_TYPE? entityType;
  int? portfolioKey;
  int? userKey;

  requestToFollow() async {
    // final followStatus = followStatus$.value;
    // if (followStatus == FOLLOW_STATUS.NOT_FOLLOWING) {
    //   followStatus$.value = FOLLOW_STATUS.PENDING;
    //   final followRequest = await followService.requestToFollowType(
    //       lookupKey: entityKey, entityType: entityType);
    // } else if (followStatus == FOLLOW_STATUS.APPROVED) {}
  }
}

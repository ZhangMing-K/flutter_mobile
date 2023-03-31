import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class ProfileSummaryController extends GetNotifier<Rx<User>> {
  final IProfileRepository repository;

  final int profileUserKey;
  final IAuthUserService authUserStore;
  late final String heroTag;
  String storyCursor = '';
  String storyPrevCursor = '';
  String storyNextCursor = '';

  ProfileSummaryController({
    required this.profileUserKey,
    required this.repository,
    required this.authUserStore,
  }) : super(const User().obs);

  bool get isOwnUser {
    if (profileUserKey == authUserStore.loggedUser!.userKey) {
      return true;
    }
    return false;
  }

  bool get userHasBlueRing {
    if (state?.value == null) {
      return false;
    }
    final storyConnection = state!.value.storiesConnection;
    if (storyConnection == null) return false;
    final metadata = state!.value.storiesConnection?.metaData;
    if (metadata == null) return false;
    final bool areStories = metadata.areStories ?? false;
    final bool areUnseenStories = metadata.areUnseenStories ?? false;
    final bool blueRing = areStories && areUnseenStories;
    return blueRing;
  }

  void changeProfileStatPrivacy(User user) {
    state!.value =
        state!.value.copyWith(tradeStatVisibility: user.tradeStatVisibility);
    change(state, status: RxStatus.success());
  }

  void fetchSummary() {
    repository.getUserByKey(
        userKey: profileUserKey,
        userGql: profileSummaryGql(storyCursor: storyCursor),
        callback: onSuccess,
        onError: onError);
  }

  TradePerformanceConnection? getTradePerformanceConnection(SEGMENT_TYPE type) {
    final performances = state!.value.tradePerformanceConnections ?? [];
    return performances
        .firstWhereOrNull((element) => element.segmentType == type);
  }

  void markNoUnSeenStories() {
    final StoriesMetaData newMetadata = state!
        .value.storiesConnection!.metaData!
        .copyWith(areUnseenStories: false);
    final StoriesConnection newStoriesConnection =
        state!.value.storiesConnection!.copyWith(metaData: newMetadata);
    state!.value =
        state!.value.copyWith(storiesConnection: newStoriesConnection);
    change(state, status: RxStatus.success());
  }

  void onError(e) {
    ///TODO: Uncomment this when backend fix this error
    /// IrisExceptionHandler.show(ProfileSummaryException());
    debugPrint(e.toString());
  }

  @override
  void onInit() {
    if (Get.arguments is ProfileArgs) {
      final ProfileArgs args = Get.arguments;
      final newUser = User(
        username: args.user.username,
        firstName: args.user.firstName,
        lastName: args.user.lastName,
        profilePictureUrl: args.user.profilePictureUrl,
        storiesConnection: args.user.storiesConnection,
      );

      heroTag = args.heroTag;
      change(newUser.obs, status: RxStatus.success());
    } else {
      heroTag = '';
      change(const User().obs, status: RxStatus.success());
    }

    fetchSummary();
    super.onInit();
  }

  void onSuccess(UsersGetResponse data) {
    final users = data.users;
    if (users != null && users.isNotEmpty) {
      if (users.first.storiesConnection != null) {
        storyPrevCursor =
            users.first.storiesConnection?.storiesPagination?.previousCursor ??
                '';
        storyNextCursor =
            users.first.storiesConnection?.storiesPagination?.nextCursor ?? '';
      }
      final User user = users.first;

      state!.value = user.copyWith(
        username: user.username ?? state!.value.username,
        firstName: user.firstName ?? state!.value.firstName,
        lastName: user.lastName ?? state!.value.lastName,
        profilePictureUrl:
            user.profilePictureUrl ?? state!.value.profilePictureUrl,
      );

      change(state, status: RxStatus.success());
    }
  }

  Future<void> refreshData() async {
    fetchSummary();
  }

  void removeFollowerNum(newNum) {
    final newUser = state!.value.copyWith(
        followStats:
            state!.value.followStats?.copyWith(numberOfFollowers: newNum));
    change(newUser.obs, status: RxStatus.success());
  }

  void removeFollowingNum(newNum) {
    final newUser = state!.value.copyWith(
        followStats:
            state!.value.followStats?.copyWith(numberFollowing: newNum));
    change(newUser.obs, status: RxStatus.success());
  }

  void removePortfoliosFollowingNum(newNum) {
    final newUser = state!.value.copyWith(
        followStats: state!.value.followStats
            ?.copyWith(numberOfPortfoliosFollowing: newNum));
    change(newUser.obs, status: RxStatus.success());
  }

  void updateProfileSummary() {
    final newUser = state!.value.copyWith(
      username: authUserStore.loggedUser!.username,
      firstName: authUserStore.loggedUser!.firstName,
      lastName: authUserStore.loggedUser!.lastName,
      profilePictureUrl: authUserStore.loggedUser!.profilePictureUrl,
      description: authUserStore.loggedUser!.description,
    );
    change(newUser.obs, status: RxStatus.success());
  }
}

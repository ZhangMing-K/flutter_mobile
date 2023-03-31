import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../profile/controllers/profile_controller.dart';
import '../modules/followers/controllers/followers_controller.dart';
import '../modules/following/controllers/following_controller.dart';
import '../modules/portfolios_following/controllers/portfolios_following_controller.dart';

class ProfileSearchController extends GetxController {
  ProfileSearchController({
    required this.followersController,
    required this.followingController,
    required this.portfoliosFollowingController,
    required this.profileUserKey,
    required this.irisEvent,
  });
  final ScrollController scrollController = ScrollController();
  final FollowersController followersController;
  final FollowingController followingController;
  final PortfoliosFollowingController portfoliosFollowingController;
  final IrisEvent irisEvent;

  Rx<User?> profileUser = Rx<User?>(null);
  late ProfileController profileController;
  final int profileUserKey;
  int selectedTab = 0;
  String? searchVal = '';

  @override
  void onInit() {
    irisEvent.add(eventType: EVENT_TYPE.VIEW_SCREEN_SEARCH);
    selectedTab = int.parse(Get.parameters['selectedTab']!) - 1;
    if (Get.arguments == null) {
      ///TODO: Refactor this to web app
      debugPrint('Fetch data from api');
    } else {
      profileController = Get.arguments;
    }
    profileUser.value = profileController.profileSummaryController.state!.value;
    initProfileUserForTab();
    super.onInit();
  }

  initProfileUserForTab() {
    followersController.profileUser.value = profileUser.value;
    followingController.profileUser.value = profileUser.value;
    portfoliosFollowingController.profileUser.value = profileUser.value;
  }

  // This is called when you remove follower, stop following someone, or stop following portfolios
  // Need to reduce the number on profile as well
  onUpdate(String type, int newNum) {
    if (type == 'follower') {
      profileController.profileSummaryController.removeFollowerNum(newNum);
    } else if (type == 'following') {
      profileController.profileSummaryController.removeFollowingNum(newNum);
    } else if (type == 'portfoliosFollowing') {
      profileController.profileSummaryController
          .removePortfoliosFollowingNum(newNum);
    }
  }

  void scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  void jumpToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  void scrollToBottom() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  onTabChange(int index, String searchTerm) {
    selectedTab = index;
    if (index == 0) {
      modifierFollowers(searchTerm);
    } else if (index == 1) {
      modifierFollowing(searchTerm);
    } else if (index == 2) {
      modifierPortfoliosFollowing(searchTerm);
    }
  }

  modifierFollowers(String searchTerm) async {
    if (followersController.searchValue != searchTerm) {
      followersController.offset = 0;
      followersController.searchValue = searchTerm;
      final List<User> searchedUsers =
          await followersController.onLoadFollowers().remote;
      followersController.rebuildOnChange(searchedUsers);
    }
  }

  modifierFollowing(String searchTerm) async {
    if (followingController.searchValue != searchTerm) {
      followingController.offset = 0;
      followingController.searchValue = searchTerm;
      final List<User> searchedUsers =
          await followingController.onLoadFollowing().remote;
      followingController.rebuildOnChange(searchedUsers);
    }
  }

  modifierPortfoliosFollowing(String searchTerm) async {
    if (portfoliosFollowingController.searchValue != searchTerm) {
      portfoliosFollowingController.offset = 0;
      portfoliosFollowingController.searchValue = searchTerm;
      final List<Portfolio> searchedPortfolios =
          await portfoliosFollowingController
              .onLoadPortfoliosFollowing()
              .remote;
      portfoliosFollowingController.rebuildOnChange(searchedPortfolios);
    }
  }

  onQueryChanged(String query) async {
    if (query != searchVal) {
      searchVal = query;
      if (selectedTab == 0) {
        await modifierFollowers(query);
      } else if (selectedTab == 1) {
        await modifierFollowing(query);
      } else if (selectedTab == 2) {
        await modifierPortfoliosFollowing(query);
      }
    }
  }
}

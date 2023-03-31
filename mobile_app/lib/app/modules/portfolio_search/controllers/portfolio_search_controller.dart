import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../modules/users/controllers/users_controller.dart';

class PortfolioSearchController extends GetxController {
  PortfolioSearchController({
    required this.usersController,
    required this.irisEvent,
  });
  final scrollController = ScrollController();
  final PortfolioUsersController usersController;
  String searchVal = '';
  final IrisEvent irisEvent;

  @override
  void onClose() {}

  @override
  void onInit() {
    irisEvent.add(eventType: EVENT_TYPE.VIEW_SCREEN_SEARCH);
    super.onInit();
  }

  void scrollToTop() {
    usersController.listviewController.currentState!.scrollToTop();
  }

  void jumpToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  void scrollToBottom() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  modifierUsers(String searchTerm) async {
    if (usersController.searchValue != searchTerm) {
      usersController.offset = 0;
      usersController.searchValue = searchTerm;
      final List<User> searchedUsers =
          await usersController.onLoadUsers().remote;
      usersController.rebuildOnChange(searchedUsers);
    }
  }

  onQueryChanged(String query) async {
    if (query != searchVal) {
      searchVal = query;
      await modifierUsers(query);
    }
  }
}

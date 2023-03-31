import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/pages.dart';

class PortfoliosNotifier extends GetNotifier<List<Portfolio>> {
  final IAuthUserService authUserStore;
  final IProfileRepository repository;
  final int profileUserKey;

  PortfoliosNotifier({
    required this.authUserStore,
    required this.repository,
    required this.profileUserKey,
  }) : super([]);

 

  bool get isAuthUser => authUserStore.loggedUser?.userKey == profileUserKey;

  void start() {
    fetchPortfolio();
  }

  Future<void> fetchPortfolio() async {
    await repository.getPortfolios(
      userKey: profileUserKey,
      callback: (List<Portfolio> data) {
        if (data.isEmpty) {
          change([], status: RxStatus.empty());
        } else {
          change(data, status: RxStatus.success());
        }
      },
      queryType: QueryType.loadCache,
      onError: (e) {
        debugPrint(e.toString());
      },
    );
  }

  @override
  void onInit() {
    fetchPortfolio();
    super.onInit();
  }

  Future<void> pullRefresh() async {
    await fetchPortfolio();
  }

  Future<void> updatePortfolios({int? userKey}) async {
    // if (userKey != null) profileUserKey = userKey;
    debugPrint('update portfolios ? ');

    fetchPortfolio();
  }
}

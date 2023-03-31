import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../routes/pages.dart';

///This class has the sole responsibility to control the status of the posts tab in the feed.
///We use StateMixin because it makes our code more secure. If an error is not caught,
///it is displayed automatically. The loading status is also displayed when there is no data.
///We can change the state of the controller through the change method, and attach a status to it
class PositionController extends GetxController with StateMixin<Rx<Portfolio>> {
  PositionController({required this.repository});
  final IPortfolioRepository repository;
  final scrollController = ScrollController();

  final listviewController = GlobalKey<IrisListViewState>();

  Rx<Portfolio?> portfolio$ = Rx<Portfolio?>(null);

  reconnect() async {
    final portfolio = portfolio$.value!;
    Get.toNamed(Paths.ConnectInstitution.createPath([
      describeEnum(portfolio.brokerName!),
      portfolio.portfolioKey,
    ]));
  }

  @override
  void onReady() {}
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class OverviewController extends GetxController
    with StateMixin<List<Portfolio>> {
  OverviewController({required this.repository});
  final IPortfolioRepository repository;
  final scrollController = ScrollController();

  final listviewController = GlobalKey<IrisListViewState>();

  Rx<Portfolio?> portfolio$ = Rx<Portfolio?>(null);
}

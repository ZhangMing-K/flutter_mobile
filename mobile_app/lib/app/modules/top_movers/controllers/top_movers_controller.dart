import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../modules/day/controllers/day_controller.dart';
import '../modules/month/controllers/month_controller.dart';
import '../modules/week/controllers/week_controller.dart';
import '../modules/year/controllers/year_controller.dart';

class TopMoversController extends FullLifeCycleController {
  TopMoversController({
    required this.dayController,
    required this.weekController,
    required this.monthController,
    required this.yearController,
    required this.repository,
  });
  final DayController dayController;
  final WeekController weekController;
  final MonthController monthController;
  final YearController yearController;
  final ITopMoversRepository repository;
  final ScrollController scrollController = ScrollController();

  @override
  void onClose() {}

  void scrollToTop() {
    dayController.listviewController.currentState!.scrollToTop();
  }
}

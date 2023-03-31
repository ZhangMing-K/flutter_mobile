import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'controllers/top_movers_controller.dart';
import 'modules/day/views/day_view.dart';
import 'modules/month/views/month_view.dart';
import 'modules/week/views/week_view.dart';
import 'modules/year/views/year_view.dart';

//TODO: This module contains many deprecated data
//Maybe remove?????
class TopMoversScreen extends GetView<TopMoversController> {
  const TopMoversScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: 'Leaderboard',
      ),
      body: IrisTabView(
        onTabChange: (index) async {},
        tabs: const [
          IrisTab(text: 'Day', body: DayView()),
          IrisTab(text: 'Week', body: WeekView()),
          IrisTab(text: 'Month', body: MonthView()),
          IrisTab(text: 'Year', body: YearView()),
        ],
        initialIndex: 0,
        indicatorColor: context.theme.colorScheme.secondary.withOpacity(.8),
      ),
    );
  }

  static String routeName() {
    const uri = '/top-movers';
    return uri;
  }
}

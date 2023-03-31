import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stocks_controller.dart';
import 'widgets/community_analytics.dart';
import 'widgets/top_mentions.dart';

class StocksView extends GetView<StocksController> {
  const StocksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CommunityAnalyticsView(),
        TopMentionsView(),
      ],
    );
  }
}

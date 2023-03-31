import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/profile/modules/summary/views/widgets/stat_card.dart';

class TraderStats extends StatelessWidget {
  final User user;

  const TraderStats({Key? key, required this.user}) : super(key: key);

  List<StatCard> getCardList(User user) {
    var list = List<StatCard>.empty(growable: true);
    if (user.traderPercentileDouble != null) {
      list.add(StatCard(
        label: 'Trader Percentile',
        value: user.traderPercentileDouble,
      ));
    }
    if (user.tradeAccuracyDouble != null) {
      list.add(StatCard(
        label: 'Accuracy',
        value: user.tradeAccuracyDouble,
      ));
    }
    if (user.tradePerformance?.openTradesPerMonth != null) {
      list.add(StatCard(
        label: 'Monthly Trades',
        value: user.tradeAccuracyDouble,
        isPercent: false,
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    bool portfolioConnected = user.portfolios?.isNotEmpty ?? false;
    var cardList = getCardList(user);
    bool showList = portfolioConnected && cardList.isNotEmpty;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: showList ? 16.0 : 0),
      child: SizedBox(
        height: showList ? 69 : 0,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: cardList.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) => cardList[index],
        ),
      ),
    );
  }
}

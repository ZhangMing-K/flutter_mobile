import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';
import '../../summary/views/widgets/percent_display.dart';

class RecentlyTraded extends StatelessWidget {
  const RecentlyTraded({
    Key? key,
    required this.orders,
  }) : super(key: key);
  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(height: 36),
            Text(
              'Recently traded',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
        ...orders.map((t) => _RecentOrderListItem(order: t)).toList()
      ],
    );
  }
}

class _RecentOrderListItem extends StatelessWidget {
  const _RecentOrderListItem({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      //TODO open order details screen
      leading: AppAssetImage(asset: order.asset),
      title: Row(
        children: [
          if (!order.hasLongOptionName)
            Text(
              order.orderSideDisplayAction,
              style: Theme.of(context).custom.textTheme.h6Bold,
            ),
          Text(
            ' ${order.symbol}',
            style: Theme.of(context).custom.textTheme.h6Bold,
          )
        ],
      ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              /// check if the order was fulfilled in the last 24 hours.
              /// maybe move this into a getter on the orderModel, or into the (to-be-built) controller.
              order.fullfilledAt?.isBefore(
                          DateTime.now().subtract(const Duration(hours: 24))) ==
                      true
                  ? order.fullfilledAt.formatMonthDayYear()
                  : order.fullfilledAt.formatTimeStandardToLocal(),
              style: Theme.of(context).custom.textTheme.subHeader1,
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PercentDisplay(
            showDecimal: false,
            percent: order.profitLossPercentValue,
            textStyle: Theme.of(context).custom.textTheme.h6Semi,
          ),
          const Icon(IrisIcon.carat_right)
        ],
      ),
    );
  }
}

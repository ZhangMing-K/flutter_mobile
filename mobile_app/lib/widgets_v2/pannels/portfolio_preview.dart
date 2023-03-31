import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class PortfolioPreview extends StatelessWidget {
  const PortfolioPreview(
      {Key? key,
      this.selected,
      this.portfolio,
      this.onTap,
      this.addFunctionality})
      : super(key: key);

  final bool? selected;
  final bool? addFunctionality;
  final Portfolio? portfolio;
  final Function? onTap;

  Widget preview(portfolio) {
    return Row(
      children: [
        BrokerIcon(
          brokerName: portfolio.brokerName,
        ),
        const SizedBox(width: 10),
        Text(
          portfolio.portfolioName ?? '',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap as void Function()?,
      title: AbsorbPointer(child: preview(portfolio)),
      trailing: addFunctionality!
          ? Icon(selected! ? Icons.check_box : Icons.check_box_outline_blank,
              color: IrisColor.primaryColor)
          : null,
    );
  }
}

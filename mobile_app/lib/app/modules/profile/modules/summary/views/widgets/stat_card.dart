import 'package:flutter/material.dart';
import 'package:iris_common/shared/widgets/iris_card.dart';
import 'package:iris_mobile/app/modules/profile/modules/summary/views/widgets/percent_display.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    Key? key,
    required this.label,
    required this.value,
    this.isPercent = true,
    this.showPlusSign = false,
  }) : super(key: key);

  final String label;
  final double? value;
  final bool isPercent;
  final bool showPlusSign;

  @override
  Widget build(BuildContext context) {
    return value == null
        ? Container()
        : IrisCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isPercent)
                  PercentDisplay(
                    percent: value,
                    showPlusSign: showPlusSign,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                    nullPlaceholder: 'N/A',
                  ),
                if (!isPercent)
                  Text(
                    '${value ?? 'N/A'}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
          );
  }
}

import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

import '../../summary/views/widgets/percent_display.dart';

class MetricDisplay extends StatelessWidget {
  const MetricDisplay({
    Key? key,
    this.percentSize = 18,
    this.labelSize = 14,
    required this.label,
    required this.percent,
  }) : super(key: key);
  final double percentSize;
  final double labelSize;
  final String label;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PercentDisplay(
          percent: percent,
          showDecimal: false,
          textStyle: Theme.of(context)
              .textTheme
              .headline3
              ?.copyWith(fontSize: percentSize),
        ),
        Text(
          label,
          style: Theme.of(context).custom.textTheme.bodySmall.copyWith(
                fontSize: labelSize,
                color: Theme.of(context).custom.colorScheme.grayText,
              ),
        )
      ],
    );
  }
}

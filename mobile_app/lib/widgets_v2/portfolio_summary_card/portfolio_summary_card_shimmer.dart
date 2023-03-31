import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class PortfolioSummaryCardShimmer extends StatelessWidget {
  const PortfolioSummaryCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.all(10),
      height: 100,
      child: Column(
        children: [firstRow()],
      ),
    );
  }

  Widget firstRow() {
    return Row(
      children: [
        const ShimmerCircle(
          radius: 30,
        ),
        const SizedBox(width: 20),
        profile()
      ],
    );
  }

  Widget profile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ShimmerRow(
          height: 20,
          width: 180,
        ),
        SizedBox(
          height: 7,
        ),
        ShimmerRow(
          height: 15,
          width: 100,
        ),
        SizedBox(
          height: 7,
        ),
        ShimmerRow(
          height: 15,
          width: 100,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'shimmer_base.dart';

class HistoricalChartShimmer extends StatelessWidget {
  const HistoricalChartShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chart();
  }

  Widget buttons() {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(21),
            vertical: ScreenUtil().setHeight(21)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const <Widget>[
            ShimmerRow(
              height: 32,
              width: 49,
              borderRadius: 4,
            ),
            ShimmerRow(
              height: 32,
              width: 49,
              borderRadius: 4,
            ),
            ShimmerRow(
              height: 32,
              width: 49,
              borderRadius: 4,
            ),
            ShimmerRow(
              height: 32,
              width: 49,
              borderRadius: 4,
            ),
            ShimmerRow(
              height: 32,
              width: 49,
              borderRadius: 4,
            ),
            ShimmerRow(
              height: 32,
              width: 49,
              borderRadius: 4,
            ),
          ],
        ));
  }

  Widget chart() {
    return Column(
      children: [chartContainer(), divider()],
    );
  }

  Widget chartContainer() {
    return Builder(builder: (context) {
      return Container(
          color: context.theme.scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              header(),
              lineChart(),
              buttons(),
            ],
          ));
    });
  }

  Widget chartHeaderInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const ShimmerCircle(
          radius: 25,
        ),
        SizedBox(width: ScreenUtil().setWidth(11)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerRow(
              height: 13,
              width: 69,
              borderRadius: 6,
            ),
            SizedBox(height: ScreenUtil().setHeight(4)),
            const ShimmerRow(
              height: 12,
              width: 81,
              borderRadius: 6,
            ),
          ],
        )
      ],
    );
  }

  Widget divider() {
    return const Divider(
      color: Colors.transparent,
    );
  }

  Widget header() {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(18),
            vertical: ScreenUtil().setHeight(20)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [chartHeaderInfo(), percentageChange()]));
  }

  Widget lineChart() {
    return SizedBox(
        height: ScreenUtil().setHeight(190),
        child: const Center(
          child: ShimmerCircleLoader(),
        ));
  }

  Widget percentageChange() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const ShimmerRow(
            height: 11,
            width: 84,
            borderRadius: 6,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(4),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: ScreenUtil().setWidth(1)),
              const ShimmerRow(
                height: 11,
                width: 40,
                borderRadius: 6,
              ),
            ],
          ),
        ]);
  }
}

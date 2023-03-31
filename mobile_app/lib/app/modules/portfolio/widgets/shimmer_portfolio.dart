import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iris_common/iris_common.dart';

class ShimmerPortfolio extends StatelessWidget {
  const ShimmerPortfolio({Key? key}) : super(key: key);

  Widget reusableContainer(
      double height, double width, bool circle, double radius) {
    return ShimmerBase(
        child: Container(
            height: ScreenUtil().setHeight(height),
            width: ScreenUtil().setWidth(width),
            decoration: BoxDecoration(
                borderRadius: circle ? null : BorderRadius.circular(radius),
                shape: circle ? BoxShape.circle : BoxShape.rectangle,
                color: Colors.white)));
  }

  Widget shimmerListPortfolios() {
    return ListView.separated(
        addAutomaticKeepAlives: false,
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.transparent,
          );
        },
        scrollDirection: Axis.vertical,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          /// bodyTop() in portfolio_mobile.dart
          if (index == 0) return const HistoricalChartShimmer();

          /// portfolioChart()
          if (index == 1) return shimmerBasicInformation();

          /// selectPositionsOrOrders()
          if (index == 2) return shimmerSelect();
          return shimmerPositionCard();
        });
  }

  Widget shimmerBasicInformation() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 17.0),
        child: CardBase(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            reusableContainer(15, 180, false, 6),
            SizedBox(height: ScreenUtil().setHeight(11)),
            shimmerStatsRow()
          ],
        )));
  }

  Widget shimmerStatsRow() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          shimmerStatsColumn(),
          shimmerStatsColumn(),
          shimmerStatsColumn()
        ]);
  }

  Widget shimmerStatsColumn() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          reusableContainer(21, 69, false, 6),
          const SizedBox(height: 11),
          reusableContainer(16, 76, false, 6)
        ]);
  }

  Widget shimmerSelect() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(9),
              vertical: ScreenUtil().setHeight(4.0)),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(child: selectOption()),
            SizedBox(width: ScreenUtil().setWidth(4.0)),
            Expanded(child: selectOption())
          ])),
    );
  }

  Widget selectOption() {
    return reusableContainer(30, 174, false, 6);
  }

  Widget shimmerChart() {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            shimmerPercentageDisplay(),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            shimmerChartLoader(),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            shimmerButtons(),
          ],
        ));
  }

  Widget shimmerPercentageDisplay() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(21)),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        reusableContainer(20, 75, false, 33),
        SizedBox(
          width: ScreenUtil().setWidth(10),
        ),
        reusableContainer(10, 75, false, 33),
      ]),
    );
  }

  Widget shimmerChartLoader() {
    return SizedBox(
        height: ScreenUtil().setHeight(200),
        child: Center(
          child: loader(),
        ));
  }

  Widget loader() {
    return const ShimmerBase(
        child: Center(
            child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF5F6FA)),
    )));
  }

  Widget shimmerButtons() {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(16),
            vertical: ScreenUtil().setHeight(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            reusableContainer(39, 44, false, 4),
            reusableContainer(39, 44, false, 4),
            reusableContainer(39, 44, false, 4),
            reusableContainer(39, 44, false, 4),
            reusableContainer(39, 44, false, 4),
            reusableContainer(39, 44, false, 4),
          ],
        ));
  }

  Widget shimmerPositionCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: CardBase(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                reusableContainer(17, 75, false, 33),
                SizedBox(height: ScreenUtil().setHeight(10)),
                reusableContainer(10, 85, false, 33),
              ]),
              reusableContainer(30, 50, false, 6)
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(13)),
          reusableContainer(1, 379, false, 33),
          SizedBox(height: ScreenUtil().setHeight(13)),
          //percents(),
        ],
      )),
    );
  }

  Widget percents() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        reusablePercent(),
        reusablePercent(),
        reusablePercent(),
        reusablePercent(),
      ],
    );
  }

  Widget reusablePercent() {
    return Container(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(21),
            bottom: ScreenUtil().setHeight(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            reusableContainer(34, 47, false, 33),
            SizedBox(width: ScreenUtil().setWidth(10)),
            reusableContainer(18, 64, false, 33)
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return shimmerListPortfolios();
  }
}

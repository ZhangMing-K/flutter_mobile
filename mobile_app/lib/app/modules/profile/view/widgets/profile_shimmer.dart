import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class ReusableContainer extends StatelessWidget {
  const ReusableContainer(this.height, this.width, this.circle, {Key? key})
      : super(key: key);

  final double height;
  final double width;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    return ShimmerBase(
      child: Container(
        height: ScreenUtil().setHeight(height),
        width: ScreenUtil().setWidth(width),
        decoration: BoxDecoration(
          borderRadius: circle ? null : BorderRadius.circular(33),
          shape: circle ? BoxShape.circle : BoxShape.rectangle,
          color: context.theme.backgroundColor,
        ),
      ),
    );
  }
}

class ShimmerProfile extends StatelessWidget {
  const ShimmerProfile({Key? key}) : super(key: key);

  //profileInformation
  Widget shimmerCardInformation() {
    return Center(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 17),
      width: double.infinity,
      child: CardBase(
          child: Padding(
        padding: EdgeInsets.all(ScreenUtil().setWidth(34)),
        child: shimmerCardInformationContent(),
      )),
    ));
  }

  Widget shimmerCardInformationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableContainer(15, 95, false),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        const ReusableContainer(1, 338, false),
        SizedBox(
          height: ScreenUtil().setHeight(13),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            reusableColumn(),
            reusableColumn(),
            reusableColumn(),
          ],
        )
      ],
    );
  }

  Widget reusableColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const ReusableContainer(12, 30, false),
        SizedBox(height: ScreenUtil().setHeight(13)),
        const ReusableContainer(12, 37, false),
      ],
    );
  }

  Widget shimmerCardPortfolioSection() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const ReusableContainer(15, 89, false),
          SizedBox(height: ScreenUtil().setHeight(13)),
          portfolioShimmerCard()
        ],
      ),
    );
  }

  Widget portfolioShimmerCard() {
    return CardBase(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ReusableContainer(13, 89, false),
                  ReusableContainer(16, 65, false),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(13)),
              const ReusableContainer(1, 339, false),
              SizedBox(height: ScreenUtil().setHeight(13)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ReusableContainer(11, 55, false),
                  ReusableContainer(11, 55, false),
                  ReusableContainer(11, 55, false),
                ],
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        shimmerCardInformation(),
        shimmerCardPortfolioSection(),
      ],
    );
  }
}

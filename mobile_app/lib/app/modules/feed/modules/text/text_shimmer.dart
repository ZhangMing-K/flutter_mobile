import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class TextShimmer extends StatelessWidget {
  const TextShimmer({Key? key}) : super(key: key);

  Widget textContainer() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(21))),
      margin: const EdgeInsets.only(top: 70, left: 18, right: 18),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[firstRow(), postRow(), ...commentRows()],
      ),
    );
  }

  Widget firstRow() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          reusableContainer(40, 40, true),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableContainer(10, 120, false),
                const SizedBox(
                  height: 5,
                ),
                reusableContainer(10, 75, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget postRow() {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
            color: const Color(0xFFF7F8FB),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(width: 1, color: const Color(0xFFF0F1F6))),
        child: textAndAsset());
  }

  Widget textAndAsset() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: reusableContainer(10, 50, false),
        ),
      ],
    );
  }

  List<Widget> commentRows() {
    final List<Widget> commentWidgets = [
      const SizedBox(
        height: 20,
      )
    ];
    commentWidgets.add(commentRow());
    return commentWidgets;
  }

  Widget commentRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [reusableContainer(34, 34, true)],
                ),
              ],
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  reusableContainer(10, 120, false),
                  const SizedBox(
                    height: 5,
                  ),
                  reusableContainer(10, 75, false),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      reusableContainer(10, 10, false),
                      const SizedBox(
                        width: 10,
                      ),
                      reusableContainer(10, 10, false),
                    ],
                  ),
                ],
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget reusableContainer(double height, double width, bool circle) {
    return ShimmerBase(
      child: Builder(
        builder: (context) => Container(
          height: ScreenUtil().setHeight(height),
          width: ScreenUtil().setWidth(width),
          decoration: BoxDecoration(
            borderRadius: circle ? null : BorderRadius.circular(33),
            shape: circle ? BoxShape.circle : BoxShape.rectangle,
            color: context.theme.backgroundColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return textContainer();
  }
}

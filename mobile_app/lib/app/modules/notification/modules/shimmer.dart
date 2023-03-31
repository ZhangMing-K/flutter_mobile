import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class NotificationCardShimmer extends StatelessWidget {
  const NotificationCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: context.theme.scaffoldBackgroundColor,
        height: 70,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.only(top: 5),
        child: shimmerCard());
  }

  firstRow() {
    return Row(
      children: [
        const ShimmerCircle(
          radius: 25,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            ShimmerRow(
              height: 15,
              width: 100,
            ),
            SizedBox(
              height: 6,
            ),
            ShimmerRow(
              height: 10,
              width: 60,
            ),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              ShimmerRow(
                height: 10,
                width: 68,
              )
            ],
          ),
        )
      ],
    );
  }

  secondRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        ShimmerRow(
          height: 40,
          width: 300,
        ),
      ],
    );
  }

  Widget shimmerCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        firstRow(),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class TextCardShimmer extends StatelessWidget {
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool? useSpinner;
  const TextCardShimmer({
    Key? key,
    this.padding,
    this.margin,
    this.useSpinner = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        height: 170,
        margin: margin,
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: useSpinner! ? const IrisLoading() : shimmerFeedCard());
  }

  Widget firstRow() {
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
          children: const [
            ShimmerRow(
              height: 10,
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
      ],
    );
  }

  Widget shimmerFeedCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(child: firstRow()),
        const SizedBox(
          height: 20,
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Flexible(
                child: ShimmerRow(
                  height: 40,
                  width: 300,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

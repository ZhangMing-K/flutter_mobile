import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ListTileShimmer extends StatelessWidget {
  final double? radius;
  const ListTileShimmer({
    Key? key,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      color: context.theme.backgroundColor,
      child: Row(
        children: [
          ShimmerCircle(
            radius: radius ?? 20,
          ),
          const SizedBox(
            width: 10,
          ),
          const ShimmerRow(
            width: 100,
            height: 15,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                ShimmerRow(
                  width: 50,
                  height: 15,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ShimmerBase extends StatelessWidget {
  final Widget child;
  const ShimmerBase({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color(0xFFF5F6FA),
        highlightColor: const Color(0xFFDDDDE2),
        enabled: true,
        child: child);
  }
}

class ShimmerCircle extends StatelessWidget {
  final double radius;

  const ShimmerCircle({
    Key? key,
    required this.radius,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: context.theme.colorScheme.secondary.withOpacity(.1),
        highlightColor: context.theme.colorScheme.secondary.withOpacity(.3),
        enabled: true,
        child: Container(
          height: radius * 2,
          width: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.theme.backgroundColor,
          ),
        ));
  }
}

class ShimmerCircleLoader extends StatelessWidget {
  const ShimmerCircleLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: context.theme.colorScheme.secondary.withOpacity(.1),
        highlightColor: context.theme.colorScheme.secondary.withOpacity(.3),
        enabled: true,
        child: const Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF5F6FA)),
        )));
  }
}

class ShimmerRow extends StatelessWidget {
  final double height;

  final double width;
  final double borderRadius;
  const ShimmerRow(
      {Key? key, this.height = 10, this.width = 30, this.borderRadius = 20})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.theme.colorScheme.secondary.withOpacity(.1),
      highlightColor: context.theme.colorScheme.secondary.withOpacity(.3),
      enabled: true,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: context.theme.backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

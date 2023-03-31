import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef CustomCallBack = Widget Function(ScrollController scrollController);

class IrisBottomSheet extends StatelessWidget {
  const IrisBottomSheet({
    Key? key,
    required this.child,
    this.initialChildSize = .5,
    this.maxChildSize = .8,
    this.minChildSize = .1,
    this.maxHeight = double.infinity,
    this.initialHeight,
  }) : super(key: key);

  static show({
    required BuildContext context,
    required CustomCallBack child,
    double initialChildSize = .5,
    double maxChildSize = .8,
    double minChildSize = .1,
    double? maxHeight,
    double? initialHeight,
  }) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return IrisBottomSheet(
            initialHeight: initialHeight,
            maxHeight: maxHeight,
            maxChildSize: maxChildSize,
            minChildSize: minChildSize,
            initialChildSize: initialChildSize,
            child: child,
          );
        });
  }

  final CustomCallBack child;
  final double initialChildSize;
  final double maxChildSize;
  final double minChildSize;
  final double? maxHeight;
  final double? initialHeight;

  double get maxHeightPercentage {
    if (maxHeight != null) {
      return 1;
    } else {
      return maxChildSize;
    }
  }

  double get initialHeightPercentage {
    if (initialHeight != null) {
      return maxHeight != null
          ? initialHeight! / maxHeight!
          : initialHeight! / Get.height;
    } else {
      return initialChildSize;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // height: maxHeight ?? double.infinity,
        height: (maxHeight ?? double.infinity) +
            MediaQuery.of(context).viewInsets.bottom * 2,
        child: DraggableScrollableSheet(
          initialChildSize: initialHeightPercentage,
          maxChildSize: maxHeightPercentage,
          minChildSize: minChildSize,
          expand: false,
          builder: (context, scrollController) {
            return child(scrollController);
          },
        ));
  }
}

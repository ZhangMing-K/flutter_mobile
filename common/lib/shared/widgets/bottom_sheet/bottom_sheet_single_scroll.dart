import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IrisBottomSheetSingleScroll extends StatelessWidget {
  final bool showHeader;
  final Widget child;
  final double initialChildSize;
  final double maxChildSize;
  final double minChildSize;
  const IrisBottomSheetSingleScroll({
    Key? key,
    this.showHeader = true,
    required this.child,
    this.initialChildSize = .5,
    this.maxChildSize = .8,
    this.minChildSize = .1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      maxChildSize: maxChildSize,
      minChildSize: minChildSize,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: context.theme.backgroundColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showHeader) header(),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget header() {
    return Builder(
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          width: MediaQuery.of(context).size.width / 4,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }
    );
  }
}

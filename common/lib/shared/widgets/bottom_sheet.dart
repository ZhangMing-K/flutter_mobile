import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final double maxHeight;
  final bool overflow;
  final Color? backgroundColor;
  const CustomBottomSheet(
      {Key? key,
      required this.child,
      this.backgroundColor,
      this.maxHeight = 0.9,
      this.overflow = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (overflow) {
      return Scaffold(
          // use Scaffold to avoid keyboard overlap
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: main());
    }
    return content();
  }

  Widget content() {
    return Builder(builder: (context) {
      return Container(
        constraints: BoxConstraints(
            minHeight: context.height * 0.1,
            maxHeight: context.height * maxHeight),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero,
          ),
          color: backgroundColor ?? context.theme.backgroundColor,
        ),
        child: Column(children: [
          header(),
          Expanded(child: child),
        ]),
      );
    });
  }

  Widget header() {
    return Builder(builder: (context) {
      return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 20),
        width: MediaQuery.of(context).size.width,
        height: 7,
        child: Center(
          child: Container(
              width: MediaQuery.of(context).size.width / 4,
              height: 6,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8))),
        ),
      );
    }); // The header element `---`
  }

  Widget main() {
    return Column(
      children: [
        Builder(builder: (context) {
          return SizedBox(
              //
              height: context.height * (1.0 - maxHeight),
              child: GestureDetector(
                onTap: () {
                  if (Get.isBottomSheetOpen!) {
                    Navigator.of(context).pop();
                  }
                },
              ));
        }),
        Expanded(child: content())
      ],
    );
  }
}

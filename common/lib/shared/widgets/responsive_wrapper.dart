import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return context.responsiveValue(
      mobile: child,
      tablet: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: child,
      ),
      desktop: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: child,
      ),
    )!;
  }
}

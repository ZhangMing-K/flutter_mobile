import 'package:flutter/material.dart';

class IrisCard extends StatelessWidget {
  const IrisCard({
    Key? key,
    required this.child,
    this.contentPadding = const EdgeInsets.all(12.0),
    this.onTap,
    this.borderRadius,
  }) : super(key: key);
  final Widget child;
  final EdgeInsets contentPadding;
  final Function()? onTap;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    BorderRadius radius = borderRadius ?? BorderRadius.circular(8);
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: radius,
          boxShadow: Theme.of(context).brightness == Brightness.light
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 4,
                    spreadRadius: 0,
                    offset: const Offset(1, 2),
                  ),
                ]
              : null),
      child: Material(
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: contentPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}

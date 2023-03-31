import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class IrisElevatedIconButton extends StatelessWidget {
  const IrisElevatedIconButton(
      {Key? key,
      this.onPressed,
      required this.icon,
      this.label,
      this.buttonSize})
      : super(key: key);

  final void Function()? onPressed;
  final Widget icon;
  final String? label;
  final Size? buttonSize;

  @override
  Widget build(BuildContext context) {
    var size = buttonSize!.width > kMinInteractiveDimension
        ? buttonSize
        : const Size.square(kMinInteractiveDimension);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox.fromSize(
          size: size,
          child: Material(
            color: IrisColor.primaryColor,
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(50),
              child: Center(
                child: icon,
              ),
            ),
          ),
        ),
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(label!),
          )
      ],
    );
  }
}

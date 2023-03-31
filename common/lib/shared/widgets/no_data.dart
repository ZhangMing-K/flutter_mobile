import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

enum NO_DATA_TYPE {
  FULL_PAGE,
  FIT,
}

class NoData extends StatelessWidget {
  final Color? backgroundColor;
  final String? text;
  final Widget? child;
  final Image? image;
  final double imageHeight;
  final NO_DATA_TYPE type;
  const NoData(
      {Key? key,
      this.text,
      this.child,
      this.image,
      this.backgroundColor,
      this.type = NO_DATA_TYPE.FULL_PAGE,
      this.imageHeight = 300})
      : super(key: key);
  get _image {
    if (image != null) {
      return image;
    }
    return Image.asset(Images.noItemsInFeed, width: 300, height: imageHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: backgroundColor ?? context.theme.scaffoldBackgroundColor,
      child: main(),
    );
  }

  Widget main() {
    double size = 20;
    if (type == NO_DATA_TYPE.FULL_PAGE) {
      size = 70;
    }
    return Column(
      children: [
        SizedBox(
          height: size,
        ),
        _image,
        SizedBox(
          height: size,
        ),
        if (text != null)
          Text(
            text!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        if (child != null) child!,
        const Expanded(
            child: SizedBox(
          height: 180,
        ))
      ],
    );
  }
}

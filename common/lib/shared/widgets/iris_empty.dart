import 'package:flutter/material.dart';

import '../../../shared/consts/images.dart';
import '../../../shared/consts/units.dart';
import '../../../shared/themes/colors.dart';
import 'default_text_title.dart';

class IrisEmpty extends StatelessWidget {
  final String imagePath;
  final double? imageSize;
  final String emptyText;
  final String? subtitle;
  final BoxFit fit;
  const IrisEmpty({
    Key? key,
    this.imagePath = Images.noItemsInFeed,
    this.fit = BoxFit.fill,
    this.imageSize,
    this.emptyText = 'Sorry :(',
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: imageSize,
          fit: fit,
        ),
        DefaultTextTitle(
            top: SpaceUnit.medium,
            textTitle: emptyText,
            fontSize: 30,
            align: TextAlign.center,
            fontWeight: FontWeight.w500,
            color: IrisColor.dateFromColor),
        if (subtitle != null && subtitle!.isNotEmpty)
          DefaultTextTitle(
              top: SpaceUnit.medium,
              textTitle: subtitle,
              fontSize: 15,
              align: TextAlign.center,
              fontWeight: FontWeight.w500,
              color: IrisColor.dateFromColor),
      ],
    );
  }
}

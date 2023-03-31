import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class WebullHeader extends StatelessWidget {
  const WebullHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Image.asset(
        context.isDarkMode
            ? Images.webullLogoWithTextWhite
            : Images.webullLogoWithTextBlack,
        width: double.maxFinite,
      ),
    );
  }
}

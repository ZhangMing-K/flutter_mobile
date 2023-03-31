import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class SchwabHeader extends StatelessWidget {
  const SchwabHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Image.asset(Images.schwabAlt),
      width: double.maxFinite,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class FilterEmptyView extends StatelessWidget {
  const FilterEmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imagePath =
        context.isDarkMode ? Images.marketSearchDark : Images.marketSearchLight;
    return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: FittedBox(
            child: IrisEmpty(
              emptyText: 'No Results',
              subtitle:
                  'Try changing your filter parameters or try again later',
              imagePath: imagePath,
              imageSize: Get.width / 3,
            ),
          ),
        ));
  }
}

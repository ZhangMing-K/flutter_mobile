import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../reacted_by_slideup/reacted_by_slideup.dart';
import '../reacted_by_slideup/reacted_by_slideup_controller.dart';

class ReactedByController extends GetxController {
  BaseController baseController = Get.find();
  Rx<TextModel?>? text$;
  final TextService textService = Get.find();
  onTap(BuildContext context) {
    final ReactedBySlideupController controller =
        ReactedBySlideupController(text$: text$!);
    Get.bottomSheet(
      DraggableScrollableSheet(
        minChildSize: .4,
        maxChildSize: 1,
        initialChildSize: .5,
        expand: true,
        builder: (context, scrollController) {
          return ReactedBySlideup(
              text: text$!.value,
              scrollController: scrollController,
              c: controller);
        },
      ),
      isScrollControlled: false,
    );
  }
}

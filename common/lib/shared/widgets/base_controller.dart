import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:provider/provider.dart';

class BaseController extends GetxController {
  final IAuthUserService authUserStore = Get.find();
  final mainTextFieldController = TextEditingController();
  RxString appBarHeaderTitle$ = ''.obs;

  Rx<Widget> panelWidget$ =
      Rx(Container(color: Colors.red, height: 10, width: 10));

  RxBool isWidgetScroll$ = false.obs;
  Rx<BorderRadius> panelBorderRadius$ = Rx(BorderRadius.circular(10));
  Rx<FocusNode> focusNode$ = FocusNode().obs;
  RxnString searchValue$ = RxnString('');

  closePanelFully({required BuildContext context}) async {
    final PanelController pc = context.read<PanelController>();
    if (!pc.isPanelClosed) {
      await pc.close();
    }
  }

  onChanged() {
    searchValue$.value = mainTextFieldController.text;
  }

  openPanel({
    required Widget child,
    double openPanelPosition = .5,
    required BuildContext context,
    bool isWidgetScroll = false,
  }) async {
    final PanelController pc = context.read<PanelController>();

    panelWidget$.value = child;
    isWidgetScroll$.value = isWidgetScroll;
    await pc.animatePanelToPosition(openPanelPosition);
  }

  openPanelFully({required BuildContext context}) async {
    final PanelController pc = context.read<PanelController>();
    if (!pc.isPanelOpen) {
      await pc.open();
    }
  }
}

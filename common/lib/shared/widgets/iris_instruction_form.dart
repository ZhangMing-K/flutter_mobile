import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class IrisInstructionForm extends StatelessWidget {
  final String? title;

  final String? subtitle;
  final Widget? content;
  final ScrollPhysics? scrollPhysics;
  final Widget? actionButton;
  final bool buttonOnButtom;
  final double fontSize;
  final PreferredSizeWidget? appBar;
  final bool? excludeKeyboard;

  const IrisInstructionForm({
    Key? key,
    this.title,
    this.appBar,
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
    this.subtitle,
    this.content,
    this.actionButton,
    this.buttonOnButtom = false,
    this.fontSize = TextUnit.large,
    this.excludeKeyboard = true,
  }) : super(key: key);

  Widget body() {
    return Builder(builder: (context) {
      double keyboardHeight = context.mediaQueryViewInsets.bottom;
      if (keyboardHeight.isNaN) {
        keyboardHeight = 0;
      }
      if (excludeKeyboard!) {
        return SizedBox(
            height: context.height - IrisScreenUtil.dWidth(90) - keyboardHeight,
            child: main());
      }
      return main();
    });
  }

  Widget main() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            if (title != null || subtitle != null) header(),
            if (content != null) contentWidget(),
          ],
        ),
        Column(
          children: [
            if (actionButton != null && !buttonOnButtom) actionButton!,
            SizedBox(height: IrisScreenUtil.dWidth(20)),
            SizedBox(height: IrisScreenUtil.dHeight(40)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: scrollPhysics,
        child: body(),
      ),
      bottomNavigationBar:
          buttonOnButtom && actionButton != null ? actionButton : null,
    );
  }

  Widget contentWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: IrisScreenUtil.dHeight(12)),
      child: content,
    );
  }

  Widget header() {
    return Builder(
        builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (title != null)
                  DefaultTextTitle(
                    textTitle: title,
                    fontSize: IrisScreenUtil.dFontSize(fontSize),
                    fontWeight: FontWeight.w500,
                    color: context.theme.colorScheme.secondary,
                    align: TextAlign.center,
                  ),
                if (subtitle != null)
                  SizedBox(height: IrisScreenUtil.dWidth(23)),
                if (subtitle != null)
                  SizedBox(
                      width: IrisScreenUtil.dWidth(318),
                      child: DefaultTextTitle(
                        textTitle: subtitle,
                        align: TextAlign.center,
                        // fontSize: ScreenUtil().setSp(TextUnit.small),
                        fontSize: IrisScreenUtil.dFontSize(14),
                        color: context.theme.colorScheme.secondary
                            .withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      )),
              ],
            ));
  }
}

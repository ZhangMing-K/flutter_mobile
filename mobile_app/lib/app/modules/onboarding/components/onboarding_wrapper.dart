import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/routes/pages.dart';

class OnboardingWrapper extends StatelessWidget {
  final VoidCallback? onSkip;
  final VoidCallback? onNext;
  final bool showPrevious;
  final Widget child;
  final String? title;
  final bool canBack;
  final String? canNotBackMessage;
  final bool resizeToAvoidBottomInset;
  final double horizontalPadding;
  const OnboardingWrapper({
    Key? key,
    this.onSkip,
    this.onNext,
    this.showPrevious = true,
    this.title,
    required this.child,
    this.canBack = true,
    this.horizontalPadding = 16,
    this.resizeToAvoidBottomInset = false,
    this.canNotBackMessage,
  })  : assert(onSkip == null || onNext == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!canBack) {
          Get.snackbar('Can not back', canNotBackMessage ?? '');
          return false;
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: showPrevious
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Get.back();
                  },
                )
              : null,
          title: title != null ? Text(title!) : null,
          actions: [
            if (onSkip != null)
              _button(
                name: 'Skip',
                color: context.theme.colorScheme.secondary,
                callback: () {
                  onSkip?.call();
                },
              )
            else if (onNext != null)
              _button(
                name: 'Next',
                color: context.theme.primaryColor,
                callback: onNext!,
              )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: IrisScreenUtil.dWidth(horizontalPadding)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _button({
    required String name,
    required VoidCallback callback,
    required Color color,
  }) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: callback,
        child: Row(
          children: [
            Text(
              name,
              style: TextStyle(color: color),
            ),
            Icon(Icons.chevron_right, color: color, size: 36),
          ],
        ),
      );
    });
  }
}

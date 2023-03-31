import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../consts/app_config.dart';
import 'iris_fade_size_widget.dart';

class CustomIndicator extends Decoration {
  final double height;
  final double topRightRadius;
  final double topLeftRadius;
  final double bottomRightRadius;
  final double bottomLeftRadius;
  final Color color;
  final double horizontalPadding;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  const CustomIndicator({
    this.height = 4,
    this.topRightRadius = 5,
    this.topLeftRadius = 5,
    this.bottomRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.color = Colors.black,
    this.horizontalPadding = 0,
    this.paintingStyle = PaintingStyle.fill,
    this.strokeWidth = 2,
  });
  @override
  _CustomPainter3 createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter3(
      this,
      onChanged,
      bottomLeftRadius: bottomLeftRadius,
      bottomRightRadius: bottomRightRadius,
      color: color,
      height: height,
      horizontalPadding: horizontalPadding,
      topLeftRadius: topLeftRadius,
      topRightRadius: topRightRadius,
      paintingStyle: paintingStyle,
      strokeWidth: strokeWidth,
    );
  }
}

class IrisTab {
  final String text;
  final Widget body;
  final Widget? icon;
  final String? upperText;
  final bool? redDot;
  const IrisTab({
    required this.text,
    required this.body,
    this.upperText,
    this.icon,
    this.redDot = false,
  });
}

class IrisTabView extends StatelessWidget {
  final List<IrisTab> tabs;
  final Color? backgroundColor;
  final Function(int index)? onTabChange;
  final int initialIndex;
  final bool keyboardHidesTabbar;
  final Color? indicatorColor;
  final Color? labelColor;
  final double maxFontSize;
  final double baseFontSize;
  final bool isScrollable;
  final List<Widget> actions;
  final double horizontalPadding;
  final TabController? tabController;
  final bool reducedTitle;
  final bool? hideTab;

  ///if true tab indicator will take full height(currently harcoded to 50. TODO make more dynamic)
  ///also, bottom border radius of indicator will be 0
  final bool indicatorFullHeight;

  final Widget? header;

  final BorderRadiusGeometry borderRadius;
  final bool showBackButton;
  const IrisTabView({
    Key? key,
    required this.tabs,
    this.backgroundColor,
    this.onTabChange,
    this.initialIndex = 0,
    required this.indicatorColor,
    this.labelColor,
    this.borderRadius = BorderRadius.zero,
    this.maxFontSize = 20,
    this.baseFontSize = 15,
    this.isScrollable = false,
    this.horizontalPadding = 0,
    this.actions = const <Widget>[],
    this.keyboardHidesTabbar = false,
    this.indicatorFullHeight = false,
    this.tabController,
    this.showBackButton = false,
    this.reducedTitle = false,
    this.header,
    this.hideTab = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IrisTabViewController>(
      global: false,
      init: IrisTabViewController(
          tabs: tabs,
          tabController: tabController,
          onTabChange: onTabChange,
          initialIndex: initialIndex),
      builder: (controller) {
        return Column(
          children: <Widget>[
            IrisFadeSize(
              duration: kTabFadeAnimation,
              visible: !controller._isKeyboardVisible || !keyboardHidesTabbar,
              child: Material(
                // height: 45, // cause bottom overflow in profile search page
                // decoration: BoxDecoration(
                color: backgroundColor ?? context.theme.scaffoldBackgroundColor,
                borderRadius: borderRadius,
                // ),

                child: Row(
                  mainAxisAlignment: showBackButton
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    if (showBackButton)
                      BackButton(
                        onPressed: () {
                          Navigator.pop(context);
                          //Get.back();
                        },
                      ),
                    if (!hideTab!)
                      Expanded(
                        child: TabBar(
                          isScrollable: isScrollable,
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding:
                              EdgeInsets.only(left: horizontalPadding),
                          indicator: indicatorColor == null
                              ? const BoxDecoration()
                              : CustomIndicator(
                                  height: indicatorFullHeight
                                      ? 40
                                      : 2, //TODO make height more respective of the tab full height
                                  strokeWidth: 0,
                                  // This define the curve
                                  topLeftRadius: 5,
                                  topRightRadius: 5,
                                  bottomLeftRadius: 5,
                                  bottomRightRadius: 5,
                                  horizontalPadding: 0,

                                  // horizontalPadding: 18,
                                  color: indicatorColor ??
                                      context.theme.colorScheme.secondary
                                          .withOpacity(.8),
                                ),
                          controller: controller._controller,
                          //                 indicatorColor: indicatorColor ?? context.theme.colorScheme.secondary,
                          labelColor:
                              labelColor ?? context.theme.colorScheme.secondary,

                          labelStyle: reducedTitle
                              ? TextStyle(
                                  fontSize: ScreenUtil().setSp(
                                    22,
                                  ),
                                  color: context.theme.colorScheme.secondary,
                                )
                              : TextStyle(
                                  fontSize: ScreenUtil().setSp(
                                    indicatorColor == null
                                        ? maxFontSize
                                        : baseFontSize,
                                  ),
                                  fontWeight: FontWeight.bold,
                                ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: ScreenUtil().setSp(
                              baseFontSize,
                            ),
                          ),
                          tabs: tabs
                              .map((item) => Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal:
                                          indicatorColor == null ? 0 : 8,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (item.upperText != null)
                                          Text(
                                            item.upperText!,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (item.icon != null)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                  child: item.icon!),
                                            Flexible(
                                              child: AutoSizeText(
                                                item.text,
                                                maxFontSize: maxFontSize,
                                                maxLines: 1,
                                              ),
                                            ),
                                            if (item.redDot!)
                                              Stack(
                                                // alignment: Alignment.center,
                                                children: [
                                                  const SizedBox(
                                                      width: 10, height: 10),
                                                  Positioned(
                                                    top: 2.5,
                                                    right: 0,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.red),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(),
                                                    ),
                                                  )
                                                ],
                                              )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ...actions,
                  ],
                ),
              ),
            ),
            if (header != null) header!,
            Expanded(
              child: TabBarView(
                controller: controller._controller,
                children: tabs.map((item) => item.body).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  static Widget expanded({
    required List<IrisTab> tabs,
    required Color backgroundColor,
    Function(int index)? onTabChange,
    int initialIndex = 0,
    List<Widget> actions = const <Widget>[],
    bool keyboardHidesTabbar = false,
    TabController? tabController,
    Widget? header,
    double maxFontSize = 28,
    bool showBackButton = false,
    double horizontalPadding = 16.0,
    bool reducedTitle = false,
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    bool? hideTab = false,
  }) {
    return SafeArea(
      bottom: false,
      child: IrisTabView(
          maxFontSize: maxFontSize,
          showBackButton: showBackButton,
          backgroundColor: backgroundColor,
          baseFontSize: 20,
          isScrollable: true,
          horizontalPadding: horizontalPadding,
          indicatorColor: null,
          actions: actions,
          reducedTitle: reducedTitle,
          initialIndex: initialIndex,
          keyboardHidesTabbar: keyboardHidesTabbar,
          onTabChange: onTabChange,
          tabs: tabs,
          borderRadius: borderRadius,
          tabController: tabController,
          header: header,
          hideTab: hideTab),
    );
  }
}

class IrisTabViewController extends GetxController
    with GetTickerProviderStateMixin {
  final List<IrisTab> tabs;

  final Function(int index)? onTabChange;
  int? initialIndex;
  TabController? tabController;
  TabController? _controller;

  final _isKeyboardVisible = false;

  IrisTabViewController({
    required this.tabs,
    required this.onTabChange,
    this.initialIndex,
    this.tabController,
  });

  @override
  void onClose() {
    // AppController.to.removeKeyboardListener(_keyboardListener);
    _controller!.removeListener(_listener);
    _controller!.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    // AppController.to.addKeyboardListener(_keyboardListener);
    super.onInit();
    if (tabController == null) {
      _controller = TabController(
        vsync: this,
        length: tabs.length,
        initialIndex: initialIndex ?? 0,
      );
    } else {
      _controller = tabController;
    }
    _controller!.addListener(_listener);
  }

  // void _keyboardListener(bool isKeyboardOpen) {
  //   Future.delayed(kKeyboardTransition).then((value) {
  //     _isKeyboardVisible = isKeyboardOpen;
  //     update();
  //   });
  // }

  void _listener() {
    onTabChange?.call(_controller!.index);
  }
}

class _CustomPainter3 extends BoxPainter {
  final CustomIndicator decoration;
  final double height;
  final double topRightRadius;
  final double topLeftRadius;
  final double bottomRightRadius;
  final double bottomLeftRadius;
  final Color color;
  final double horizontalPadding;
  final double strokeWidth;
  final PaintingStyle paintingStyle;

  _CustomPainter3(
    this.decoration,
    VoidCallback? onChanged, {
    required this.height,
    required this.topRightRadius,
    required this.topLeftRadius,
    required this.bottomRightRadius,
    required this.bottomLeftRadius,
    required this.color,
    required this.horizontalPadding,
    required this.paintingStyle,
    required this.strokeWidth,
  }) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final mysize =
        Size(configuration.size!.width - (horizontalPadding * 2), height);

    final myoffset = Offset(
      offset.dx + horizontalPadding,
      offset.dy + (configuration.size!.height - height),
    );

    final Rect rect = myoffset & mysize;
    final Paint paint = Paint();
    paint.color = color;
    paint.style = paintingStyle;
    paint.strokeWidth = strokeWidth;
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          rect,
          bottomRight: Radius.circular(bottomRightRadius),
          bottomLeft: Radius.circular(bottomLeftRadius),
          topLeft: Radius.circular(topLeftRadius),
          topRight: Radius.circular(topRightRadius),
        ),
        paint);
  }
}

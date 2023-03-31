import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

enum APP_MENU_STYLE { TAB, BUTTON }

class AppMenu<T> extends StatefulWidget {
  final List<MenuItem<T>> items;
  final Function(MenuItem<T> menuItem)? onChange;
  final int? numberShown;
  final bool haptic;
  final T? activeTabId;
  final bool isScrollable;
  final APP_MENU_STYLE style;
  final Color? indicatorColor;
  const AppMenu(
      {Key? key,
      required this.items,
      this.onChange,
      this.numberShown,
      this.activeTabId,
      this.indicatorColor,
      this.haptic = true,
      this.isScrollable = false,
      this.style = APP_MENU_STYLE.TAB})
      : super(key: key);

  int get activeIndex {
    int index = 0;
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      if (item.id == currentActiveTabId) {
        index = i;
        break;
      }
    }
    return index;
  }

  T? get currentActiveTabId {
    if (activeTabId != null) {
      return activeTabId;
    } else {
      return items[0].id;
    }
  }

  @override
  _AppMenuState createState() => _AppMenuState();
}

class MenuItem<T> {
  final String? name;
  final String? upperText;
  final T id;
  const MenuItem({required this.name, required this.id, this.upperText});
}

class _AppMenuState extends State<AppMenu> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  Color? get indicatorColor {
    if (widget.style == APP_MENU_STYLE.BUTTON) {
      return null;
    }
    return context.theme.primaryColor;
  }

  Color get labelColor {
    if (widget.style == APP_MENU_STYLE.BUTTON) {
      return Colors.white;
    }
    return context.theme.primaryColor;
  }

  Color get unselectedLabelColor {
    if (widget.style == APP_MENU_STYLE.BUTTON) {
      return Get.theme.colorScheme.secondary;
    }
    return const Color(0xff5f6368);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: labelColor,
        unselectedLabelColor: unselectedLabelColor,
        indicator: getIndicator(),
        indicatorColor: indicatorColor,
        isScrollable: widget.isScrollable,
        onTap: onTap,
        tabs: getTabs(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  RectangularIndicator? getIndicator() {
    if (widget.style == APP_MENU_STYLE.BUTTON) {
      return RectangularIndicator(
          color: widget.indicatorColor ?? IrisColor.positiveChange,
          bottomRightRadius: 5,
          bottomLeftRadius: 5,
          horizontalPadding: 9,
          verticalPadding: 8);
    }
    return null;
  }

  Tab getTab({MenuItem? item, bool active = false}) {
    if (widget.style == APP_MENU_STYLE.BUTTON && active == true) {
      return tab(name: item!.name);
    }
    return item!.upperText != null
        ? inlineText(text1: item.upperText!, text2: item.name!)
        : tab(name: item.name);
  }

  List<Tab> getTabs() {
    final List<Tab> tabs = [];
    for (var i = 0; i < widget.items.length; i++) {
      final item = widget.items[i];
      final bool active = widget.activeIndex == i;
      tabs.add(getTab(item: item, active: active));
    }
    return tabs;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        vsync: this,
        length: widget.items.length,
        initialIndex: widget.activeIndex);
  }

  Tab inlineText({required String text1, required String text2}) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text1),
          Text(
            text2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  MenuItem onTap(int index) {
    if (widget.haptic) {
      HapticFeedback.lightImpact();
    }
    final item = widget.items[index];
    if (widget.onChange != null) {
      widget.onChange!(item);
    }
    return item;
  }

  Tab tab({String? name}) {
    return Tab(
      text: name,
    );
  }
}

class RectangularIndicator extends Decoration {
  /// topRight radius of the indicator, default to 5.
  final double topRightRadius;

  /// topLeft radius of the indicator, default to 5.
  final double topLeftRadius;

  /// bottomRight radius of the indicator, default to 0.
  final double bottomRightRadius;

  /// bottomLeft radius of the indicator, default to 0
  final double bottomLeftRadius;

  /// Color of the indicator, default set to [Colors.black]
  final Color color;

  /// Horizontal padding of the indicator, default set to 0
  final double horizontalPadding;

  /// Vertical padding of the indicator, default set to 0
  final double verticalPadding;

  /// [PagingStyle] determines if the indicator should be fill or stroke, default to fill
  final PaintingStyle paintingStyle;

  /// StrokeWidth, used for [PaintingStyle.stroke], default set to 0
  final double strokeWidth;

  const RectangularIndicator({
    this.topRightRadius = 5,
    this.topLeftRadius = 5,
    this.bottomRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.color = Colors.black,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.paintingStyle = PaintingStyle.fill,
    this.strokeWidth = 2,
  });
  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(
      this,
      onChanged,
      bottomLeftRadius: bottomLeftRadius,
      bottomRightRadius: bottomRightRadius,
      color: color,
      horizontalPadding: horizontalPadding,
      topLeftRadius: topLeftRadius,
      topRightRadius: topRightRadius,
      verticalPadding: verticalPadding,
      paintingStyle: paintingStyle,
      strokeWidth: strokeWidth,
    );
  }
}

class _CustomPainter extends BoxPainter {
  final RectangularIndicator decoration;
  final double topRightRadius;
  final double topLeftRadius;
  final double bottomRightRadius;
  final double bottomLeftRadius;
  final Color color;
  final double horizontalPadding;
  final double verticalPadding;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  _CustomPainter(
    this.decoration,
    VoidCallback? onChanged, {
    required this.topRightRadius,
    required this.topLeftRadius,
    required this.bottomRightRadius,
    required this.bottomLeftRadius,
    required this.color,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.paintingStyle,
    required this.strokeWidth,
  }) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(horizontalPadding >= 0);
    assert(horizontalPadding < configuration.size!.width / 2,
        "Padding must be less than half of the size of the tab");
    assert(verticalPadding < configuration.size!.height / 2 &&
        verticalPadding >= 0);
    assert(strokeWidth >= 0 &&
        strokeWidth < configuration.size!.width / 2 &&
        strokeWidth < configuration.size!.height / 2);

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    Size mysize = Size(configuration.size!.width - (horizontalPadding * 2),
        configuration.size!.height - (2 * verticalPadding));

    Offset myoffset =
        Offset(offset.dx + (horizontalPadding), offset.dy + verticalPadding);
    final Rect rect = myoffset & mysize;
    final Paint paint = Paint();
    paint.color = color;
    paint.style = paintingStyle;
    paint.strokeWidth = 3;
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

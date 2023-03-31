import 'dart:ui';

// part of 'floating_search_bar.dart';

import 'package:flutter/material.dart'
    hide ImplicitlyAnimatedWidget, ImplicitlyAnimatedWidgetState;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'search_bar_style.dart';
import 'text_controller.dart';
import 'util/util.dart';
import 'widgets/animated_input.dart';
import 'widgets/implicitly_animated_widget.dart';

typedef OnQueryChangedCallback = void Function(String query);

typedef OnFocusChangedCallback = void Function(bool isFocused);

/// A controller for a [FloatingSearchBar].
class FloatingSearchBarController {
  /// Creates a controller for a [FloatingSearchBar].
  FloatingSearchBarController();

  FloatingSearchAppBarState? _appBarState;

  /// Opens/Expands the [FloatingSearchBar].
  void open() => _appBarState?.open();

  /// Closes/Collapses the [FloatingSearchBar].
  void close() => _appBarState?.close();

  /// Sets the query of the input of the [FloatingSearchBar].
  set query(String? query) {
    if (_appBarState == null) {
      postFrame(() => _appBarState?.query = query);
    } else {
      _appBarState?.query = query;
    }
  }

  /// The current query of the [FloatingSearchBar].
  String? get query => _appBarState?.query;

  /// Cleares the current query.
  void clear() => _appBarState?.clear();

  /// Whether the [FloatingSearchBar] is currently
  /// opened/expanded.
  bool get isOpen => _appBarState?.isOpen == true;

  /// Whether the [FloatingSearchBar] is currently
  /// closed/collapsed.
  bool get isClosed => _appBarState?.isOpen == false;

  /// Disposes this controller.
  void dispose() {
    _appBarState = null;
  }
}

/// An [AppBar] with implemented search functionality and other
/// utility functions to implement a material behavior.
///
/// This can be considered the base Widget for the full
/// [FloatingSearchBar].
class FloatingSearchAppBar extends ImplicitlyAnimatedWidget {
  /// The widget displayed below the [FloatingSearchAppBar]
  final Widget body;

  // * --- Style properties --- *

  /// The accent color used for example for the
  /// progress indicator
  final Color? accentColor;

  /// The background color of the bar
  final Color? color;

  /// The color of the bar when a [Scrollable]
  /// inside the [body] was scrolled (i.e. is not at the top)
  final Color? colorOnScroll;

  /// The shadow color for the elevation
  final Color? shadowColor;

  /// Can be used to override the `IconThemeDatas` color
  final Color? iconColor;

  /// The padding of the bar
  final EdgeInsetsGeometry? padding;

  /// The horizontal spacing between [leadingActions], the input
  /// field and [actions]
  final EdgeInsetsGeometry? insets;

  /// The height of the bar
  ///
  /// Defaults to `56.0`
  final double height;

  /// The elevation of the bar
  final double elevation;

  /// The elevation of the bar when a [Scrollable]
  /// inside the [body] was scrolled (i.e. it's not at the top)
  final double liftOnScrollElevation;

  /// The [TextStyle] for the hint of the input field
  final TextStyle? hintStyle;

  /// The [TextStyle] for the title of the bar
  final TextStyle? titleStyle;

  /// The [Brightness] that is used for adjusting the
  /// status bar icon brightness.
  ///
  /// By default the brightness is dynamically calculated
  /// based on the brightness of the [color] or
  /// the [colorOnScroll] respectively.
  final Brightness? brightness;

  // * --- Utility --- *
  final Widget? bottom;

  /// Whether the bar should be always in opened state.
  ///
  /// This is useful for example, if you have a page
  /// dedicated only for search.
  final bool alwaysOpened;

  /// {@macro floating_search_bar.clearQueryOnClose}
  final bool clearQueryOnClose;

  /// {@macro floating_search_bar.automaticallyImplyDrawerHamburger}
  final bool automaticallyImplyDrawerHamburger;

  /// {@macro floating_search_bar.automaticallyImplyBackButton}
  final bool automaticallyImplyBackButton;

  /// Hides the keyboard a [Scrollable] inside the [body] was scrolled and
  /// shows it again when the user scrolls to the top.
  final bool hideKeyboardOnDownScroll;

  /// {@macro floating_search_bar.progress}
  final dynamic progress;

  /// {@macro floating_search_bar.transitionDuration}
  final Duration transitionDuration;

  /// {@macro floating_search_bar.transitionCurve}
  final Curve transitionCurve;

  /// {@macro floating_search_bar.debounceDelay}
  final Duration debounceDelay;

  /// {@macro floating_search_bar.title}
  final Widget? title;

  /// {@macro floating_search_bar.hint}
  final String hint;

  /// {@macro floating_search_bar.actions}
  final List<Widget>? actions;

  /// {@macro floating_search_bar.leadingActions}
  final List<Widget>? leadingActions;

  /// {@macro floating_search_bar.onQueryChanged}
  final OnQueryChangedCallback? onQueryChanged;

  /// {@macro floating_search_bar.onSubmitted}
  final OnQueryChangedCallback? onSubmitted;

  /// {@macro floating_search_bar.onFocusChanged}
  final OnFocusChangedCallback? onFocusChanged;

  /// {@macro floating_search_bar.controller}
  final FloatingSearchBarController? controller;

  /// {@macro floating_search_bar.textInputAction}
  final TextInputAction textInputAction;

  /// {@macro floating_search_bar.textInputType}
  final TextInputType textInputType;

  /// {@macro floating_search_bar.autocorrect}
  final bool autocorrect;

  final bool showBack;

  final VoidCallback? onTapInput;
  final VoidCallback? onTapCancel;

  /// {@macro floating_search_bar.toolbarOptions}
  final ToolbarOptions? toolbarOptions;
  const FloatingSearchAppBar(
      {Key? key,
      Duration implicitDuration = const Duration(milliseconds: 500),
      Curve implicitCurve = Curves.linear,
      required this.body,
      this.accentColor,
      this.color,
      this.colorOnScroll,
      this.shadowColor,
      this.iconColor,
      this.padding,
      this.insets,
      this.height = 56.0,
      this.elevation = 0.0,
      this.liftOnScrollElevation = 4.0,
      this.hintStyle,
      this.titleStyle,
      this.brightness,
      this.bottom,
      this.alwaysOpened = false,
      this.clearQueryOnClose = true,
      this.automaticallyImplyDrawerHamburger = true,
      this.hideKeyboardOnDownScroll = false,
      this.automaticallyImplyBackButton = true,
      this.progress = 0.0,
      this.transitionDuration = const Duration(milliseconds: 500),
      this.transitionCurve = Curves.fastLinearToSlowEaseIn,
      this.debounceDelay = Duration.zero,
      this.title,
      this.hint = 'Search...',
      this.actions,
      this.leadingActions,
      this.onQueryChanged,
      this.onSubmitted,
      this.onFocusChanged,
      this.controller,
      this.textInputAction = TextInputAction.search,
      this.textInputType = TextInputType.text,
      this.autocorrect = true,
      this.toolbarOptions,
      this.showBack = false,
      this.onTapInput,
      this.onTapCancel})
      : assert(progress == null || (progress is num || progress is bool)),
        super(key, implicitDuration, implicitCurve);

  static FloatingSearchAppBarState? of(BuildContext context) {
    return context.findAncestorStateOfType<FloatingSearchAppBarState>();
  }

  @override
  FloatingSearchAppBarState createState() => FloatingSearchAppBarState();
}

class FloatingSearchAppBarState extends ImplicitlyAnimatedWidgetState<
    FloatingSearchAppBarStyle, FloatingSearchAppBar> {
  final ValueNotifier<String> queryNotifer = ValueNotifier('');
  final Handler _handler = Handler();

  late AnimationController controller;
  late Animation transitionAnimation;

  late AnimationController scrollController;
  late Animation scrollAnimation;

  late AnimationController barAnimationController;
  Animation? barAnimation;

  TextController? _input;
  bool _wasUnfocusedOnScroll = false;

  bool _isAtTop = true;
  bool get isAtTop => _isAtTop;

  bool get isAppBar => widget.body != null;
  bool get isAlwaysOpened => widget.alwaysOpened;
  double get _statusBarHeight => MediaQuery.of(context).viewPadding.top;

  Duration get transitionDuration => widget.transitionDuration;

  FloatingSearchAppBarStyle? get style => value;
  double? get height => style!.height;
  double? get elevation => style!.elevation;
  Color? get accentColor => style!.accentColor;
  Color? get iconColor => style!.iconColor;
  Color? get shadowColor => style!.shadowColor;
  Color? get backgroundColor => Color.lerp(
      style!.backgroundColor, style!.colorOnScroll, scrollAnimation.value);

  bool _isOpen = false;
  bool get isOpen => _isOpen;
  set isOpen(bool value) {
    if (value) {
      post(transitionDuration, focus);
      controller.forward();
    } else {
      unfocus();
      if (!widget.alwaysOpened) {
        controller.reverse();
      }
    }
    if (widget.alwaysOpened) {
      _isOpen = true;
      return;
    }

    if (value != isOpen) {
      _isOpen = value;
      widget.onFocusChanged?.call(isOpen);
    }
  }

  bool get hasFocus => _input!.hasFocus;
  set hasFocus(bool value) => value ? focus() : unfocus();

  String get query => _input!.text;
  set query(String? value) => _input!.text = value;

  RxBool isQueryEmpty = true.obs;

  @override
  void initState() {
    super.initState();

    barAnimationController = AnimationController(
        duration: const Duration(microseconds: 500), vsync: this);
    barAnimation =
        CurvedAnimation(parent: barAnimationController, curve: Curves.linear);

    // barAnimation = Tween<double>(begin: 0, end: 300).animate(barAnimationController);
    barAnimationController.forward();

    _input = TextController()
      ..addListener(() {
        if (_input!.text != queryNotifer.value) {
          queryNotifer.value = _input!.text;

          _handler.post(
            // Do not add a delay when the query is empty.
            _input!.text.isEmpty ? Duration.zero : widget.debounceDelay,
            () => {
              isQueryEmpty.value = _input!.text.isEmpty ? true : false,
              widget.onQueryChanged?.call(_input!.text)
            },
          );
        }
      });

    controller = AnimationController(vsync: this, duration: transitionDuration)
      ..value = isAlwaysOpened ? 1.0 : 0.0
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        _setInsets();

        if (status == AnimationStatus.dismissed) {
          if (widget.clearQueryOnClose) clear();
        }
      });

    transitionAnimation = CurvedAnimation(
      parent: controller,
      curve: widget.transitionCurve,
    );

    scrollController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() => setState(() {}));

    scrollAnimation = CurvedAnimation(
      parent: scrollController,
      curve: Curves.easeInOutCubic,
    );

    if (isAlwaysOpened) {
      _isOpen = true;
      postFrame(_input!.requestFocus);
    }

    _assignController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _setInsets();
  }

  @override
  void didUpdateWidget(FloatingSearchAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    controller.duration = transitionDuration;
    if (widget.transitionCurve != oldWidget.transitionCurve) {
      transitionAnimation = CurvedAnimation(
        parent: controller,
        curve: widget.transitionCurve,
      );
    }

    _assignController();
  }

  void open() => isOpen = true;
  void close() => isOpen = false;

  void focus() {
    _wasUnfocusedOnScroll = false;
    _input!.requestFocus();
  }

  void unfocus() {
    _wasUnfocusedOnScroll = false;
    _input!.clearFocus();
  }

  void clear() => _input!.clear();

  void _assignController() => widget.controller?._appBarState = this;

  EdgeInsets? insets;
  void _setInsets() {
    insets = EdgeInsets.lerp(
      style!.insets!.copyWith(
        left: null,
        right: null,
      ),
      style!.insets,
      transitionAnimation.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isAppBar) {
      return _buildAppBar();
    } else {
      return _buildBar();
    }
  }

  Widget _buildAppBar() {
    final height = style!.height! + _statusBarHeight;
    double prevPixels = 0.0;

    final brightness = widget.brightness ??
        (backgroundColor!.computeLuminance() > 0.7
            ? Brightness.light
            : Brightness.dark);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: brightness == Brightness.dark
          ? const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light)
          : const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.axis != Axis.vertical) return false;

          final pixels = notification.metrics.pixels;

          if (widget.hideKeyboardOnDownScroll) {
            final isDown = pixels > prevPixels;
            if (isDown && hasFocus) {
              unfocus();
              _wasUnfocusedOnScroll = true;
            }
          }

          final isAtTop = pixels < 1.0;
          if (isAtTop != _isAtTop) {
            _isAtTop = isAtTop;
            isAtTop ? scrollController.reverse() : scrollController.forward();
          }

          prevPixels = pixels;

          return false;
        },
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height),
              child: widget.body,
            ),
            _buildBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar() {
    final statusBarHeight = isAppBar ? _statusBarHeight : 0.0;
    final elevation = lerpDouble(
      style!.elevation,
      style!.liftOnScrollElevation,
      scrollAnimation.value,
    )!;

    final bar = GestureDetector(
      onTap: () {
        if (isOpen) {
          hasFocus = !hasFocus;
          _input!.moveCursorToEnd();
        } else if (!isAppBar) {
          isOpen = true;
        }
      },
      child: Material(
        color: backgroundColor,
        elevation: elevation,
        child: Container(
          height: style!.height! + statusBarHeight,
          padding: style!.padding!.add(EdgeInsets.only(top: statusBarHeight)),
          child: _buildInputAndActions(),
        ),
      ),
    );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        bar,
      ],
    );
  }

  Widget _buildInputAndActions() {
    return Obx(() {
      return AnimatedInput(
        input: _input,
        style: style,
        hintText: widget.hint,
        onTapInput: () {
          isOpen = true;
          if (widget.onTapInput != null) widget.onTapInput!();
        },
        showBack: widget.showBack,
        onTapCancel: () {
          clear();
          isOpen = false;
          if (widget.onTapCancel != null) widget.onTapCancel!();
        },
        showCloseIcon: !isQueryEmpty.value,
      );
    });
  }

  @override
  void dispose() {
    queryNotifer.dispose();
    controller.dispose();
    scrollController.dispose();
    _handler.cancel();
    super.dispose();
  }

  // * Implicit animation stuff

  @override
  FloatingSearchAppBarStyle get newValue {
    final theme = Theme.of(context);
    final appBar = theme.appBarTheme;
    final direction = Directionality.of(context);

    return FloatingSearchAppBarStyle(
      accentColor: widget.accentColor ?? theme.colorScheme.secondary,
      backgroundColor: widget.color ?? theme.cardColor,
      iconColor: widget.iconColor ?? theme.iconTheme.color,
      colorOnScroll: widget.colorOnScroll ?? appBar.backgroundColor,
      shadowColor: widget.shadowColor ?? appBar.shadowColor ?? Colors.black54,
      elevation: widget.elevation,
      liftOnScrollElevation: widget.liftOnScrollElevation,
      height: widget.height,
      padding: widget.padding?.resolve(direction) ??
          const EdgeInsetsDirectional.only(
            start: 0,
            end: 0,
          ).resolve(direction),
      insets: widget.insets?.resolve(direction) ??
          EdgeInsetsDirectional.only(
            start: ScreenUtil().setWidth(16),
          ).resolve(direction),
      hintStyle: widget.hintStyle,
      queryStyle: widget.titleStyle,
    );
  }

  @override
  FloatingSearchAppBarStyle lerp(
    FloatingSearchAppBarStyle? a,
    FloatingSearchAppBarStyle b,
    double t,
  ) =>
      a!.scaleTo(b, t);
}

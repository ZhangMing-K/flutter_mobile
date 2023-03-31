import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/types/index.dart';
import '../consts/app_config.dart';
import '../keyboard/keyboard_listener_mixin.dart';
import 'iris_fade_size_widget.dart';
import 'iris_widget_loader.dart';

class IrisListView extends StatefulWidget {
  final IndexedWidgetBuilder builder;
  final int? itemCount;
  final bool shrinkWrap;
  final Future<void> Function()? loadMore;
  final Widget? widgetLoader;
  final Widget? emptyWidget;
  final Widget? header;
  final API_STATUS apiStatus;
  final bool reverse;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final Future<void> Function()? onRefresh;
  final double? height;
  final ScrollController? controller;
  final bool keyboardHidesHeader;
  final bool? primary;

  const IrisListView({
    Key? key,
    required this.builder,
    this.itemCount,
    this.loadMore,
    this.widgetLoader,
    this.onRefresh,
    this.header,
    this.reverse = false,
    this.emptyWidget,
    this.apiStatus = API_STATUS.FINISHED,
    this.shrinkWrap = false,
    this.scrollDirection = Axis.vertical,
    this.physics = const BouncingScrollPhysics(),
    this.height,
    this.keyboardHidesHeader = false,
    this.controller,
    this.primary,
    //  this.findChildIndexCallback,
    //  this.scrollController,
  }) : super(key: key);

  //final int Function(Key) findChildIndexCallback;
  @override
  IrisListViewState createState() => IrisListViewState();
}

class IrisListViewState extends State<IrisListView> {
  late ScrollController scrollController;

  bool moreToLoad = true;

  // Aaron Langley: copied this code from the cupertino package
  // in order to control the size of the cupertino spinner
  static Widget buildRefreshIndicator(
    BuildContext context,
    RefreshIndicatorMode refreshState,
    double pulledExtent,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent,
  ) {
    final double percentageComplete =
        (pulledExtent / refreshTriggerPullDistance).clamp(0.0, 1.0);
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            top: 16.0,
            left: 0.0,
            right: 0.0,
            child: _buildIndicatorForRefreshState(
                refreshState, 10, percentageComplete),
          ),
        ],
      ),
    );
  }

  static Widget _buildIndicatorForRefreshState(
      RefreshIndicatorMode refreshState,
      double radius,
      double percentageComplete) {
    switch (refreshState) {
      case RefreshIndicatorMode.drag:
        const Curve opacityCurve = Interval(0.0, 0.35, curve: Curves.easeInOut);
        return Opacity(
          opacity: opacityCurve.transform(percentageComplete),
          child: CupertinoActivityIndicator.partiallyRevealed(
              radius: radius, progress: percentageComplete),
        );
      case RefreshIndicatorMode.armed:
      case RefreshIndicatorMode.refresh:
        // Once we're armed or performing the refresh, we just show the normal spinner.
        return CupertinoActivityIndicator(radius: radius);
      case RefreshIndicatorMode.done:
        // When the user lets go, the standard transition is to shrink the spinner.
        return CupertinoActivityIndicator(radius: radius * percentageComplete);
      case RefreshIndicatorMode.inactive:
        // Anything else doesn't show anything.
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        primary: widget.primary,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        reverse: widget.reverse,
        controller: scrollController,
        slivers: <Widget>[
          if (widget.onRefresh != null)
            //TODO replace this with a platform adaptive loading indicator
            CupertinoSliverRefreshControl(
              refreshTriggerPullDistance: 100.0,
              refreshIndicatorExtent: 70.0,
              builder: buildRefreshIndicator,
              onRefresh: () {
                return widget.onRefresh?.call() ?? () async {} as Future<void>;
              },
            ),
          SliverToBoxAdapter(
            child: widget.header == null
                ? Container()
                : Visibility(
                    visible: widget.keyboardHidesHeader,
                    replacement: widget.header!,
                    child: Builder(
                      builder: (context) {
                        return IrisFadeSize(
                          duration: kTabFadeAnimation * 1.7,
                          visible: !context.isKeyboardOpen,
                          child: widget.header!,
                        );
                      },
                    ),
                  ),
          ),
          if (widget.itemCount == 0 && widget.apiStatus == API_STATUS.PENDING)
            SliverToBoxAdapter(
              child: widget.widgetLoader ?? Container(),
            )
          else if (widget.itemCount == 0 &&
              widget.apiStatus == API_STATUS.EMPTY)
            SliverToBoxAdapter(
              child: widget.emptyWidget ?? Container(),
            )
          else if (widget.itemCount == 0 &&
              widget.apiStatus == API_STATUS.FINISHED)
            SliverToBoxAdapter(
              child: widget.emptyWidget ?? Container(),
            )
          else if (widget.scrollDirection == Axis.vertical)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (widget.itemCount! > index) {
                    return widget.builder(context, index);
                  }
                  return WidgetLoader(
                    placeholder: widget.widgetLoader,
                    loadMore: widget.loadMore,
                  );
                },

                // findChildIndexCallback: widget.findChildIndexCallback,
                childCount: (widget.itemCount == 0) ? 0 : widget.itemCount! + 1,
                addAutomaticKeepAlives: false,
              ),
            )
          else
            SliverToBoxAdapter(
              child: SizedBox(
                width: double.infinity,
                height: widget.height,
                child: ListView.builder(
                  primary: widget.primary,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      (widget.itemCount == 0) ? 0 : widget.itemCount! + 1,
                  addAutomaticKeepAlives: false,
                  itemBuilder: (BuildContext context, int index) {
                    if (widget.itemCount! > index) {
                      return widget.builder(context, index);
                    }
                    return WidgetLoader(
                      placeholder: widget.widgetLoader,
                      loadMore: widget.loadMore,
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    scrollController = widget.controller ??
        PrimaryScrollController.of(context) ??
        ScrollController();
    super.didChangeDependencies();
  }

  void scrollToTop() {
    //final scrollController = PrimaryScrollController.of(context)!;
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }
}

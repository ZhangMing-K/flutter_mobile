import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/index.dart';
import 'package:provider/provider.dart';

import 'components/gestures.dart';
import 'components/indicators.dart';
import 'story_limit_controller.dart';
import 'story_stack_controller.dart';

typedef _StoryItemBuilder = Widget Function(
    BuildContext context, int pageIndex, int storyIndex);

typedef StoryOnChanged = void Function(int pageIndex, int storyIndex);
typedef StoryReacted = void Function(int pageIndex, int storyIndex);
typedef _StoryItemBottomBuilder = Widget Function(
    BuildContext context,
    int pageIndex,
    int storyIndex,
    AnimationController animationController,
    Function onTapLike);

typedef _StoryConfigFunction = int Function(int pageIndex);

/// PageView to implement story like UI
///
/// [itemBuilder], [storyLength], [pageLength] are required.
class StoryPageView extends StatefulWidget {
  const StoryPageView(
      {Key? key,
      required this.itemBuilder,
      required this.storyLength,
      required this.pageLength,
      this.gestureItemBuilder,
      this.bottomGestureBuilder,
      this.initialStoryIndex,
      this.initialPage = 0,
      this.onPageLimitReached,
      this.onChangedStory,
      this.indicatorDuration = const Duration(seconds: 5),
      this.indicatorPadding =
          const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      this.backgroundColor = Colors.black,
      this.reactStory,
      this.viewFull = true})
      : super(key: key);

  /// Function to build story content
  final _StoryItemBuilder itemBuilder;

  /// Function to build story content
  /// Components with gesture actions are expected
  /// Placed above the story gestures.
  final _StoryItemBuilder? gestureItemBuilder;
  final _StoryItemBottomBuilder? bottomGestureBuilder;

  /// decides length of story for each page
  final _StoryConfigFunction storyLength;

  /// length of [StoryPageView]
  final int pageLength;

  /// Initial index of story for each page
  final _StoryConfigFunction? initialStoryIndex;

  /// padding of [Indicators]
  final EdgeInsetsGeometry indicatorPadding;

  /// duration of [Indicators]
  final Duration indicatorDuration;

  /// Called when the very last story is finished.
  ///
  /// Functions like "Navigator.pop(context)" is expected.
  final VoidCallback? onPageLimitReached;

  /// Called when the very last story is finished.
  ///
  /// Functions like "Navigator.pop(context)" is expected.
  final StoryOnChanged? onChangedStory;

  /// initial index for [StoryPageView]
  final int initialPage;

  final Color backgroundColor;

  final StoryReacted? reactStory;

  final bool? viewFull;

  @override
  _StoryPageViewState createState() => _StoryPageViewState();
}

class _StoryPageViewState extends State<StoryPageView> {
  PageController? pageController;

  var currentPageValue;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialPage);

    currentPageValue = widget.initialPage.toDouble();

    pageController!.addListener(() {
      setState(() {
        currentPageValue = pageController!.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: widget.backgroundColor,
      child: PageView.builder(
        controller: pageController,
        itemCount: widget.pageLength,
        itemBuilder: (context, index) {
          final isLeaving = (index - currentPageValue) <= 0;
          final t = (index - currentPageValue);
          final rotationY = lerpDouble(0, 30, t as double)!;
          const maxOpacity = 0.8;
          final num opacity =
              lerpDouble(0, maxOpacity, t.abs())!.clamp(0.0, maxOpacity);
          final isPaging = opacity != maxOpacity;
          final transform = Matrix4.identity();
          transform.setEntry(3, 2, 0.003);
          transform.rotateY(-rotationY * (pi / 180.0));
          return Transform(
            alignment: isLeaving ? Alignment.centerRight : Alignment.centerLeft,
            transform: transform,
            child: Stack(
              children: [
                _StoryPageFrame.wrapped(
                    pageLength: widget.pageLength,
                    storyLength: widget.storyLength(index),
                    initialStoryIndex:
                        widget.initialStoryIndex?.call(index) ?? 0,
                    pageIndex: index,
                    animateToPage: (index) {
                      if (widget.reactStory != null) {
                        widget.reactStory!(index, 0);
                      }
                      pageController!.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    isCurrentPage: currentPageValue == index,
                    isPaging: isPaging,
                    onChangedStory: widget.onChangedStory,
                    onPageLimitReached: widget.onPageLimitReached,
                    itemBuilder: widget.itemBuilder,
                    gestureItemBuilder: widget.gestureItemBuilder,
                    bottomGestureBuilder: widget.bottomGestureBuilder,
                    indicatorDuration: widget.indicatorDuration,
                    indicatorPadding: widget.indicatorPadding,
                    reactStory: widget.reactStory,
                    viewFull: widget.viewFull,
                    pageController: pageController!),
                if (isPaging && !isLeaving)
                  Positioned.fill(
                    child: Opacity(
                      opacity: opacity as double,
                      child: const ColoredBox(
                        color: Colors.black87,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StoryPageFrame extends StatefulWidget {
  const _StoryPageFrame._({
    Key? key,
    required this.storyLength,
    required this.initialStoryIndex,
    required this.pageIndex,
    required this.isCurrentPage,
    required this.isPaging,
    required this.itemBuilder,
    required this.gestureItemBuilder,
    required this.bottomGestureBuilder,
    required this.indicatorDuration,
    required this.indicatorPadding,
    this.reactStory,
    required this.pageController,
    required this.viewFull,
  }) : super(key: key);
  final int storyLength;
  final int initialStoryIndex;
  final int pageIndex;
  final bool isCurrentPage;
  final bool isPaging;
  final _StoryItemBuilder itemBuilder;
  final _StoryItemBuilder? gestureItemBuilder;
  final _StoryItemBottomBuilder? bottomGestureBuilder;
  final Duration indicatorDuration;
  final EdgeInsetsGeometry indicatorPadding;
  final StoryReacted? reactStory;
  final PageController pageController;
  final bool? viewFull;

  static Widget wrapped({
    required int pageIndex,
    required int pageLength,
    required ValueChanged<int> animateToPage,
    required int storyLength,
    required int initialStoryIndex,
    required bool isCurrentPage,
    required bool isPaging,
    required VoidCallback? onPageLimitReached,
    required StoryOnChanged? onChangedStory,
    required _StoryItemBuilder itemBuilder,
    _StoryItemBuilder? gestureItemBuilder,
    _StoryItemBottomBuilder? bottomGestureBuilder,
    required Duration indicatorDuration,
    required EdgeInsetsGeometry indicatorPadding,
    required StoryReacted? reactStory,
    required PageController pageController,
    required bool? viewFull,
  }) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_context) => StoryLimitController(),
        ),
        ChangeNotifierProvider(
          create: (_context) => StoryStackController(
            storyLength: storyLength,
            onChangeStory: onChangedStory,
            pageIndex: pageIndex,
            onPageBack: () {
              if (pageIndex != 0) {
                animateToPage(pageIndex - 1);
              }
            },
            reactStory: reactStory,
            onPageForward: () {
              if (pageIndex == pageLength - 1) {
                _context
                    .read<StoryLimitController>()
                    .onPageLimitReached(onPageLimitReached);
              } else {
                animateToPage(pageIndex + 1);
              }
            },
            initialStoryIndex: initialStoryIndex,
          ),
        ),
      ],
      child: _StoryPageFrame._(
        storyLength: storyLength,
        initialStoryIndex: initialStoryIndex,
        pageIndex: pageIndex,
        isCurrentPage: isCurrentPage,
        isPaging: isPaging,
        itemBuilder: itemBuilder,
        gestureItemBuilder: gestureItemBuilder,
        bottomGestureBuilder: bottomGestureBuilder,
        indicatorDuration: indicatorDuration,
        indicatorPadding: indicatorPadding,
        reactStory: reactStory,
        pageController: pageController,
        viewFull: viewFull,
      ),
    );
  }

  @override
  _StoryPageFrameState createState() => _StoryPageFrameState();
}

class _StoryPageFrameState extends State<_StoryPageFrame>
    with
        AutomaticKeepAliveClientMixin<_StoryPageFrame>,
        SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool selected = true;
  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    // story index changed
    storyIndexListener();
    // page changed with horizontal swiping
    widget.pageController.addListener(pageIndexListener);
    super.didChangeDependencies();
  }

  void storyIndexListener() {
    // setState(() {
    //   selected = false;
    // });
  }

  void pageIndexListener() {
    if (widget.reactStory != null) {
      widget.reactStory!(
          widget.pageIndex, context.read<StoryStackController>().value);
    }
    // setState(() {
    //   selected = false;
    // });
  }

  @override
  void dispose() {
    widget.pageController.removeListener(pageIndexListener);
    super.dispose();
  }

  @override
  void initState() {
    if (context.read<StoryStackController>().onChangeStory != null) {
      context.read<StoryStackController>().onChangeStory!(widget.pageIndex, 0);
    }
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: widget.indicatorDuration,
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            if (widget.reactStory != null) {
              widget.reactStory!(
                  widget.pageIndex, context.read<StoryStackController>().value);
            }
            context.read<StoryStackController>().increment(
                restartAnimation: () => animationController.forward(from: 0));
          }
        },
      );
  }

  void pauseAnimation() {
    animationController.stop();
  }

  void resumeAnimation() {
    animationController.forward();
  }

  void onTapLike() {
    Future.delayed(
        const Duration(milliseconds: 700),
        () => setState(() {
              selected = true;
            }));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.topLeft,
        children: [
          // Positioned.fill(
          //   child: ColoredBox(
          //     color: Theme.of(context).scaffoldBackgroundColor,
          //   ),
          // ),
          Gestures(
            animationController: animationController,
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          Indicators(
            storyLength: widget.storyLength,
            animationController: animationController,
            isCurrentPage: widget.isCurrentPage,
            isPaging: widget.isPaging,
            padding: widget.indicatorPadding,
          ),

          Positioned.fill(
            child: widget.gestureItemBuilder?.call(
                  context,
                  widget.pageIndex,
                  context.watch<StoryStackController>().value,
                ) ??
                const SizedBox.shrink(),
          ),

          AnimatedPositioned(
              // top: Get.height - (widget.viewFull! ? 208 : 148),
              bottom: widget.viewFull! ? 78 : 20,
              width: Get.width,
              duration: const Duration(milliseconds: 150),
              child: widget.bottomGestureBuilder?.call(
                    context,
                    widget.pageIndex,
                    context.watch<StoryStackController>().value,
                    animationController,
                    onTapLike,
                  ) ??
                  const SizedBox.shrink()),

          Positioned.fill(
            child: OverlayBubble(
              onTap: () {
                print('Not working');
              },
              child: IgnorePointer(
                child: widget.itemBuilder(
                  context,
                  widget.pageIndex,
                  context.watch<StoryStackController>().value,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

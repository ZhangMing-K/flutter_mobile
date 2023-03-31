import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iris_common/iris_common.dart';

/// Returns a story page with Custom UI wrapper.
/// for descriptions on these properties, please see documentation on `StoryPageView`
class CustomStoryPage extends StatefulWidget {
  const CustomStoryPage({
    Key? key,
    required this.onStoryChange,
    required this.initialStoryIndex,
    this.initialPage = 0,
    required this.itemBuilder,
    required this.gestureItemBuilder,
    required this.bottomGestureBuilder,
    required this.storyLength,
    required this.pageLength,
    this.reactStory,
  }) : super(key: key);

  final void Function(int pageIndex, int storyIndex) onStoryChange;
  final int Function(int pageIndex) initialStoryIndex;
  final int initialPage;
  final Widget Function(
    BuildContext context,
    int pageIndex,
    int storyIndex,
  ) itemBuilder;
  final Widget Function(
    BuildContext context,
    int pageIndex,
    int storyIndex,
  ) gestureItemBuilder;
  final Widget Function(
    BuildContext context,
    int pageIndex,
    int storyIndex,
    AnimationController animationController,
    Function onTapLike,
  ) bottomGestureBuilder;
  final int Function(int pageIndex) storyLength;
  final int pageLength;
  final void Function(int pageIndex, int storyIndex)? reactStory;

  @override
  State<CustomStoryPage> createState() => _CustomStoryPageState();
}

class _CustomStoryPageState extends State<CustomStoryPage> {
  late bool isLightMode;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
  }

  /// Since the stories page is forced dark,
  /// we want to remember to set the status ui back to dark text when this page is disposed
  @override
  void dispose() {
    if (isLightMode) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isLightMode = Theme.of(context).brightness == Brightness.light;
    return Theme(
      data: IrisTheme.darkful(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: StoryPageView(
                  onChangedStory: widget.onStoryChange,
                  indicatorDuration: const Duration(seconds: 5),
                  onPageLimitReached: () {
                    Navigator.pop(context);
                  },
                  initialStoryIndex: widget.initialStoryIndex,
                  initialPage: widget.initialPage,
                  backgroundColor: Colors.black,
                  itemBuilder: widget.itemBuilder,
                  storyLength: widget.storyLength,
                  viewFull: false,
                  pageLength: widget.pageLength,
                  gestureItemBuilder: widget.gestureItemBuilder,
                  bottomGestureBuilder: widget.bottomGestureBuilder,
                  reactStory: widget.reactStory,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../themes/colors.dart';
import 'iris_widget_loader.dart';

class IrisAnimatedListView extends StatefulWidget {
  const IrisAnimatedListView({
    Key? key,
    required this.builder,
    this.itemCount,
    this.loadMore,
    this.widgetLoader,
    this.onRefresh,
    this.header,
    //  this.findChildIndexCallback,
    //  this.scrollController,
  }) : super(key: key);
  final IndexedWidgetBuilder builder;
  final int? itemCount;
  final Future Function()? loadMore;
  final Widget? widgetLoader;
  final Widget? header;
  final Future<void> Function()? onRefresh;
  //final int Function(Key) findChildIndexCallback;
  @override
  IrisAnimatedListViewState createState() => IrisAnimatedListViewState();
}

class IrisAnimatedListViewState extends State<IrisAnimatedListView> {
  void scrollToTop() {
    final scrollController = PrimaryScrollController.of(context)!;
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  int getItemCount() {
    if (widget.itemCount == 0) return 0;
    if (widget.header == null) {
      return widget.itemCount! + 1;
    }
    return widget.itemCount! + 2;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // key: key,
      color: IrisColor.primaryColor,

      // key: GlobalKey<RefreshIndicatorState>(),
      onRefresh: () {
        return widget.onRefresh?.call() ?? () async {} as Future<void>;
      },
      child: ListView.builder(
        itemCount: getItemCount(),
        addAutomaticKeepAlives: false,
        itemBuilder: (BuildContext context, int index) {
          debugPrint('${widget.itemCount} $index');
          if (widget.itemCount! > index) {
            if (widget.header != null && index == 0) {
              return widget.header!;
            }
            return widget.builder(context, index);
          }
          return WidgetLoader(
            placeholder: widget.widgetLoader,
            loadMore: widget.loadMore,
          );
        },
      ),
      // child: CustomScrollView(
      //   slivers: <Widget>[
      //     SliverToBoxAdapter(
      //       child: widget.header ?? Container(),
      //     ),
      //     SliverList(
      //       delegate: SliverChildBuilderDelegate(
      //         (BuildContext context, int index) {
      //           if (widget.itemCount > index) {
      //             return widget.builder(context, index);
      //           }
      //           return WidgetLoader(
      //             placeholder: widget.widgetLoader,
      //             loadMore: widget.loadMore,
      //           );
      //         },
      //         // findChildIndexCallback: widget.findChildIndexCallback,
      //         childCount: (widget.itemCount == 0) ? 0 : widget.itemCount + 1,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

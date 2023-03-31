import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loader_widget.dart';

//TODO: Refactor
class ScrollListView extends StatelessWidget {
  ScrollListView(
      {Key? key,
      required this.children,
      this.onEvent,
      this.onBottom,
      ScrollController? scrollController,
      this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
      this.doNotCreateScrollController = false})
      : _scrollController =
            scrollController == null && !doNotCreateScrollController
                ? ScrollController()
                : scrollController,
        super(key: key);

  final ScrollController? _scrollController;
  final List<Widget> children;
  final Function(ScrollPosition)? onEvent;
  final Function? onBottom;
  final bool doNotCreateScrollController; //this is for the AppMenuV3
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  @override
  build(BuildContext context) {
    return GetX(
      global: false,
      init: ScrollListController(
        onBottom: onBottom,
        onEvent: onEvent,
        scrollController: _scrollController,
      ),
      builder: (dynamic ctl) => Column(
        children: [
          Expanded(
            child: ListView.builder(
              addAutomaticKeepAlives: false,
              // Note: this allows the bottomsheet to be dragged when it has a ListView inside it. Don't change that.
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              keyboardDismissBehavior: keyboardDismissBehavior,
              itemCount: children.length,
              itemBuilder: (context, index) {
                return children[index];
              },
            ),
          ),
          if (ctl.isloading$.value) ...[
            const SizedBox(
              height: 10,
            ),
            const Loader()
          ]
        ],
      ),
    );
  }
}

class ScrollListController extends GetxController {
  ScrollListController(
      {required this.scrollController,
      required this.onEvent,
      required this.onBottom});

  final ScrollController? scrollController;
  final Function(ScrollPosition)? onEvent;
  final Function? onBottom;
  final RxBool isloading$ = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    scrollController?.addListener(_listener);
  }

  ScrollPhysics physics() {
    // if (!GetPlatform.isAndroid) {
    //   return IrisScrollPhysics();
    // } else {
    return const BouncingScrollPhysics();
    // }
  }

  Future<void> _listener() async {
    final ScrollPosition position = scrollController!.position;
    if (onEvent != null) {
      onEvent!(position);
    }
    if (position.pixels > position.maxScrollExtent - 100) {
      if (onBottom != null && !isloading$.value) {
        isloading$.value = true;
        await onBottom!();
        isloading$.value = false;
      }
    }
  }

  @override
  void onClose() {
    scrollController?.addListener(_listener);
    super.onClose();
  }
}

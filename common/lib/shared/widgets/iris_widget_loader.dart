import 'dart:async';

import 'package:flutter/cupertino.dart';

class WidgetLoader extends StatefulWidget {
  const WidgetLoader({
    Key? key,
    required this.loadMore,
    this.placeholder,
  }) : super(key: key);
  final Future<void> Function()? loadMore;
  final Widget? placeholder;

  @override
  _WidgetLoaderState createState() => _WidgetLoaderState();
}

class _WidgetLoaderState extends State<WidgetLoader> {
  bool _isVisible = true;
  @override
  void initState() {
    performLoad();
    super.initState();
  }

  Future<void> performLoad() async {
    await widget.loadMore?.call();
    if (mounted) {
      setState(() {
        _isVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: _isVisible,
        child: widget.placeholder ??
            const CupertinoActivityIndicator(
              radius: 10,
            )
        // const SizedBox(
        //   // height: 40,
        //   // width: 40,
        //   child: Center(
        //       child: CupertinoActivityIndicator(
        //     radius: 10,
        //   )),
        // ),
        );
  }
}

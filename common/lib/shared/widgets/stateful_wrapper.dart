import 'dart:async';

import 'package:flutter/material.dart';

class StatefulWrapper extends StatefulWidget {
  final Function? onInit;
  final Function? afterLoad;
  final Function? onDispose;
  final Widget child;
  final Duration? seenDuration;
  final Function? onSeen;

  const StatefulWrapper({
    Key? key,
    this.onInit,
    required this.child,
    this.afterLoad,
    this.onDispose,
    this.seenDuration,
    this.onSeen,
  }) : super(key: key);
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  late Timer timer;
  @override
  void initState() {
    // debugPrint('init state');
    // if (widget.onInit != null) {
    //   widget.onInit();
    // }

    super.initState();
    if (widget.onInit != null) {
      widget.onInit!();
    }
    if (widget.onSeen != null) {
      timer = Timer(widget.seenDuration!, () {
        widget.onSeen!();
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.afterLoad != null) {
        widget.afterLoad!();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onSeen != null) {
      timer.cancel();
    }
    if (widget.onDispose != null) {
      widget.onDispose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

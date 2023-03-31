import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'slide_up_controller.dart';

class SlideUpWidget extends StatefulWidget {
  const SlideUpWidget({Key? key, required this.controller, required this.child})
      : super(key: key);

  final SlideUpController controller;
  final Widget child;

  @override
  _SlideUpWidgetState createState() => _SlideUpWidgetState();
}

class _SlideUpWidgetState extends State<SlideUpWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SlideUpProvider(),
      child: Consumer<SlideUpProvider>(
        builder: (context, provider, child) {
          widget.controller.providerContext = context;
          return provider.isShow ? widget.child : Container();
        },
      ),
    );
  }
}

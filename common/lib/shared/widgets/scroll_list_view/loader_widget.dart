import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

//TODO: Search to others loaders and made it a shared widget

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitPulse(
      color: context.theme.primaryColor,
      size: 50.0,
    );
  }
}

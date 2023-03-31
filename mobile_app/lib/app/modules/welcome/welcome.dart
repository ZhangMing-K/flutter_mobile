import 'package:flutter/material.dart';

import 'views/welcome_mobile.dart';

export 'bindings/welcome_binding.dart';
export 'controllers/welcome_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const WelcomeMobileScreen();
  }
}

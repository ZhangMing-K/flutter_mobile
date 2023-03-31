import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

import 'deactivate_mobile.dart';

class DeactivateScreen extends StatelessWidget {
  const DeactivateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BasicAppBar(
        title: 'Deactivate your account',
      ),
      body: DeactivateMobile(),
    );
  }

  static String routeName() {
    return '/deactivate';
  }
}

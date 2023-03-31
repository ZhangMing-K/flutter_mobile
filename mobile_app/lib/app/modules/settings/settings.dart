import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

import 'settings_mobile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BasicAppBar(
        title: 'Settings and Privacy',
      ),
      body: SettingsMobile(),
    );
  }

  static String routeName({int? assetKey}) {
    return '/settings';
  }
}

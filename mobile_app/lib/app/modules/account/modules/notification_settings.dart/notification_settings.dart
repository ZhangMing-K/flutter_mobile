import 'package:flutter/material.dart';

import 'views/notification_settings_mobile.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: const NotificationSettingsMobile(),
    );
  }
}

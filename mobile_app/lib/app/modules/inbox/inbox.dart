import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/inbox_controller.dart';
import 'views/inbox_view_mobile.dart';
import 'views/inbox_view_web.dart';

class InboxScreen extends GetView<InboxController> {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? const InboxScreenWeb() : const InboxScreenMobile();
  }
}

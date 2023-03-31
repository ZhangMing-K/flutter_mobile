import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermission {
  static Future<bool> currentNotificationStatus() async {
    final permission = await Permission.notification.request();
    if (permission.isGranted) {
      return true;
    }
    return false;
  }

  static getNotificationPermission({bool isDirect = false}) async {
    final permission = await currentNotificationStatus();
    if (permission) {
      return true;
    } else {
      if (!isDirect) {
        await Get.dialog(
          IrisDialog(
            title: 'Permission Required',
            subtitle:
                'You have denied access to notifications, you can go to settings and grant permission again.',
            onCancel: () => Get.back(),
            confirmButtonText: 'Settings',
            onConfirm: () {
              openAppSettings();
              Get.back();
            },
          ),
          barrierDismissible: true,
        );
      } else {
        openAppSettings();
      }
      return false;
    }
  }
}

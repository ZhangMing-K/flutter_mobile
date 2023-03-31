import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';

import '../../../data/services/auth_user/auth_user_service.dart';
import '../../../data/services/iris_event/iris_event.dart';
import 'error_report_data.dart';

class IrisErrorReport {
  final IrisEvent irisEvent;

  IrisErrorReport({required this.irisEvent});

  void send(error) {
    if (error is FlutterErrorDetails) {
      final dataError = ErrorReportData(
          userKey: _getUserKey(),
          type: 'FlutterErrorDetails',
          error: error.exceptionAsString());
      debugPrint('Report error to server: $dataError');
      if (kDebugMode) {
        return;
      }
      irisEvent.reportError(errorMessage: dataError.toJson());
    } else {
      final dataError = ErrorReportData(
          userKey: _getUserKey(),
          type: error.runtimeType.toString(),
          error: error.toString());
      debugPrint('Report error to server: $dataError');
      if (kDebugMode) {
        return;
      }
      irisEvent.reportError(errorMessage: dataError.toJson());
    }
  }

  int? _getUserKey() {
    final hasUserLogged = Get.isRegistered<IAuthUserService>();
    if (hasUserLogged) {
      return Get.find<IAuthUserService>().loggedUser?.userKey;
    }
    return null;
  }
}

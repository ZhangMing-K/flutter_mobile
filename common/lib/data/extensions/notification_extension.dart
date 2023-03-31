import 'package:iris_common/iris_common.dart';
import 'package:simple_moment/simple_moment.dart';

extension NotificationExt on NotificationModel {
  String get dateFrom {
    final moment = Moment.now();
    if (eventHappenedAt != null) {
      return moment.from(eventHappenedAt!);
    }
    if (lastActionAt == null) {
      return 'Unknown';
    }
    return moment.from(lastActionAt!);
  }
}

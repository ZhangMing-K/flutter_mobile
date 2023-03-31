import 'package:iris_common/iris_common.dart';
import 'package:simple_moment/simple_moment.dart';

extension SnapshotExt on Snapshot {
  String get lastUpdatedFrom {
    if (lastUpdatedAt == null) {
      return 'Unknown';
    }
    final moment = Moment.now();
    return moment.from(lastUpdatedAt!);
  }
}

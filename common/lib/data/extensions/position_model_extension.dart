import 'package:iris_common/iris_common.dart';

extension PositionModelExt on PositionModel {
  double? get returnPercentageDisplay {
    if (averageBuyPrice == null) {
      return null;
    }
    if (averageBuyPrice! >= 0) {
      return returnPercentage;
    } else {
      return (-averageBuyPrice! - currentPrice!) / -averageBuyPrice!;
    }
  }

  double? get todayReturnPercentageDisplay {
    if (averageBuyPrice == null) {
      return 0;
    }
    if (averageBuyPrice! >= 0) {
      return todayReturnPercentage;
    } else {
      return todayReturnPercentage! * -1;
    }
  }
}

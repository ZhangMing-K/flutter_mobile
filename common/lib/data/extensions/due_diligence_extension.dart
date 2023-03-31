import 'package:iris_common/iris_common.dart';

extension DueDiligenceExt on DueDiligence {
  bool get canEdit {
    final createdAt = this.createdAt;
    if (createdAt == null) return false;
    final now = DateTime.now();
    final expirationDate = createdAt.add(const Duration(minutes: 30));
    final bool isExpired = expirationDate.isBefore(now);
    return !isExpired;
  }

  String get getTimeFrame {
    if (term == TERM.SHORT_TERM) {
      return 'within 1 month';
    } else if (term == TERM.MEDIUM_TERM) {
      return 'within 1 year';
    } else if (term == TERM.LONG_TERM) {
      return 'in over a year';
    }
    return '';
  }

  String getRiskName() {
    return riskType[riskRating! - 1];
  }
}

const riskType = <String>[
  'Very low',
  'Low',
  'Moderate',
  'High',
  'Very high',
];

extension TermExt on TERM? {
  String stringfy() {
    switch (this) {
      case TERM.SHORT_TERM:
        return 'Short';
      case TERM.MEDIUM_TERM:
        return 'Medium';
      case TERM.LONG_TERM:
        return 'Long';
      case null:
        return '';
    }
  }

  String get getTimeFrame {
    switch (this) {
      case TERM.SHORT_TERM:
        return '1day - 1mo';
      case TERM.MEDIUM_TERM:
        return '1mo - 1y';
      case TERM.LONG_TERM:
        return '+1 year';
      case null:
        return '';
    }
  }
}

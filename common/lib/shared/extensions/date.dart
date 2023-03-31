import 'package:intl/intl.dart';

extension FormatExtension on DateTime? {
  String formatYmd() {
    if (this == null) {
      return '';
    }
    return DateFormat('MMMM d, y').format(this!);
  }

  String formatMonthDayYear() {
    if (this == null) {
      return '';
    }
    return DateFormat('M/d/yy').format(this!);
  }

  String formatTimeStandard() {
    if (this == null) {
      return '';
    }
    return DateFormat('h:mm a').format(this!);
  }

  String formatTimeStandardToLocal() {
    if (this == null) {
      return '';
    }
    return DateFormat('h:mm a').format(this!.toLocal());
  }

  String formatTimeAndDate() {
    if (this == null) {
      return '';
    }
    return DateFormat('h:mm a, MMMM d').format(this!);
  }
}

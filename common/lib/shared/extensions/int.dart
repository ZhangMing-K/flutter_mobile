import 'package:intl/intl.dart';

extension IntExtension on int? {
  String compactNumber() {
    if (this == null) {
      return '';
    }
    return this! < 9999
        ? NumberFormat().format(this)
        : NumberFormat.compact().format(this);
  }
}

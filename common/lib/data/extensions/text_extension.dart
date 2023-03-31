import 'package:intl/intl.dart';
import 'package:simple_moment/simple_moment.dart';

import '../../iris_common.dart';

extension TextExt on TextModel {
  String get dateCompact {
    if (orderedCreatedAt == null) {
      return 'Unknown';
    }
    final DateTime date = orderedCreatedAt!.toLocal();
    final DateTime now = DateTime.now();

    final int days = DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
    if (days >= 0) {
      return Moment.fromDate(date).format('h:mm a');
    } else if (days == -1) {
      return 'Yesterday';
    } else if (days < -1 && days >= -7) {
      return Moment.fromDate(date).format('EEEE');
    }
    return Moment.fromDate(date).format('M/d/yy');
  }

  String get dateFrom {
    if (orderedCreatedAt == null) {
      return 'Unknown';
    }
    final moment = Moment.now();
    return moment.from(orderedCreatedAt!);
  }

  String get dateFromAbb {
    if (orderedCreatedAt == null) {
      return 'Unknown';
    }
    String timeString = '';
    final textDate = Moment.fromDate(orderedCreatedAt!);
    final moment = Moment.now();

    final locale = moment.usedLocale;
    final Duration diff = orderedCreatedAt!.difference(moment.date);
    String longDateFormat = 'M-dd';
    if (textDate.year != moment.year) {
      longDateFormat = 'M-dd-yy';
    }
    if (diff.inSeconds.abs() < 45) {
      timeString = locale.seconds.replaceFirst('%i', '${diff.inSeconds.abs()}');
    } else if (diff.inMinutes.abs() < 2) {
      timeString = '1 min';
    } else if (diff.inMinutes.abs() < 45) {
      timeString = locale.minutes
          .replaceFirst('%i minutes', '${diff.inMinutes.abs()} mins');
    } else if (diff.inHours.abs() < 2) {
      timeString = '1 hr';
    } else if (diff.inHours.abs() < 22) {
      timeString =
          locale.hours.replaceFirst('%i hours', '${diff.inHours.abs()} hrs');
    } else if (diff.inDays.abs() < 2) {
      timeString = locale.aDay.replaceFirst('%i', '${diff.inDays.abs()}');
    } else {
      timeString = DateFormat(longDateFormat).format(orderedCreatedAt!);
    }

    return timeString;
  }

  String get dateAndTime {
    if (orderedCreatedAt == null) {
      return '';
    } else {
      return DateFormat('MM/dd/yy h:mm a').format(orderedCreatedAt!);
    }
  }

  String get dateAndTimeLocal {
    if (orderedCreatedAt == null) {
      return '';
    } else {
      return DateFormat('MM/dd/yy h:mm a').format(orderedCreatedAt!.toLocal());
    }
  }

  String? get displayValue {
    String? display = 'Not working';
    if (order != null) {
      return order?.readableAction;
    } else if (value != null) {
      display = value;
    } else if (article?.summary != null) {
      display = article?.summary;
    }
    return display;
  }
}

import 'package:iris_common/data/models/enums/notification_action_name.dart';
import 'package:collection/collection.dart';

class NotificationAction {
  final int? notificationActionKey;
  final NOTIFICATION_ACTION_NAME? actionName;
  const NotificationAction({this.notificationActionKey, this.actionName});
  NotificationAction copyWith(
      {int? notificationActionKey, NOTIFICATION_ACTION_NAME? actionName}) {
    return NotificationAction(
      notificationActionKey:
          notificationActionKey ?? this.notificationActionKey,
      actionName: actionName ?? this.actionName,
    );
  }

  factory NotificationAction.fromJson(Map<String, dynamic> json) {
    return NotificationAction(
      notificationActionKey: json['notificationActionKey'],
      actionName: json['actionName'] != null
          ? NOTIFICATION_ACTION_NAME.values.byName(json['actionName'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['notificationActionKey'] = notificationActionKey;
    data['actionName'] = actionName?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NotificationAction &&
            (identical(other.notificationActionKey, notificationActionKey) ||
                const DeepCollectionEquality().equals(
                    other.notificationActionKey, notificationActionKey)) &&
            (identical(other.actionName, actionName) ||
                const DeepCollectionEquality()
                    .equals(other.actionName, actionName)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(notificationActionKey) ^
        const DeepCollectionEquality().hash(actionName);
  }

  @override
  String toString() => 'NotificationAction(${toJson()})';
}

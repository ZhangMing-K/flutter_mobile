import 'package:iris_common/data/models/output/notification_model.dart';
import 'package:collection/collection.dart';

class UserNotificationConnection {
  final List<NotificationModel>? notifications;
  final String? nextCursor;
  const UserNotificationConnection({this.notifications, this.nextCursor});
  UserNotificationConnection copyWith(
      {List<NotificationModel>? notifications, String? nextCursor}) {
    return UserNotificationConnection(
      notifications: notifications ?? this.notifications,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  factory UserNotificationConnection.fromJson(Map<String, dynamic> json) {
    return UserNotificationConnection(
      notifications: json['notifications']
          ?.map<NotificationModel>((o) => NotificationModel.fromJson(o))
          .toList(),
      nextCursor: json['nextCursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['notifications'] =
        notifications?.map((item) => item.toJson()).toList();
    data['nextCursor'] = nextCursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserNotificationConnection &&
            (identical(other.notifications, notifications) ||
                const DeepCollectionEquality()
                    .equals(other.notifications, notifications)) &&
            (identical(other.nextCursor, nextCursor) ||
                const DeepCollectionEquality()
                    .equals(other.nextCursor, nextCursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(notifications) ^
        const DeepCollectionEquality().hash(nextCursor);
  }

  @override
  String toString() => 'UserNotificationConnection(${toJson()})';
}

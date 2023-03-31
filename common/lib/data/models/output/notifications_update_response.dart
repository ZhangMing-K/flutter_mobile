import 'package:iris_common/data/models/output/notification_model.dart';
import 'package:collection/collection.dart';

class NotificationsUpdateResponse {
  final List<NotificationModel>? notifications;
  const NotificationsUpdateResponse({this.notifications});
  NotificationsUpdateResponse copyWith(
      {List<NotificationModel>? notifications}) {
    return NotificationsUpdateResponse(
      notifications: notifications ?? this.notifications,
    );
  }

  factory NotificationsUpdateResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsUpdateResponse(
      notifications: json['notifications']
          ?.map<NotificationModel>((o) => NotificationModel.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['notifications'] =
        notifications?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NotificationsUpdateResponse &&
            (identical(other.notifications, notifications) ||
                const DeepCollectionEquality()
                    .equals(other.notifications, notifications)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(notifications);
  }

  @override
  String toString() => 'NotificationsUpdateResponse(${toJson()})';
}

import 'package:collection/collection.dart';

class NotificationsUpdateInput {
  final List<int>? notificationKeys;
  final bool? seen;
  final bool? ignored;
  const NotificationsUpdateInput(
      {required this.notificationKeys, this.seen, this.ignored});
  NotificationsUpdateInput copyWith(
      {List<int>? notificationKeys, bool? seen, bool? ignored}) {
    return NotificationsUpdateInput(
      notificationKeys: notificationKeys ?? this.notificationKeys,
      seen: seen ?? this.seen,
      ignored: ignored ?? this.ignored,
    );
  }

  factory NotificationsUpdateInput.fromJson(Map<String, dynamic> json) {
    return NotificationsUpdateInput(
      notificationKeys:
          json['notificationKeys']?.map<int>((o) => (o as int)).toList(),
      seen: json['seen'],
      ignored: json['ignored'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['notificationKeys'] = notificationKeys;
    data['seen'] = seen;
    data['ignored'] = ignored;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NotificationsUpdateInput &&
            (identical(other.notificationKeys, notificationKeys) ||
                const DeepCollectionEquality()
                    .equals(other.notificationKeys, notificationKeys)) &&
            (identical(other.seen, seen) ||
                const DeepCollectionEquality().equals(other.seen, seen)) &&
            (identical(other.ignored, ignored) ||
                const DeepCollectionEquality().equals(other.ignored, ignored)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(notificationKeys) ^
        const DeepCollectionEquality().hash(seen) ^
        const DeepCollectionEquality().hash(ignored);
  }

  @override
  String toString() => 'NotificationsUpdateInput(${toJson()})';
}

import 'package:collection/collection.dart';

class UserNotificationsInput {
  final bool? seen;
  final bool? ignored;
  final bool? device;
  final int? limit;
  final int? offset;
  final String? cursor;
  const UserNotificationsInput(
      {this.seen,
      this.ignored,
      this.device,
      this.limit,
      this.offset,
      this.cursor});
  UserNotificationsInput copyWith(
      {bool? seen,
      bool? ignored,
      bool? device,
      int? limit,
      int? offset,
      String? cursor}) {
    return UserNotificationsInput(
      seen: seen ?? this.seen,
      ignored: ignored ?? this.ignored,
      device: device ?? this.device,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      cursor: cursor ?? this.cursor,
    );
  }

  factory UserNotificationsInput.fromJson(Map<String, dynamic> json) {
    return UserNotificationsInput(
      seen: json['seen'],
      ignored: json['ignored'],
      device: json['device'],
      limit: json['limit'],
      offset: json['offset'],
      cursor: json['cursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['seen'] = seen;
    data['ignored'] = ignored;
    data['device'] = device;
    data['limit'] = limit;
    data['offset'] = offset;
    data['cursor'] = cursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserNotificationsInput &&
            (identical(other.seen, seen) ||
                const DeepCollectionEquality().equals(other.seen, seen)) &&
            (identical(other.ignored, ignored) ||
                const DeepCollectionEquality()
                    .equals(other.ignored, ignored)) &&
            (identical(other.device, device) ||
                const DeepCollectionEquality().equals(other.device, device)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(seen) ^
        const DeepCollectionEquality().hash(ignored) ^
        const DeepCollectionEquality().hash(device) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(cursor);
  }

  @override
  String toString() => 'UserNotificationsInput(${toJson()})';
}

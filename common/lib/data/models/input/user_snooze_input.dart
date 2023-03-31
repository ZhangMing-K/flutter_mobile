import 'package:iris_common/data/models/enums/user_snooze_type.dart';
import 'package:collection/collection.dart';

class UserSnoozeInput {
  final USER_SNOOZE_TYPE? snoozeType;
  final int? fromTextKey;
  final int? fromUserKey;
  final DateTime? snoozeUntil;
  const UserSnoozeInput(
      {required this.snoozeType,
      this.fromTextKey,
      this.fromUserKey,
      this.snoozeUntil});
  UserSnoozeInput copyWith(
      {USER_SNOOZE_TYPE? snoozeType,
      int? fromTextKey,
      int? fromUserKey,
      DateTime? snoozeUntil}) {
    return UserSnoozeInput(
      snoozeType: snoozeType ?? this.snoozeType,
      fromTextKey: fromTextKey ?? this.fromTextKey,
      fromUserKey: fromUserKey ?? this.fromUserKey,
      snoozeUntil: snoozeUntil ?? this.snoozeUntil,
    );
  }

  factory UserSnoozeInput.fromJson(Map<String, dynamic> json) {
    return UserSnoozeInput(
      snoozeType: json['snoozeType'] != null
          ? USER_SNOOZE_TYPE.values.byName(json['snoozeType'])
          : null,
      fromTextKey: json['fromTextKey'],
      fromUserKey: json['fromUserKey'],
      snoozeUntil: json['snoozeUntil'] != null
          ? DateTime.parse(json['snoozeUntil'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['snoozeType'] = snoozeType?.name;
    data['fromTextKey'] = fromTextKey;
    data['fromUserKey'] = fromUserKey;
    data['snoozeUntil'] = snoozeUntil?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserSnoozeInput &&
            (identical(other.snoozeType, snoozeType) ||
                const DeepCollectionEquality()
                    .equals(other.snoozeType, snoozeType)) &&
            (identical(other.fromTextKey, fromTextKey) ||
                const DeepCollectionEquality()
                    .equals(other.fromTextKey, fromTextKey)) &&
            (identical(other.fromUserKey, fromUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.fromUserKey, fromUserKey)) &&
            (identical(other.snoozeUntil, snoozeUntil) ||
                const DeepCollectionEquality()
                    .equals(other.snoozeUntil, snoozeUntil)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(snoozeType) ^
        const DeepCollectionEquality().hash(fromTextKey) ^
        const DeepCollectionEquality().hash(fromUserKey) ^
        const DeepCollectionEquality().hash(snoozeUntil);
  }

  @override
  String toString() => 'UserSnoozeInput(${toJson()})';
}

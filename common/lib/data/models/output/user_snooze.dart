import 'package:iris_common/data/models/enums/user_snooze_type.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class UserSnooze {
  final int? userSnoozeKey;
  final DateTime? snoozeUntil;
  final USER_SNOOZE_TYPE? snoozeType;
  final int? fromTextKey;
  final int? fromUserKey;
  final User? fromUser;
  final TextModel? fromText;
  final DateTime? createdAt;
  const UserSnooze(
      {this.userSnoozeKey,
      this.snoozeUntil,
      this.snoozeType,
      this.fromTextKey,
      this.fromUserKey,
      this.fromUser,
      this.fromText,
      this.createdAt});
  UserSnooze copyWith(
      {int? userSnoozeKey,
      DateTime? snoozeUntil,
      USER_SNOOZE_TYPE? snoozeType,
      int? fromTextKey,
      int? fromUserKey,
      User? fromUser,
      TextModel? fromText,
      DateTime? createdAt}) {
    return UserSnooze(
      userSnoozeKey: userSnoozeKey ?? this.userSnoozeKey,
      snoozeUntil: snoozeUntil ?? this.snoozeUntil,
      snoozeType: snoozeType ?? this.snoozeType,
      fromTextKey: fromTextKey ?? this.fromTextKey,
      fromUserKey: fromUserKey ?? this.fromUserKey,
      fromUser: fromUser ?? this.fromUser,
      fromText: fromText ?? this.fromText,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UserSnooze.fromJson(Map<String, dynamic> json) {
    return UserSnooze(
      userSnoozeKey: json['userSnoozeKey'],
      snoozeUntil: json['snoozeUntil'] != null
          ? DateTime.parse(json['snoozeUntil'])
          : null,
      snoozeType: json['snoozeType'] != null
          ? USER_SNOOZE_TYPE.values.byName(json['snoozeType'])
          : null,
      fromTextKey: json['fromTextKey'],
      fromUserKey: json['fromUserKey'],
      fromUser:
          json['fromUser'] != null ? User.fromJson(json['fromUser']) : null,
      fromText: json['fromText'] != null
          ? TextModel.fromJson(json['fromText'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userSnoozeKey'] = userSnoozeKey;
    data['snoozeUntil'] = snoozeUntil?.toString();
    data['snoozeType'] = snoozeType?.name;
    data['fromTextKey'] = fromTextKey;
    data['fromUserKey'] = fromUserKey;
    data['fromUser'] = fromUser?.toJson();
    data['fromText'] = fromText?.toJson();
    data['createdAt'] = createdAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserSnooze &&
            (identical(other.userSnoozeKey, userSnoozeKey) ||
                const DeepCollectionEquality()
                    .equals(other.userSnoozeKey, userSnoozeKey)) &&
            (identical(other.snoozeUntil, snoozeUntil) ||
                const DeepCollectionEquality()
                    .equals(other.snoozeUntil, snoozeUntil)) &&
            (identical(other.snoozeType, snoozeType) ||
                const DeepCollectionEquality()
                    .equals(other.snoozeType, snoozeType)) &&
            (identical(other.fromTextKey, fromTextKey) ||
                const DeepCollectionEquality()
                    .equals(other.fromTextKey, fromTextKey)) &&
            (identical(other.fromUserKey, fromUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.fromUserKey, fromUserKey)) &&
            (identical(other.fromUser, fromUser) ||
                const DeepCollectionEquality()
                    .equals(other.fromUser, fromUser)) &&
            (identical(other.fromText, fromText) ||
                const DeepCollectionEquality()
                    .equals(other.fromText, fromText)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userSnoozeKey) ^
        const DeepCollectionEquality().hash(snoozeUntil) ^
        const DeepCollectionEquality().hash(snoozeType) ^
        const DeepCollectionEquality().hash(fromTextKey) ^
        const DeepCollectionEquality().hash(fromUserKey) ^
        const DeepCollectionEquality().hash(fromUser) ^
        const DeepCollectionEquality().hash(fromText) ^
        const DeepCollectionEquality().hash(createdAt);
  }

  @override
  String toString() => 'UserSnooze(${toJson()})';
}

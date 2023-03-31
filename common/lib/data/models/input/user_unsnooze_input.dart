import 'package:iris_common/data/models/enums/user_snooze_type.dart';
import 'package:collection/collection.dart';

class UserUnsnoozeInput {
  final USER_SNOOZE_TYPE? snoozeType;
  const UserUnsnoozeInput({required this.snoozeType});
  UserUnsnoozeInput copyWith({USER_SNOOZE_TYPE? snoozeType}) {
    return UserUnsnoozeInput(
      snoozeType: snoozeType ?? this.snoozeType,
    );
  }

  factory UserUnsnoozeInput.fromJson(Map<String, dynamic> json) {
    return UserUnsnoozeInput(
      snoozeType: json['snoozeType'] != null
          ? USER_SNOOZE_TYPE.values.byName(json['snoozeType'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['snoozeType'] = snoozeType?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserUnsnoozeInput &&
            (identical(other.snoozeType, snoozeType) ||
                const DeepCollectionEquality()
                    .equals(other.snoozeType, snoozeType)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(snoozeType);
  }

  @override
  String toString() => 'UserUnsnoozeInput(${toJson()})';
}

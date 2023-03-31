import 'package:iris_common/data/models/enums/user_access_type.dart';
import 'package:collection/collection.dart';

class JediUserEditInput {
  final int? userKey;
  final USER_ACCESS_TYPE? userAccessType;
  final bool? verify;
  final bool? isIrisProElligible;
  final bool? suspend;
  const JediUserEditInput(
      {required this.userKey,
      this.userAccessType,
      this.verify,
      this.isIrisProElligible,
      this.suspend});
  JediUserEditInput copyWith(
      {int? userKey,
      USER_ACCESS_TYPE? userAccessType,
      bool? verify,
      bool? isIrisProElligible,
      bool? suspend}) {
    return JediUserEditInput(
      userKey: userKey ?? this.userKey,
      userAccessType: userAccessType ?? this.userAccessType,
      verify: verify ?? this.verify,
      isIrisProElligible: isIrisProElligible ?? this.isIrisProElligible,
      suspend: suspend ?? this.suspend,
    );
  }

  factory JediUserEditInput.fromJson(Map<String, dynamic> json) {
    return JediUserEditInput(
      userKey: json['userKey'],
      userAccessType: json['userAccessType'] != null
          ? USER_ACCESS_TYPE.values.byName(json['userAccessType'])
          : null,
      verify: json['verify'],
      isIrisProElligible: json['isIrisProElligible'],
      suspend: json['suspend'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    data['userAccessType'] = userAccessType?.name;
    data['verify'] = verify;
    data['isIrisProElligible'] = isIrisProElligible;
    data['suspend'] = suspend;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediUserEditInput &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.userAccessType, userAccessType) ||
                const DeepCollectionEquality()
                    .equals(other.userAccessType, userAccessType)) &&
            (identical(other.verify, verify) ||
                const DeepCollectionEquality().equals(other.verify, verify)) &&
            (identical(other.isIrisProElligible, isIrisProElligible) ||
                const DeepCollectionEquality()
                    .equals(other.isIrisProElligible, isIrisProElligible)) &&
            (identical(other.suspend, suspend) ||
                const DeepCollectionEquality().equals(other.suspend, suspend)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(userAccessType) ^
        const DeepCollectionEquality().hash(verify) ^
        const DeepCollectionEquality().hash(isIrisProElligible) ^
        const DeepCollectionEquality().hash(suspend);
  }

  @override
  String toString() => 'JediUserEditInput(${toJson()})';
}

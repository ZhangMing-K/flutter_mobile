import 'package:iris_common/data/models/enums/waitlist_feature_type.dart';
import 'package:collection/collection.dart';

class WaitlistUserAddInput {
  final WAITLIST_FEATURE_TYPE? featureType;
  final int? userKey;
  const WaitlistUserAddInput(
      {required this.featureType, required this.userKey});
  WaitlistUserAddInput copyWith(
      {WAITLIST_FEATURE_TYPE? featureType, int? userKey}) {
    return WaitlistUserAddInput(
      featureType: featureType ?? this.featureType,
      userKey: userKey ?? this.userKey,
    );
  }

  factory WaitlistUserAddInput.fromJson(Map<String, dynamic> json) {
    return WaitlistUserAddInput(
      featureType: json['featureType'] != null
          ? WAITLIST_FEATURE_TYPE.values.byName(json['featureType'])
          : null,
      userKey: json['userKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['featureType'] = featureType?.name;
    data['userKey'] = userKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WaitlistUserAddInput &&
            (identical(other.featureType, featureType) ||
                const DeepCollectionEquality()
                    .equals(other.featureType, featureType)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality().equals(other.userKey, userKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(featureType) ^
        const DeepCollectionEquality().hash(userKey);
  }

  @override
  String toString() => 'WaitlistUserAddInput(${toJson()})';
}

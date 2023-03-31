import 'package:iris_common/data/models/enums/waitlist_feature_type.dart';
import 'package:collection/collection.dart';

class WaitlistGetInput {
  final WAITLIST_FEATURE_TYPE? featureType;
  final int? limit;
  final int? offset;
  const WaitlistGetInput(
      {required this.featureType, required this.limit, required this.offset});
  WaitlistGetInput copyWith(
      {WAITLIST_FEATURE_TYPE? featureType, int? limit, int? offset}) {
    return WaitlistGetInput(
      featureType: featureType ?? this.featureType,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory WaitlistGetInput.fromJson(Map<String, dynamic> json) {
    return WaitlistGetInput(
      featureType: json['featureType'] != null
          ? WAITLIST_FEATURE_TYPE.values.byName(json['featureType'])
          : null,
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['featureType'] = featureType?.name;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WaitlistGetInput &&
            (identical(other.featureType, featureType) ||
                const DeepCollectionEquality()
                    .equals(other.featureType, featureType)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(featureType) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'WaitlistGetInput(${toJson()})';
}

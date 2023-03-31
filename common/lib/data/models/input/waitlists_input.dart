import 'package:iris_common/data/models/enums/waitlist_feature_type.dart';
import 'package:collection/collection.dart';

class WaitlistsInput {
  final List<WAITLIST_FEATURE_TYPE>? featureTypes;
  const WaitlistsInput({this.featureTypes});
  WaitlistsInput copyWith({List<WAITLIST_FEATURE_TYPE>? featureTypes}) {
    return WaitlistsInput(
      featureTypes: featureTypes ?? this.featureTypes,
    );
  }

  factory WaitlistsInput.fromJson(Map<String, dynamic> json) {
    return WaitlistsInput(
      featureTypes: json['featureTypes']
          ?.map<WAITLIST_FEATURE_TYPE>(
              (o) => WAITLIST_FEATURE_TYPE.values.byName(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['featureTypes'] = featureTypes?.map((item) => item.name).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WaitlistsInput &&
            (identical(other.featureTypes, featureTypes) ||
                const DeepCollectionEquality()
                    .equals(other.featureTypes, featureTypes)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(featureTypes);
  }

  @override
  String toString() => 'WaitlistsInput(${toJson()})';
}

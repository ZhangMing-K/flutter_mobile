import 'package:iris_common/data/models/enums/segment_type.dart';
import 'package:collection/collection.dart';

class PercentileConnectionInput {
  final List<SEGMENT_TYPE>? segmentTypes;
  const PercentileConnectionInput({this.segmentTypes});
  PercentileConnectionInput copyWith({List<SEGMENT_TYPE>? segmentTypes}) {
    return PercentileConnectionInput(
      segmentTypes: segmentTypes ?? this.segmentTypes,
    );
  }

  factory PercentileConnectionInput.fromJson(Map<String, dynamic> json) {
    return PercentileConnectionInput(
      segmentTypes: json['segmentTypes']
          ?.map<SEGMENT_TYPE>((o) => SEGMENT_TYPE.values.byName(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['segmentTypes'] = segmentTypes?.map((item) => item.name).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PercentileConnectionInput &&
            (identical(other.segmentTypes, segmentTypes) ||
                const DeepCollectionEquality()
                    .equals(other.segmentTypes, segmentTypes)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(segmentTypes);
  }

  @override
  String toString() => 'PercentileConnectionInput(${toJson()})';
}

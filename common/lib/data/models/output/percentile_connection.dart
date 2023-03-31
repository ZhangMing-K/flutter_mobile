import 'package:iris_common/data/models/enums/segment_type.dart';
import 'package:collection/collection.dart';

class PercentileConnection {
  final double? percentile;
  final SEGMENT_TYPE? segmentType;
  const PercentileConnection({this.percentile, this.segmentType});
  PercentileConnection copyWith(
      {double? percentile, SEGMENT_TYPE? segmentType}) {
    return PercentileConnection(
      percentile: percentile ?? this.percentile,
      segmentType: segmentType ?? this.segmentType,
    );
  }

  factory PercentileConnection.fromJson(Map<String, dynamic> json) {
    return PercentileConnection(
      percentile: json['percentile']?.toDouble(),
      segmentType: json['segmentType'] != null
          ? SEGMENT_TYPE.values.byName(json['segmentType'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['percentile'] = percentile;
    data['segmentType'] = segmentType?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PercentileConnection &&
            (identical(other.percentile, percentile) ||
                const DeepCollectionEquality()
                    .equals(other.percentile, percentile)) &&
            (identical(other.segmentType, segmentType) ||
                const DeepCollectionEquality()
                    .equals(other.segmentType, segmentType)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(percentile) ^
        const DeepCollectionEquality().hash(segmentType);
  }

  @override
  String toString() => 'PercentileConnection(${toJson()})';
}

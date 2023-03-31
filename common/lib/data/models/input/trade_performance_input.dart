import 'package:iris_common/data/models/enums/segment_type.dart';
import 'package:collection/collection.dart';

class TradePerformanceInput {
  final List<SEGMENT_TYPE>? segmentTypes;
  const TradePerformanceInput({this.segmentTypes});
  TradePerformanceInput copyWith({List<SEGMENT_TYPE>? segmentTypes}) {
    return TradePerformanceInput(
      segmentTypes: segmentTypes ?? this.segmentTypes,
    );
  }

  factory TradePerformanceInput.fromJson(Map<String, dynamic> json) {
    return TradePerformanceInput(
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
        (other is TradePerformanceInput &&
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
  String toString() => 'TradePerformanceInput(${toJson()})';
}

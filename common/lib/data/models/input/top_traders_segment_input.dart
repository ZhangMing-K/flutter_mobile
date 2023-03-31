import 'package:iris_common/data/models/enums/segment_type.dart';
import 'package:collection/collection.dart';

class TopTradersSegmentInput {
  final int? limit;
  final int? offset;
  final SEGMENT_TYPE? segmentType;
  const TopTradersSegmentInput({this.limit, this.offset, this.segmentType});
  TopTradersSegmentInput copyWith(
      {int? limit, int? offset, SEGMENT_TYPE? segmentType}) {
    return TopTradersSegmentInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      segmentType: segmentType ?? this.segmentType,
    );
  }

  factory TopTradersSegmentInput.fromJson(Map<String, dynamic> json) {
    return TopTradersSegmentInput(
      limit: json['limit'],
      offset: json['offset'],
      segmentType: json['segmentType'] != null
          ? SEGMENT_TYPE.values.byName(json['segmentType'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['segmentType'] = segmentType?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TopTradersSegmentInput &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.segmentType, segmentType) ||
                const DeepCollectionEquality()
                    .equals(other.segmentType, segmentType)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(segmentType);
  }

  @override
  String toString() => 'TopTradersSegmentInput(${toJson()})';
}

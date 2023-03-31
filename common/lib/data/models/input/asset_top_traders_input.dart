import 'package:iris_common/data/models/enums/segment_type.dart';
import 'package:collection/collection.dart';

class AssetTopTradersInput {
  final int? limit;
  final int? offset;
  final SEGMENT_TYPE? segmentType;
  const AssetTopTradersInput({this.limit, this.offset, this.segmentType});
  AssetTopTradersInput copyWith(
      {int? limit, int? offset, SEGMENT_TYPE? segmentType}) {
    return AssetTopTradersInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      segmentType: segmentType ?? this.segmentType,
    );
  }

  factory AssetTopTradersInput.fromJson(Map<String, dynamic> json) {
    return AssetTopTradersInput(
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
        (other is AssetTopTradersInput &&
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
  String toString() => 'AssetTopTradersInput(${toJson()})';
}

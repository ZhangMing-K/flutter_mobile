import 'package:iris_common/data/models/output/iris_position.dart';
import 'package:collection/collection.dart';

class PositionsGetResponse {
  final List<IrisPosition>? positions;
  final String? nextCursor;
  const PositionsGetResponse({required this.positions, this.nextCursor});
  PositionsGetResponse copyWith(
      {List<IrisPosition>? positions, String? nextCursor}) {
    return PositionsGetResponse(
      positions: positions ?? this.positions,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  factory PositionsGetResponse.fromJson(Map<String, dynamic> json) {
    return PositionsGetResponse(
      positions: json['positions']
          ?.map<IrisPosition>((o) => IrisPosition.fromJson(o))
          .toList(),
      nextCursor: json['nextCursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['positions'] = positions?.map((item) => item.toJson()).toList();
    data['nextCursor'] = nextCursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionsGetResponse &&
            (identical(other.positions, positions) ||
                const DeepCollectionEquality()
                    .equals(other.positions, positions)) &&
            (identical(other.nextCursor, nextCursor) ||
                const DeepCollectionEquality()
                    .equals(other.nextCursor, nextCursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(positions) ^
        const DeepCollectionEquality().hash(nextCursor);
  }

  @override
  String toString() => 'PositionsGetResponse(${toJson()})';
}

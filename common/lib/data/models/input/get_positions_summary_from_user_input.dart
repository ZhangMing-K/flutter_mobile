import 'package:collection/collection.dart';

class GetPositionsSummaryFromUserInput {
  final int? limit;
  const GetPositionsSummaryFromUserInput({this.limit});
  GetPositionsSummaryFromUserInput copyWith({int? limit}) {
    return GetPositionsSummaryFromUserInput(
      limit: limit ?? this.limit,
    );
  }

  factory GetPositionsSummaryFromUserInput.fromJson(Map<String, dynamic> json) {
    return GetPositionsSummaryFromUserInput(
      limit: json['limit'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetPositionsSummaryFromUserInput &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(limit);
  }

  @override
  String toString() => 'GetPositionsSummaryFromUserInput(${toJson()})';
}

import 'package:iris_common/data/models/output/flag.dart';
import 'package:collection/collection.dart';

class FlagReviewResponse {
  final Flag? flag;
  const FlagReviewResponse({this.flag});
  FlagReviewResponse copyWith({Flag? flag}) {
    return FlagReviewResponse(
      flag: flag ?? this.flag,
    );
  }

  factory FlagReviewResponse.fromJson(Map<String, dynamic> json) {
    return FlagReviewResponse(
      flag: json['flag'] != null ? Flag.fromJson(json['flag']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['flag'] = flag?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FlagReviewResponse &&
            (identical(other.flag, flag) ||
                const DeepCollectionEquality().equals(other.flag, flag)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(flag);
  }

  @override
  String toString() => 'FlagReviewResponse(${toJson()})';
}

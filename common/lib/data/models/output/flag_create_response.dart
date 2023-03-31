import 'package:iris_common/data/models/output/flag.dart';
import 'package:collection/collection.dart';

class FlagCreateResponse {
  final Flag? flag;
  const FlagCreateResponse({this.flag});
  FlagCreateResponse copyWith({Flag? flag}) {
    return FlagCreateResponse(
      flag: flag ?? this.flag,
    );
  }

  factory FlagCreateResponse.fromJson(Map<String, dynamic> json) {
    return FlagCreateResponse(
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
        (other is FlagCreateResponse &&
            (identical(other.flag, flag) ||
                const DeepCollectionEquality().equals(other.flag, flag)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(flag);
  }

  @override
  String toString() => 'FlagCreateResponse(${toJson()})';
}

import 'package:iris_common/data/models/output/flag.dart';
import 'package:collection/collection.dart';

class FlagsGetResponse {
  final List<Flag>? flags;
  const FlagsGetResponse({this.flags});
  FlagsGetResponse copyWith({List<Flag>? flags}) {
    return FlagsGetResponse(
      flags: flags ?? this.flags,
    );
  }

  factory FlagsGetResponse.fromJson(Map<String, dynamic> json) {
    return FlagsGetResponse(
      flags: json['flags']?.map<Flag>((o) => Flag.fromJson(o)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['flags'] = flags?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FlagsGetResponse &&
            (identical(other.flags, flags) ||
                const DeepCollectionEquality().equals(other.flags, flags)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(flags);
  }

  @override
  String toString() => 'FlagsGetResponse(${toJson()})';
}

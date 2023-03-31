import 'package:iris_common/data/models/output/flag.dart';
import 'package:collection/collection.dart';

class FlagSearchResponse {
  final String? value;
  final List<Flag>? flags;
  const FlagSearchResponse({this.value, this.flags});
  FlagSearchResponse copyWith({String? value, List<Flag>? flags}) {
    return FlagSearchResponse(
      value: value ?? this.value,
      flags: flags ?? this.flags,
    );
  }

  factory FlagSearchResponse.fromJson(Map<String, dynamic> json) {
    return FlagSearchResponse(
      value: json['value'],
      flags: json['flags']?.map<Flag>((o) => Flag.fromJson(o)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['flags'] = flags?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FlagSearchResponse &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.flags, flags) ||
                const DeepCollectionEquality().equals(other.flags, flags)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(value) ^
        const DeepCollectionEquality().hash(flags);
  }

  @override
  String toString() => 'FlagSearchResponse(${toJson()})';
}

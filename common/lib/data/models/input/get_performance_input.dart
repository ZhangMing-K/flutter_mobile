import 'package:iris_common/data/models/enums/performance_graph_type.dart';
import 'package:collection/collection.dart';

class GetPerformanceInput {
  final DateTime? from;
  final DateTime? until;
  final List<PERFORMANCE_GRAPH_TYPE>? equityTypes;
  const GetPerformanceInput({required this.from, this.until, this.equityTypes});
  GetPerformanceInput copyWith(
      {DateTime? from,
      DateTime? until,
      List<PERFORMANCE_GRAPH_TYPE>? equityTypes}) {
    return GetPerformanceInput(
      from: from ?? this.from,
      until: until ?? this.until,
      equityTypes: equityTypes ?? this.equityTypes,
    );
  }

  factory GetPerformanceInput.fromJson(Map<String, dynamic> json) {
    return GetPerformanceInput(
      from: json['from'] != null ? DateTime.parse(json['from']) : null,
      until: json['until'] != null ? DateTime.parse(json['until']) : null,
      equityTypes: json['equityTypes']
          ?.map<PERFORMANCE_GRAPH_TYPE>(
              (o) => PERFORMANCE_GRAPH_TYPE.values.byName(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['from'] = from?.toString();
    data['until'] = until?.toString();
    data['equityTypes'] = equityTypes?.map((item) => item.name).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetPerformanceInput &&
            (identical(other.from, from) ||
                const DeepCollectionEquality().equals(other.from, from)) &&
            (identical(other.until, until) ||
                const DeepCollectionEquality().equals(other.until, until)) &&
            (identical(other.equityTypes, equityTypes) ||
                const DeepCollectionEquality()
                    .equals(other.equityTypes, equityTypes)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(from) ^
        const DeepCollectionEquality().hash(until) ^
        const DeepCollectionEquality().hash(equityTypes);
  }

  @override
  String toString() => 'GetPerformanceInput(${toJson()})';
}

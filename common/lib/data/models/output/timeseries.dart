import 'package:collection/collection.dart';

class Timeseries {
  final List<DateTime>? pointXs;
  final List<double>? pointYs;
  const Timeseries({required this.pointXs, required this.pointYs});
  Timeseries copyWith({List<DateTime>? pointXs, List<double>? pointYs}) {
    return Timeseries(
      pointXs: pointXs ?? this.pointXs,
      pointYs: pointYs ?? this.pointYs,
    );
  }

  factory Timeseries.fromJson(Map<String, dynamic> json) {
    return Timeseries(
      pointXs:
          json['pointXs']?.map<DateTime>((o) => DateTime.parse(o)).toList(),
      pointYs: json['pointYs']?.map<double>((o) => o.todouble()).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['pointXs'] = pointXs?.map((item) => item.toString()).toList();
    data['pointYs'] = pointYs;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Timeseries &&
            (identical(other.pointXs, pointXs) ||
                const DeepCollectionEquality()
                    .equals(other.pointXs, pointXs)) &&
            (identical(other.pointYs, pointYs) ||
                const DeepCollectionEquality().equals(other.pointYs, pointYs)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(pointXs) ^
        const DeepCollectionEquality().hash(pointYs);
  }

  @override
  String toString() => 'Timeseries(${toJson()})';
}

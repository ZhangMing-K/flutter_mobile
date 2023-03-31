import 'package:collection/collection.dart';

class Kpi {
  final int? kpiKey;
  const Kpi({this.kpiKey});
  Kpi copyWith({int? kpiKey}) {
    return Kpi(
      kpiKey: kpiKey ?? this.kpiKey,
    );
  }

  factory Kpi.fromJson(Map<String, dynamic> json) {
    return Kpi(
      kpiKey: json['kpiKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['kpiKey'] = kpiKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Kpi &&
            (identical(other.kpiKey, kpiKey) ||
                const DeepCollectionEquality().equals(other.kpiKey, kpiKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(kpiKey);
  }

  @override
  String toString() => 'Kpi(${toJson()})';
}

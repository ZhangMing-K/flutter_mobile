import 'package:iris_common/data/models/output/asset_run.dart';
import 'package:iris_common/data/models/enums/run_type.dart';
import 'package:collection/collection.dart';

class AssetMaxRunResponse {
  final List<AssetRun>? assetRuns;
  final DateTime? date;
  final RUN_TYPE? runType;
  const AssetMaxRunResponse({this.assetRuns, this.date, this.runType});
  AssetMaxRunResponse copyWith(
      {List<AssetRun>? assetRuns, DateTime? date, RUN_TYPE? runType}) {
    return AssetMaxRunResponse(
      assetRuns: assetRuns ?? this.assetRuns,
      date: date ?? this.date,
      runType: runType ?? this.runType,
    );
  }

  factory AssetMaxRunResponse.fromJson(Map<String, dynamic> json) {
    return AssetMaxRunResponse(
      assetRuns: json['assetRuns']
          ?.map<AssetRun>((o) => AssetRun.fromJson(o))
          .toList(),
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      runType: json['runType'] != null
          ? RUN_TYPE.values.byName(json['runType'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['assetRuns'] = assetRuns?.map((item) => item.toJson()).toList();
    data['date'] = date?.toString();
    data['runType'] = runType?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssetMaxRunResponse &&
            (identical(other.assetRuns, assetRuns) ||
                const DeepCollectionEquality()
                    .equals(other.assetRuns, assetRuns)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.runType, runType) ||
                const DeepCollectionEquality().equals(other.runType, runType)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(assetRuns) ^
        const DeepCollectionEquality().hash(date) ^
        const DeepCollectionEquality().hash(runType);
  }

  @override
  String toString() => 'AssetMaxRunResponse(${toJson()})';
}

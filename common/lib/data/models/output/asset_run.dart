import 'package:iris_common/data/models/output/asset.dart';
import 'package:iris_common/data/models/enums/run_type.dart';
import 'package:collection/collection.dart';

class AssetRun {
  final Asset? asset;
  final DateTime? date;
  final int? maxRun;
  final int? previousMaxRun;
  final int? run;
  final double? flipProbability;
  final int? support;
  final RUN_TYPE? runType;
  final bool? didFlip;
  final double? actualRoi01f;
  final double? percentOfMaxRun;
  final double? marketCap;
  final double? roi1Yp;
  final double? roi2Qp;
  final double? roi01f;
  final double? roi05f;
  final double? roi10f;
  final double? roi15f;
  final double? roi30f;
  const AssetRun(
      {this.asset,
      this.date,
      this.maxRun,
      this.previousMaxRun,
      this.run,
      this.flipProbability,
      this.support,
      this.runType,
      this.didFlip,
      this.actualRoi01f,
      this.percentOfMaxRun,
      this.marketCap,
      this.roi1Yp,
      this.roi2Qp,
      this.roi01f,
      this.roi05f,
      this.roi10f,
      this.roi15f,
      this.roi30f});
  AssetRun copyWith(
      {Asset? asset,
      DateTime? date,
      int? maxRun,
      int? previousMaxRun,
      int? run,
      double? flipProbability,
      int? support,
      RUN_TYPE? runType,
      bool? didFlip,
      double? actualRoi01f,
      double? percentOfMaxRun,
      double? marketCap,
      double? roi1Yp,
      double? roi2Qp,
      double? roi01f,
      double? roi05f,
      double? roi10f,
      double? roi15f,
      double? roi30f}) {
    return AssetRun(
      asset: asset ?? this.asset,
      date: date ?? this.date,
      maxRun: maxRun ?? this.maxRun,
      previousMaxRun: previousMaxRun ?? this.previousMaxRun,
      run: run ?? this.run,
      flipProbability: flipProbability ?? this.flipProbability,
      support: support ?? this.support,
      runType: runType ?? this.runType,
      didFlip: didFlip ?? this.didFlip,
      actualRoi01f: actualRoi01f ?? this.actualRoi01f,
      percentOfMaxRun: percentOfMaxRun ?? this.percentOfMaxRun,
      marketCap: marketCap ?? this.marketCap,
      roi1Yp: roi1Yp ?? this.roi1Yp,
      roi2Qp: roi2Qp ?? this.roi2Qp,
      roi01f: roi01f ?? this.roi01f,
      roi05f: roi05f ?? this.roi05f,
      roi10f: roi10f ?? this.roi10f,
      roi15f: roi15f ?? this.roi15f,
      roi30f: roi30f ?? this.roi30f,
    );
  }

  factory AssetRun.fromJson(Map<String, dynamic> json) {
    return AssetRun(
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      maxRun: json['maxRun'],
      previousMaxRun: json['previousMaxRun'],
      run: json['run'],
      flipProbability: json['flipProbability']?.toDouble(),
      support: json['support'],
      runType: json['runType'] != null
          ? RUN_TYPE.values.byName(json['runType'])
          : null,
      didFlip: json['didFlip'],
      actualRoi01f: json['actualRoi01f']?.toDouble(),
      percentOfMaxRun: json['percentOfMaxRun']?.toDouble(),
      marketCap: json['marketCap']?.toDouble(),
      roi1Yp: json['roi1Yp']?.toDouble(),
      roi2Qp: json['roi2Qp']?.toDouble(),
      roi01f: json['roi01f']?.toDouble(),
      roi05f: json['roi05f']?.toDouble(),
      roi10f: json['roi10f']?.toDouble(),
      roi15f: json['roi15f']?.toDouble(),
      roi30f: json['roi30f']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['asset'] = asset?.toJson();
    data['date'] = date?.toString();
    data['maxRun'] = maxRun;
    data['previousMaxRun'] = previousMaxRun;
    data['run'] = run;
    data['flipProbability'] = flipProbability;
    data['support'] = support;
    data['runType'] = runType?.name;
    data['didFlip'] = didFlip;
    data['actualRoi01f'] = actualRoi01f;
    data['percentOfMaxRun'] = percentOfMaxRun;
    data['marketCap'] = marketCap;
    data['roi1Yp'] = roi1Yp;
    data['roi2Qp'] = roi2Qp;
    data['roi01f'] = roi01f;
    data['roi05f'] = roi05f;
    data['roi10f'] = roi10f;
    data['roi15f'] = roi15f;
    data['roi30f'] = roi30f;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssetRun &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.maxRun, maxRun) ||
                const DeepCollectionEquality().equals(other.maxRun, maxRun)) &&
            (identical(other.previousMaxRun, previousMaxRun) ||
                const DeepCollectionEquality()
                    .equals(other.previousMaxRun, previousMaxRun)) &&
            (identical(other.run, run) ||
                const DeepCollectionEquality().equals(other.run, run)) &&
            (identical(other.flipProbability, flipProbability) ||
                const DeepCollectionEquality()
                    .equals(other.flipProbability, flipProbability)) &&
            (identical(other.support, support) ||
                const DeepCollectionEquality()
                    .equals(other.support, support)) &&
            (identical(other.runType, runType) ||
                const DeepCollectionEquality()
                    .equals(other.runType, runType)) &&
            (identical(other.didFlip, didFlip) ||
                const DeepCollectionEquality()
                    .equals(other.didFlip, didFlip)) &&
            (identical(other.actualRoi01f, actualRoi01f) ||
                const DeepCollectionEquality()
                    .equals(other.actualRoi01f, actualRoi01f)) &&
            (identical(other.percentOfMaxRun, percentOfMaxRun) ||
                const DeepCollectionEquality()
                    .equals(other.percentOfMaxRun, percentOfMaxRun)) &&
            (identical(other.marketCap, marketCap) ||
                const DeepCollectionEquality()
                    .equals(other.marketCap, marketCap)) &&
            (identical(other.roi1Yp, roi1Yp) ||
                const DeepCollectionEquality().equals(other.roi1Yp, roi1Yp)) &&
            (identical(other.roi2Qp, roi2Qp) ||
                const DeepCollectionEquality().equals(other.roi2Qp, roi2Qp)) &&
            (identical(other.roi01f, roi01f) ||
                const DeepCollectionEquality().equals(other.roi01f, roi01f)) &&
            (identical(other.roi05f, roi05f) ||
                const DeepCollectionEquality().equals(other.roi05f, roi05f)) &&
            (identical(other.roi10f, roi10f) ||
                const DeepCollectionEquality().equals(other.roi10f, roi10f)) &&
            (identical(other.roi15f, roi15f) ||
                const DeepCollectionEquality().equals(other.roi15f, roi15f)) &&
            (identical(other.roi30f, roi30f) ||
                const DeepCollectionEquality().equals(other.roi30f, roi30f)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(date) ^
        const DeepCollectionEquality().hash(maxRun) ^
        const DeepCollectionEquality().hash(previousMaxRun) ^
        const DeepCollectionEquality().hash(run) ^
        const DeepCollectionEquality().hash(flipProbability) ^
        const DeepCollectionEquality().hash(support) ^
        const DeepCollectionEquality().hash(runType) ^
        const DeepCollectionEquality().hash(didFlip) ^
        const DeepCollectionEquality().hash(actualRoi01f) ^
        const DeepCollectionEquality().hash(percentOfMaxRun) ^
        const DeepCollectionEquality().hash(marketCap) ^
        const DeepCollectionEquality().hash(roi1Yp) ^
        const DeepCollectionEquality().hash(roi2Qp) ^
        const DeepCollectionEquality().hash(roi01f) ^
        const DeepCollectionEquality().hash(roi05f) ^
        const DeepCollectionEquality().hash(roi10f) ^
        const DeepCollectionEquality().hash(roi15f) ^
        const DeepCollectionEquality().hash(roi30f);
  }

  @override
  String toString() => 'AssetRun(${toJson()})';
}

import 'package:iris_common/data/models/enums/run_type.dart';
import 'package:iris_common/data/models/enums/run_year_direction.dart';
import 'package:iris_common/data/models/enums/run_method.dart';
import 'package:collection/collection.dart';

class AssetMaxRunInput {
  final double? minMarketCap;
  final double? maxMarketCap;
  final RUN_TYPE? runType;
  final DateTime? date;
  final int? limit;
  final int? offset;
  final RUN_YEAR_DIRECTION? runYearDirection;
  final RUN_METHOD? runMethod;
  const AssetMaxRunInput(
      {this.minMarketCap,
      this.maxMarketCap,
      required this.runType,
      required this.date,
      this.limit,
      this.offset,
      this.runYearDirection,
      this.runMethod});
  AssetMaxRunInput copyWith(
      {double? minMarketCap,
      double? maxMarketCap,
      RUN_TYPE? runType,
      DateTime? date,
      int? limit,
      int? offset,
      RUN_YEAR_DIRECTION? runYearDirection,
      RUN_METHOD? runMethod}) {
    return AssetMaxRunInput(
      minMarketCap: minMarketCap ?? this.minMarketCap,
      maxMarketCap: maxMarketCap ?? this.maxMarketCap,
      runType: runType ?? this.runType,
      date: date ?? this.date,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      runYearDirection: runYearDirection ?? this.runYearDirection,
      runMethod: runMethod ?? this.runMethod,
    );
  }

  factory AssetMaxRunInput.fromJson(Map<String, dynamic> json) {
    return AssetMaxRunInput(
      minMarketCap: json['minMarketCap']?.toDouble(),
      maxMarketCap: json['maxMarketCap']?.toDouble(),
      runType: json['runType'] != null
          ? RUN_TYPE.values.byName(json['runType'])
          : null,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      limit: json['limit'],
      offset: json['offset'],
      runYearDirection: json['runYearDirection'] != null
          ? RUN_YEAR_DIRECTION.values.byName(json['runYearDirection'])
          : null,
      runMethod: json['runMethod'] != null
          ? RUN_METHOD.values.byName(json['runMethod'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['minMarketCap'] = minMarketCap;
    data['maxMarketCap'] = maxMarketCap;
    data['runType'] = runType?.name;
    data['date'] = date?.toString();
    data['limit'] = limit;
    data['offset'] = offset;
    data['runYearDirection'] = runYearDirection?.name;
    data['runMethod'] = runMethod?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssetMaxRunInput &&
            (identical(other.minMarketCap, minMarketCap) ||
                const DeepCollectionEquality()
                    .equals(other.minMarketCap, minMarketCap)) &&
            (identical(other.maxMarketCap, maxMarketCap) ||
                const DeepCollectionEquality()
                    .equals(other.maxMarketCap, maxMarketCap)) &&
            (identical(other.runType, runType) ||
                const DeepCollectionEquality()
                    .equals(other.runType, runType)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.runYearDirection, runYearDirection) ||
                const DeepCollectionEquality()
                    .equals(other.runYearDirection, runYearDirection)) &&
            (identical(other.runMethod, runMethod) ||
                const DeepCollectionEquality()
                    .equals(other.runMethod, runMethod)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(minMarketCap) ^
        const DeepCollectionEquality().hash(maxMarketCap) ^
        const DeepCollectionEquality().hash(runType) ^
        const DeepCollectionEquality().hash(date) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(runYearDirection) ^
        const DeepCollectionEquality().hash(runMethod);
  }

  @override
  String toString() => 'AssetMaxRunInput(${toJson()})';
}

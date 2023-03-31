import 'package:iris_common/data/models/enums/locator.dart';
import 'package:iris_common/data/models/enums/position_type.dart';
import 'package:iris_common/data/models/enums/option_type.dart';
import 'package:iris_common/data/models/enums/position_status.dart';
import 'package:iris_common/data/models/input/between_input.dart';
import 'package:collection/collection.dart';

class PositionTypeAnalysisInput {
  final LOCATOR? locator;
  final List<int>? locatorKeys;
  final List<String>? symbols;
  final List<POSITION_TYPE>? positionTypes;
  final List<OPTION_TYPE>? optionTypes;
  final POSITION_STATUS? positionStatus;
  final BetweenInput? between;
  final int? limit;
  final int? offset;
  const PositionTypeAnalysisInput(
      {this.locator,
      this.locatorKeys,
      this.symbols,
      this.positionTypes,
      this.optionTypes,
      this.positionStatus,
      this.between,
      this.limit,
      this.offset});
  PositionTypeAnalysisInput copyWith(
      {LOCATOR? locator,
      List<int>? locatorKeys,
      List<String>? symbols,
      List<POSITION_TYPE>? positionTypes,
      List<OPTION_TYPE>? optionTypes,
      POSITION_STATUS? positionStatus,
      BetweenInput? between,
      int? limit,
      int? offset}) {
    return PositionTypeAnalysisInput(
      locator: locator ?? this.locator,
      locatorKeys: locatorKeys ?? this.locatorKeys,
      symbols: symbols ?? this.symbols,
      positionTypes: positionTypes ?? this.positionTypes,
      optionTypes: optionTypes ?? this.optionTypes,
      positionStatus: positionStatus ?? this.positionStatus,
      between: between ?? this.between,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory PositionTypeAnalysisInput.fromJson(Map<String, dynamic> json) {
    return PositionTypeAnalysisInput(
      locator: json['locator'] != null
          ? LOCATOR.values.byName(json['locator'])
          : null,
      locatorKeys: json['locatorKeys']?.map<int>((o) => (o as int)).toList(),
      symbols: json['symbols']?.map<String>((o) => o.toString()).toList(),
      positionTypes: json['positionTypes']
          ?.map<POSITION_TYPE>((o) => POSITION_TYPE.values.byName(o))
          .toList(),
      optionTypes: json['optionTypes']
          ?.map<OPTION_TYPE>((o) => OPTION_TYPE.values.byName(o))
          .toList(),
      positionStatus: json['positionStatus'] != null
          ? POSITION_STATUS.values.byName(json['positionStatus'])
          : null,
      between: json['between'] != null
          ? BetweenInput.fromJson(json['between'])
          : null,
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['locator'] = locator?.name;
    data['locatorKeys'] = locatorKeys;
    data['symbols'] = symbols;
    data['positionTypes'] = positionTypes?.map((item) => item.name).toList();
    data['optionTypes'] = optionTypes?.map((item) => item.name).toList();
    data['positionStatus'] = positionStatus?.name;
    data['between'] = between?.toJson();
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionTypeAnalysisInput &&
            (identical(other.locator, locator) ||
                const DeepCollectionEquality()
                    .equals(other.locator, locator)) &&
            (identical(other.locatorKeys, locatorKeys) ||
                const DeepCollectionEquality()
                    .equals(other.locatorKeys, locatorKeys)) &&
            (identical(other.symbols, symbols) ||
                const DeepCollectionEquality()
                    .equals(other.symbols, symbols)) &&
            (identical(other.positionTypes, positionTypes) ||
                const DeepCollectionEquality()
                    .equals(other.positionTypes, positionTypes)) &&
            (identical(other.optionTypes, optionTypes) ||
                const DeepCollectionEquality()
                    .equals(other.optionTypes, optionTypes)) &&
            (identical(other.positionStatus, positionStatus) ||
                const DeepCollectionEquality()
                    .equals(other.positionStatus, positionStatus)) &&
            (identical(other.between, between) ||
                const DeepCollectionEquality()
                    .equals(other.between, between)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(locator) ^
        const DeepCollectionEquality().hash(locatorKeys) ^
        const DeepCollectionEquality().hash(symbols) ^
        const DeepCollectionEquality().hash(positionTypes) ^
        const DeepCollectionEquality().hash(optionTypes) ^
        const DeepCollectionEquality().hash(positionStatus) ^
        const DeepCollectionEquality().hash(between) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'PositionTypeAnalysisInput(${toJson()})';
}

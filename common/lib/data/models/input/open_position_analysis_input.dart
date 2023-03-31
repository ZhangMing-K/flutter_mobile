import 'package:iris_common/data/models/enums/position_analysis_locator.dart';
import 'package:iris_common/data/models/enums/position_type.dart';
import 'package:iris_common/data/models/enums/option_type.dart';
import 'package:iris_common/data/models/enums/position_outlook.dart';
import 'package:iris_common/data/models/enums/open_position_order_by.dart';
import 'package:collection/collection.dart';

class OpenPositionAnalysisInput {
  final POSITION_ANALYSIS_LOCATOR? locator;
  final List<int>? locatorKeys;
  final List<String>? symbols;
  final List<POSITION_TYPE>? positionTypes;
  final List<OPTION_TYPE>? optionTypes;
  final POSITION_OUTLOOK? outlook;
  final OPEN_POSITION_ORDER_BY? orderBy;
  final int? limit;
  final int? offset;
  const OpenPositionAnalysisInput(
      {this.locator,
      this.locatorKeys,
      this.symbols,
      this.positionTypes,
      this.optionTypes,
      this.outlook,
      this.orderBy,
      this.limit,
      this.offset});
  OpenPositionAnalysisInput copyWith(
      {POSITION_ANALYSIS_LOCATOR? locator,
      List<int>? locatorKeys,
      List<String>? symbols,
      List<POSITION_TYPE>? positionTypes,
      List<OPTION_TYPE>? optionTypes,
      POSITION_OUTLOOK? outlook,
      OPEN_POSITION_ORDER_BY? orderBy,
      int? limit,
      int? offset}) {
    return OpenPositionAnalysisInput(
      locator: locator ?? this.locator,
      locatorKeys: locatorKeys ?? this.locatorKeys,
      symbols: symbols ?? this.symbols,
      positionTypes: positionTypes ?? this.positionTypes,
      optionTypes: optionTypes ?? this.optionTypes,
      outlook: outlook ?? this.outlook,
      orderBy: orderBy ?? this.orderBy,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory OpenPositionAnalysisInput.fromJson(Map<String, dynamic> json) {
    return OpenPositionAnalysisInput(
      locator: json['locator'] != null
          ? POSITION_ANALYSIS_LOCATOR.values.byName(json['locator'])
          : null,
      locatorKeys: json['locatorKeys']?.map<int>((o) => (o as int)).toList(),
      symbols: json['symbols']?.map<String>((o) => o.toString()).toList(),
      positionTypes: json['positionTypes']
          ?.map<POSITION_TYPE>((o) => POSITION_TYPE.values.byName(o))
          .toList(),
      optionTypes: json['optionTypes']
          ?.map<OPTION_TYPE>((o) => OPTION_TYPE.values.byName(o))
          .toList(),
      outlook: json['outlook'] != null
          ? POSITION_OUTLOOK.values.byName(json['outlook'])
          : null,
      orderBy: json['orderBy'] != null
          ? OPEN_POSITION_ORDER_BY.values.byName(json['orderBy'])
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
    data['outlook'] = outlook?.name;
    data['orderBy'] = orderBy?.name;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OpenPositionAnalysisInput &&
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
            (identical(other.outlook, outlook) ||
                const DeepCollectionEquality()
                    .equals(other.outlook, outlook)) &&
            (identical(other.orderBy, orderBy) ||
                const DeepCollectionEquality()
                    .equals(other.orderBy, orderBy)) &&
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
        const DeepCollectionEquality().hash(outlook) ^
        const DeepCollectionEquality().hash(orderBy) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'OpenPositionAnalysisInput(${toJson()})';
}

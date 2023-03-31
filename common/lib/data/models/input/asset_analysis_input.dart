import 'package:iris_common/data/models/enums/asset_analysis_locator.dart';
import 'package:iris_common/data/models/enums/position_type.dart';
import 'package:iris_common/data/models/enums/option_type.dart';
import 'package:iris_common/data/models/input/between_input.dart';
import 'package:iris_common/data/models/input/asset_analysis_order_by.dart';
import 'package:collection/collection.dart';

class AssetAnalysisInput {
  final int? authUserKey;
  final ASSET_ANALYSIS_LOCATOR? locator;
  final List<int>? locatorKeys;
  final List<String>? symbols;
  final List<int>? assetKeys;
  final List<POSITION_TYPE>? positionTypes;
  final List<OPTION_TYPE>? optionTypes;
  final BetweenInput? between;
  final int? limit;
  final int? offset;
  final AssetAnalysisOrderBy? orderBy;
  const AssetAnalysisInput(
      {this.authUserKey,
      this.locator,
      this.locatorKeys,
      this.symbols,
      this.assetKeys,
      this.positionTypes,
      this.optionTypes,
      this.between,
      this.limit,
      this.offset,
      this.orderBy});
  AssetAnalysisInput copyWith(
      {int? authUserKey,
      ASSET_ANALYSIS_LOCATOR? locator,
      List<int>? locatorKeys,
      List<String>? symbols,
      List<int>? assetKeys,
      List<POSITION_TYPE>? positionTypes,
      List<OPTION_TYPE>? optionTypes,
      BetweenInput? between,
      int? limit,
      int? offset,
      AssetAnalysisOrderBy? orderBy}) {
    return AssetAnalysisInput(
      authUserKey: authUserKey ?? this.authUserKey,
      locator: locator ?? this.locator,
      locatorKeys: locatorKeys ?? this.locatorKeys,
      symbols: symbols ?? this.symbols,
      assetKeys: assetKeys ?? this.assetKeys,
      positionTypes: positionTypes ?? this.positionTypes,
      optionTypes: optionTypes ?? this.optionTypes,
      between: between ?? this.between,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      orderBy: orderBy ?? this.orderBy,
    );
  }

  factory AssetAnalysisInput.fromJson(Map<String, dynamic> json) {
    return AssetAnalysisInput(
      authUserKey: json['authUserKey'],
      locator: json['locator'] != null
          ? ASSET_ANALYSIS_LOCATOR.values.byName(json['locator'])
          : null,
      locatorKeys: json['locatorKeys']?.map<int>((o) => (o as int)).toList(),
      symbols: json['symbols']?.map<String>((o) => o.toString()).toList(),
      assetKeys: json['assetKeys']?.map<int>((o) => (o as int)).toList(),
      positionTypes: json['positionTypes']
          ?.map<POSITION_TYPE>((o) => POSITION_TYPE.values.byName(o))
          .toList(),
      optionTypes: json['optionTypes']
          ?.map<OPTION_TYPE>((o) => OPTION_TYPE.values.byName(o))
          .toList(),
      between: json['between'] != null
          ? BetweenInput.fromJson(json['between'])
          : null,
      limit: json['limit'],
      offset: json['offset'],
      orderBy: json['orderBy'] != null
          ? AssetAnalysisOrderBy.fromJson(json['orderBy'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['authUserKey'] = authUserKey;
    data['locator'] = locator?.name;
    data['locatorKeys'] = locatorKeys;
    data['symbols'] = symbols;
    data['assetKeys'] = assetKeys;
    data['positionTypes'] = positionTypes?.map((item) => item.name).toList();
    data['optionTypes'] = optionTypes?.map((item) => item.name).toList();
    data['between'] = between?.toJson();
    data['limit'] = limit;
    data['offset'] = offset;
    data['orderBy'] = orderBy?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssetAnalysisInput &&
            (identical(other.authUserKey, authUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.authUserKey, authUserKey)) &&
            (identical(other.locator, locator) ||
                const DeepCollectionEquality()
                    .equals(other.locator, locator)) &&
            (identical(other.locatorKeys, locatorKeys) ||
                const DeepCollectionEquality()
                    .equals(other.locatorKeys, locatorKeys)) &&
            (identical(other.symbols, symbols) ||
                const DeepCollectionEquality()
                    .equals(other.symbols, symbols)) &&
            (identical(other.assetKeys, assetKeys) ||
                const DeepCollectionEquality()
                    .equals(other.assetKeys, assetKeys)) &&
            (identical(other.positionTypes, positionTypes) ||
                const DeepCollectionEquality()
                    .equals(other.positionTypes, positionTypes)) &&
            (identical(other.optionTypes, optionTypes) ||
                const DeepCollectionEquality()
                    .equals(other.optionTypes, optionTypes)) &&
            (identical(other.between, between) ||
                const DeepCollectionEquality()
                    .equals(other.between, between)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.orderBy, orderBy) ||
                const DeepCollectionEquality().equals(other.orderBy, orderBy)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(authUserKey) ^
        const DeepCollectionEquality().hash(locator) ^
        const DeepCollectionEquality().hash(locatorKeys) ^
        const DeepCollectionEquality().hash(symbols) ^
        const DeepCollectionEquality().hash(assetKeys) ^
        const DeepCollectionEquality().hash(positionTypes) ^
        const DeepCollectionEquality().hash(optionTypes) ^
        const DeepCollectionEquality().hash(between) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(orderBy);
  }

  @override
  String toString() => 'AssetAnalysisInput(${toJson()})';
}

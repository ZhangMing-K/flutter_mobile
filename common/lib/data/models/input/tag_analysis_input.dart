import 'package:iris_common/data/models/enums/tag_analysis_locator.dart';
import 'package:iris_common/data/models/input/between_input.dart';
import 'package:iris_common/data/models/enums/tag_analysis_order_by.dart';
import 'package:collection/collection.dart';

class TagAnalysisInput {
  final int? authUserKey;
  final TAG_ANALYSIS_LOCATOR? locator;
  final List<int>? locatorKeys;
  final List<String>? symbols;
  final BetweenInput? between;
  final int? limit;
  final int? offset;
  final TAG_ANALYSIS_ORDER_BY? orderBy;
  const TagAnalysisInput(
      {this.authUserKey,
      this.locator,
      this.locatorKeys,
      this.symbols,
      this.between,
      this.limit,
      this.offset,
      this.orderBy});
  TagAnalysisInput copyWith(
      {int? authUserKey,
      TAG_ANALYSIS_LOCATOR? locator,
      List<int>? locatorKeys,
      List<String>? symbols,
      BetweenInput? between,
      int? limit,
      int? offset,
      TAG_ANALYSIS_ORDER_BY? orderBy}) {
    return TagAnalysisInput(
      authUserKey: authUserKey ?? this.authUserKey,
      locator: locator ?? this.locator,
      locatorKeys: locatorKeys ?? this.locatorKeys,
      symbols: symbols ?? this.symbols,
      between: between ?? this.between,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      orderBy: orderBy ?? this.orderBy,
    );
  }

  factory TagAnalysisInput.fromJson(Map<String, dynamic> json) {
    return TagAnalysisInput(
      authUserKey: json['authUserKey'],
      locator: json['locator'] != null
          ? TAG_ANALYSIS_LOCATOR.values.byName(json['locator'])
          : null,
      locatorKeys: json['locatorKeys']?.map<int>((o) => (o as int)).toList(),
      symbols: json['symbols']?.map<String>((o) => o.toString()).toList(),
      between: json['between'] != null
          ? BetweenInput.fromJson(json['between'])
          : null,
      limit: json['limit'],
      offset: json['offset'],
      orderBy: json['orderBy'] != null
          ? TAG_ANALYSIS_ORDER_BY.values.byName(json['orderBy'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['authUserKey'] = authUserKey;
    data['locator'] = locator?.name;
    data['locatorKeys'] = locatorKeys;
    data['symbols'] = symbols;
    data['between'] = between?.toJson();
    data['limit'] = limit;
    data['offset'] = offset;
    data['orderBy'] = orderBy?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TagAnalysisInput &&
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
        const DeepCollectionEquality().hash(between) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(orderBy);
  }

  @override
  String toString() => 'TagAnalysisInput(${toJson()})';
}

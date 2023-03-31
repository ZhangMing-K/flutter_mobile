import 'package:collection/collection.dart';

class AssetSearchInput {
  final String? symbol;
  final String? partialSymbol;
  final String? searchValue;
  final List<int>? assetKeys;
  final int? limit;
  final int? offset;
  const AssetSearchInput(
      {this.symbol,
      this.partialSymbol,
      this.searchValue,
      this.assetKeys,
      this.limit,
      this.offset});
  AssetSearchInput copyWith(
      {String? symbol,
      String? partialSymbol,
      String? searchValue,
      List<int>? assetKeys,
      int? limit,
      int? offset}) {
    return AssetSearchInput(
      symbol: symbol ?? this.symbol,
      partialSymbol: partialSymbol ?? this.partialSymbol,
      searchValue: searchValue ?? this.searchValue,
      assetKeys: assetKeys ?? this.assetKeys,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory AssetSearchInput.fromJson(Map<String, dynamic> json) {
    return AssetSearchInput(
      symbol: json['symbol'],
      partialSymbol: json['partialSymbol'],
      searchValue: json['searchValue'],
      assetKeys: json['assetKeys']?.map<int>((o) => (o as int)).toList(),
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['partialSymbol'] = partialSymbol;
    data['searchValue'] = searchValue;
    data['assetKeys'] = assetKeys;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssetSearchInput &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.partialSymbol, partialSymbol) ||
                const DeepCollectionEquality()
                    .equals(other.partialSymbol, partialSymbol)) &&
            (identical(other.searchValue, searchValue) ||
                const DeepCollectionEquality()
                    .equals(other.searchValue, searchValue)) &&
            (identical(other.assetKeys, assetKeys) ||
                const DeepCollectionEquality()
                    .equals(other.assetKeys, assetKeys)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(partialSymbol) ^
        const DeepCollectionEquality().hash(searchValue) ^
        const DeepCollectionEquality().hash(assetKeys) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'AssetSearchInput(${toJson()})';
}

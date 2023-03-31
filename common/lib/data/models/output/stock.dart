import 'package:collection/collection.dart';

class Stock {
  final String? stockKey;
  final String? symbol;
  final String? companyName;
  const Stock({this.stockKey, this.symbol, this.companyName});
  Stock copyWith({String? stockKey, String? symbol, String? companyName}) {
    return Stock(
      stockKey: stockKey ?? this.stockKey,
      symbol: symbol ?? this.symbol,
      companyName: companyName ?? this.companyName,
    );
  }

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      stockKey: json['stockKey'],
      symbol: json['symbol'],
      companyName: json['companyName'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['stockKey'] = stockKey;
    data['symbol'] = symbol;
    data['companyName'] = companyName;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Stock &&
            (identical(other.stockKey, stockKey) ||
                const DeepCollectionEquality()
                    .equals(other.stockKey, stockKey)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.companyName, companyName) ||
                const DeepCollectionEquality()
                    .equals(other.companyName, companyName)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(stockKey) ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(companyName);
  }

  @override
  String toString() => 'Stock(${toJson()})';
}

import 'package:iris_common/data/models/enums/feed_symbol_type.dart';
import 'package:collection/collection.dart';

class Symbol {
  final FEED_SYMBOL_TYPE? symbolType;
  const Symbol({this.symbolType});
  Symbol copyWith({FEED_SYMBOL_TYPE? symbolType}) {
    return Symbol(
      symbolType: symbolType ?? this.symbolType,
    );
  }

  factory Symbol.fromJson(Map<String, dynamic> json) {
    return Symbol(
      symbolType: json['symbolType'] != null
          ? FEED_SYMBOL_TYPE.values.byName(json['symbolType'])
          : null,
    );
  }

  Map toJson() {
    Map _data = {};
    _data['symbolType'] = symbolType?.name;
    return _data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Symbol &&
            (identical(other.symbolType, symbolType) ||
                const DeepCollectionEquality()
                    .equals(other.symbolType, symbolType)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(symbolType);
  }

  @override
  String toString() => 'Symbol(${toJson()})';
}

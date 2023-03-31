import 'package:collection/collection.dart';

class PositionTypeSummary {
  final double? equityPercent;
  final double? optionPercent;
  final double? cryptoPercent;
  final double? equityMarketValue;
  final double? optionMarketValue;
  final double? cryptoMarketValue;
  const PositionTypeSummary(
      {this.equityPercent,
      this.optionPercent,
      this.cryptoPercent,
      this.equityMarketValue,
      this.optionMarketValue,
      this.cryptoMarketValue});
  PositionTypeSummary copyWith(
      {double? equityPercent,
      double? optionPercent,
      double? cryptoPercent,
      double? equityMarketValue,
      double? optionMarketValue,
      double? cryptoMarketValue}) {
    return PositionTypeSummary(
      equityPercent: equityPercent ?? this.equityPercent,
      optionPercent: optionPercent ?? this.optionPercent,
      cryptoPercent: cryptoPercent ?? this.cryptoPercent,
      equityMarketValue: equityMarketValue ?? this.equityMarketValue,
      optionMarketValue: optionMarketValue ?? this.optionMarketValue,
      cryptoMarketValue: cryptoMarketValue ?? this.cryptoMarketValue,
    );
  }

  factory PositionTypeSummary.fromJson(Map<String, dynamic> json) {
    return PositionTypeSummary(
      equityPercent: json['equityPercent']?.toDouble(),
      optionPercent: json['optionPercent']?.toDouble(),
      cryptoPercent: json['cryptoPercent']?.toDouble(),
      equityMarketValue: json['equityMarketValue']?.toDouble(),
      optionMarketValue: json['optionMarketValue']?.toDouble(),
      cryptoMarketValue: json['cryptoMarketValue']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['equityPercent'] = equityPercent;
    data['optionPercent'] = optionPercent;
    data['cryptoPercent'] = cryptoPercent;
    data['equityMarketValue'] = equityMarketValue;
    data['optionMarketValue'] = optionMarketValue;
    data['cryptoMarketValue'] = cryptoMarketValue;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionTypeSummary &&
            (identical(other.equityPercent, equityPercent) ||
                const DeepCollectionEquality()
                    .equals(other.equityPercent, equityPercent)) &&
            (identical(other.optionPercent, optionPercent) ||
                const DeepCollectionEquality()
                    .equals(other.optionPercent, optionPercent)) &&
            (identical(other.cryptoPercent, cryptoPercent) ||
                const DeepCollectionEquality()
                    .equals(other.cryptoPercent, cryptoPercent)) &&
            (identical(other.equityMarketValue, equityMarketValue) ||
                const DeepCollectionEquality()
                    .equals(other.equityMarketValue, equityMarketValue)) &&
            (identical(other.optionMarketValue, optionMarketValue) ||
                const DeepCollectionEquality()
                    .equals(other.optionMarketValue, optionMarketValue)) &&
            (identical(other.cryptoMarketValue, cryptoMarketValue) ||
                const DeepCollectionEquality()
                    .equals(other.cryptoMarketValue, cryptoMarketValue)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(equityPercent) ^
        const DeepCollectionEquality().hash(optionPercent) ^
        const DeepCollectionEquality().hash(cryptoPercent) ^
        const DeepCollectionEquality().hash(equityMarketValue) ^
        const DeepCollectionEquality().hash(optionMarketValue) ^
        const DeepCollectionEquality().hash(cryptoMarketValue);
  }

  @override
  String toString() => 'PositionTypeSummary(${toJson()})';
}

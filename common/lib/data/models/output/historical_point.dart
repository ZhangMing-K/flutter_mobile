import 'package:collection/collection.dart';

class HistoricalPoint {
  final DateTime? beginsAt;
  final double? openAmount;
  final double? closeAmount;
  final double? highAmount;
  final double? lowAmount;
  final double? intervalReturnPercentage;
  final double? spanReturnPercentage;
  final double? spanReturnAmount;
  final double? intervalReturnAmount;
  final String? session;
  final double? volume;
  final double? sellVolume;
  final double? buyVolume;
  const HistoricalPoint(
      {this.beginsAt,
      this.openAmount,
      this.closeAmount,
      this.highAmount,
      this.lowAmount,
      this.intervalReturnPercentage,
      this.spanReturnPercentage,
      this.spanReturnAmount,
      this.intervalReturnAmount,
      this.session,
      this.volume,
      this.sellVolume,
      this.buyVolume});
  HistoricalPoint copyWith(
      {DateTime? beginsAt,
      double? openAmount,
      double? closeAmount,
      double? highAmount,
      double? lowAmount,
      double? intervalReturnPercentage,
      double? spanReturnPercentage,
      double? spanReturnAmount,
      double? intervalReturnAmount,
      String? session,
      double? volume,
      double? sellVolume,
      double? buyVolume}) {
    return HistoricalPoint(
      beginsAt: beginsAt ?? this.beginsAt,
      openAmount: openAmount ?? this.openAmount,
      closeAmount: closeAmount ?? this.closeAmount,
      highAmount: highAmount ?? this.highAmount,
      lowAmount: lowAmount ?? this.lowAmount,
      intervalReturnPercentage:
          intervalReturnPercentage ?? this.intervalReturnPercentage,
      spanReturnPercentage: spanReturnPercentage ?? this.spanReturnPercentage,
      spanReturnAmount: spanReturnAmount ?? this.spanReturnAmount,
      intervalReturnAmount: intervalReturnAmount ?? this.intervalReturnAmount,
      session: session ?? this.session,
      volume: volume ?? this.volume,
      sellVolume: sellVolume ?? this.sellVolume,
      buyVolume: buyVolume ?? this.buyVolume,
    );
  }

  factory HistoricalPoint.fromJson(Map<String, dynamic> json) {
    return HistoricalPoint(
      beginsAt:
          json['beginsAt'] != null ? DateTime.parse(json['beginsAt']) : null,
      openAmount: json['openAmount']?.toDouble(),
      closeAmount: json['closeAmount']?.toDouble(),
      highAmount: json['highAmount']?.toDouble(),
      lowAmount: json['lowAmount']?.toDouble(),
      intervalReturnPercentage: json['intervalReturnPercentage']?.toDouble(),
      spanReturnPercentage: json['spanReturnPercentage']?.toDouble(),
      spanReturnAmount: json['spanReturnAmount']?.toDouble(),
      intervalReturnAmount: json['intervalReturnAmount']?.toDouble(),
      session: json['session'],
      volume: json['volume']?.toDouble(),
      sellVolume: json['sellVolume']?.toDouble(),
      buyVolume: json['buyVolume']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['beginsAt'] = beginsAt?.toString();
    data['openAmount'] = openAmount;
    data['closeAmount'] = closeAmount;
    data['highAmount'] = highAmount;
    data['lowAmount'] = lowAmount;
    data['intervalReturnPercentage'] = intervalReturnPercentage;
    data['spanReturnPercentage'] = spanReturnPercentage;
    data['spanReturnAmount'] = spanReturnAmount;
    data['intervalReturnAmount'] = intervalReturnAmount;
    data['session'] = session;
    data['volume'] = volume;
    data['sellVolume'] = sellVolume;
    data['buyVolume'] = buyVolume;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is HistoricalPoint &&
            (identical(other.beginsAt, beginsAt) ||
                const DeepCollectionEquality()
                    .equals(other.beginsAt, beginsAt)) &&
            (identical(other.openAmount, openAmount) ||
                const DeepCollectionEquality()
                    .equals(other.openAmount, openAmount)) &&
            (identical(other.closeAmount, closeAmount) ||
                const DeepCollectionEquality()
                    .equals(other.closeAmount, closeAmount)) &&
            (identical(other.highAmount, highAmount) ||
                const DeepCollectionEquality()
                    .equals(other.highAmount, highAmount)) &&
            (identical(other.lowAmount, lowAmount) ||
                const DeepCollectionEquality()
                    .equals(other.lowAmount, lowAmount)) &&
            (identical(
                    other.intervalReturnPercentage, intervalReturnPercentage) ||
                const DeepCollectionEquality().equals(
                    other.intervalReturnPercentage,
                    intervalReturnPercentage)) &&
            (identical(other.spanReturnPercentage, spanReturnPercentage) ||
                const DeepCollectionEquality().equals(
                    other.spanReturnPercentage, spanReturnPercentage)) &&
            (identical(other.spanReturnAmount, spanReturnAmount) ||
                const DeepCollectionEquality()
                    .equals(other.spanReturnAmount, spanReturnAmount)) &&
            (identical(other.intervalReturnAmount, intervalReturnAmount) ||
                const DeepCollectionEquality().equals(
                    other.intervalReturnAmount, intervalReturnAmount)) &&
            (identical(other.session, session) ||
                const DeepCollectionEquality()
                    .equals(other.session, session)) &&
            (identical(other.volume, volume) ||
                const DeepCollectionEquality().equals(other.volume, volume)) &&
            (identical(other.sellVolume, sellVolume) ||
                const DeepCollectionEquality()
                    .equals(other.sellVolume, sellVolume)) &&
            (identical(other.buyVolume, buyVolume) ||
                const DeepCollectionEquality()
                    .equals(other.buyVolume, buyVolume)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(beginsAt) ^
        const DeepCollectionEquality().hash(openAmount) ^
        const DeepCollectionEquality().hash(closeAmount) ^
        const DeepCollectionEquality().hash(highAmount) ^
        const DeepCollectionEquality().hash(lowAmount) ^
        const DeepCollectionEquality().hash(intervalReturnPercentage) ^
        const DeepCollectionEquality().hash(spanReturnPercentage) ^
        const DeepCollectionEquality().hash(spanReturnAmount) ^
        const DeepCollectionEquality().hash(intervalReturnAmount) ^
        const DeepCollectionEquality().hash(session) ^
        const DeepCollectionEquality().hash(volume) ^
        const DeepCollectionEquality().hash(sellVolume) ^
        const DeepCollectionEquality().hash(buyVolume);
  }

  @override
  String toString() => 'HistoricalPoint(${toJson()})';
}

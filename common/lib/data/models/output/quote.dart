import 'package:collection/collection.dart';

class Quote {
  final double? open;
  final DateTime? openTime;
  final double? close;
  final DateTime? closeTime;
  final double? high;
  final double? low;
  final double? latestPrice;
  final String? latestSource;
  final String? latestTime;
  final double? latestVolume;
  final double? volume;
  final double? realtimePrice;
  final double? realtimeSize;
  final DateTime? lastUpdated;
  final double? delayedPrice;
  final double? extendedPrice;
  final double? extendedChange;
  final DateTime? extendedPriceTime;
  final double? previousClose;
  final double? previousVolume;
  final double? change;
  final double? changePercent;
  final double? peRatio;
  final double? marketCap;
  final double? week52High;
  final double? week52Low;
  const Quote(
      {this.open,
      this.openTime,
      this.close,
      this.closeTime,
      this.high,
      this.low,
      this.latestPrice,
      this.latestSource,
      this.latestTime,
      this.latestVolume,
      this.volume,
      this.realtimePrice,
      this.realtimeSize,
      this.lastUpdated,
      this.delayedPrice,
      this.extendedPrice,
      this.extendedChange,
      this.extendedPriceTime,
      this.previousClose,
      this.previousVolume,
      this.change,
      this.changePercent,
      this.peRatio,
      this.marketCap,
      this.week52High,
      this.week52Low});
  Quote copyWith(
      {double? open,
      DateTime? openTime,
      double? close,
      DateTime? closeTime,
      double? high,
      double? low,
      double? latestPrice,
      String? latestSource,
      String? latestTime,
      double? latestVolume,
      double? volume,
      double? realtimePrice,
      double? realtimeSize,
      DateTime? lastUpdated,
      double? delayedPrice,
      double? extendedPrice,
      double? extendedChange,
      DateTime? extendedPriceTime,
      double? previousClose,
      double? previousVolume,
      double? change,
      double? changePercent,
      double? peRatio,
      double? marketCap,
      double? week52High,
      double? week52Low}) {
    return Quote(
      open: open ?? this.open,
      openTime: openTime ?? this.openTime,
      close: close ?? this.close,
      closeTime: closeTime ?? this.closeTime,
      high: high ?? this.high,
      low: low ?? this.low,
      latestPrice: latestPrice ?? this.latestPrice,
      latestSource: latestSource ?? this.latestSource,
      latestTime: latestTime ?? this.latestTime,
      latestVolume: latestVolume ?? this.latestVolume,
      volume: volume ?? this.volume,
      realtimePrice: realtimePrice ?? this.realtimePrice,
      realtimeSize: realtimeSize ?? this.realtimeSize,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      delayedPrice: delayedPrice ?? this.delayedPrice,
      extendedPrice: extendedPrice ?? this.extendedPrice,
      extendedChange: extendedChange ?? this.extendedChange,
      extendedPriceTime: extendedPriceTime ?? this.extendedPriceTime,
      previousClose: previousClose ?? this.previousClose,
      previousVolume: previousVolume ?? this.previousVolume,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
      peRatio: peRatio ?? this.peRatio,
      marketCap: marketCap ?? this.marketCap,
      week52High: week52High ?? this.week52High,
      week52Low: week52Low ?? this.week52Low,
    );
  }

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      open: json['open']?.toDouble(),
      openTime:
          json['openTime'] != null ? DateTime.parse(json['openTime']) : null,
      close: json['close']?.toDouble(),
      closeTime:
          json['closeTime'] != null ? DateTime.parse(json['closeTime']) : null,
      high: json['high']?.toDouble(),
      low: json['low']?.toDouble(),
      latestPrice: json['latestPrice']?.toDouble(),
      latestSource: json['latestSource'],
      latestTime: json['latestTime'],
      latestVolume: json['latestVolume']?.toDouble(),
      volume: json['volume']?.toDouble(),
      realtimePrice: json['realtimePrice']?.toDouble(),
      realtimeSize: json['realtimeSize']?.toDouble(),
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
      delayedPrice: json['delayedPrice']?.toDouble(),
      extendedPrice: json['extendedPrice']?.toDouble(),
      extendedChange: json['extendedChange']?.toDouble(),
      extendedPriceTime: json['extendedPriceTime'] != null
          ? DateTime.parse(json['extendedPriceTime'])
          : null,
      previousClose: json['previousClose']?.toDouble(),
      previousVolume: json['previousVolume']?.toDouble(),
      change: json['change']?.toDouble(),
      changePercent: json['changePercent']?.toDouble(),
      peRatio: json['peRatio']?.toDouble(),
      marketCap: json['marketCap']?.toDouble(),
      week52High: json['week52High']?.toDouble(),
      week52Low: json['week52Low']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['open'] = open;
    data['openTime'] = openTime?.toString();
    data['close'] = close;
    data['closeTime'] = closeTime?.toString();
    data['high'] = high;
    data['low'] = low;
    data['latestPrice'] = latestPrice;
    data['latestSource'] = latestSource;
    data['latestTime'] = latestTime;
    data['latestVolume'] = latestVolume;
    data['volume'] = volume;
    data['realtimePrice'] = realtimePrice;
    data['realtimeSize'] = realtimeSize;
    data['lastUpdated'] = lastUpdated?.toString();
    data['delayedPrice'] = delayedPrice;
    data['extendedPrice'] = extendedPrice;
    data['extendedChange'] = extendedChange;
    data['extendedPriceTime'] = extendedPriceTime?.toString();
    data['previousClose'] = previousClose;
    data['previousVolume'] = previousVolume;
    data['change'] = change;
    data['changePercent'] = changePercent;
    data['peRatio'] = peRatio;
    data['marketCap'] = marketCap;
    data['week52High'] = week52High;
    data['week52Low'] = week52Low;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Quote &&
            (identical(other.open, open) ||
                const DeepCollectionEquality().equals(other.open, open)) &&
            (identical(other.openTime, openTime) ||
                const DeepCollectionEquality()
                    .equals(other.openTime, openTime)) &&
            (identical(other.close, close) ||
                const DeepCollectionEquality().equals(other.close, close)) &&
            (identical(other.closeTime, closeTime) ||
                const DeepCollectionEquality()
                    .equals(other.closeTime, closeTime)) &&
            (identical(other.high, high) ||
                const DeepCollectionEquality().equals(other.high, high)) &&
            (identical(other.low, low) ||
                const DeepCollectionEquality().equals(other.low, low)) &&
            (identical(other.latestPrice, latestPrice) ||
                const DeepCollectionEquality()
                    .equals(other.latestPrice, latestPrice)) &&
            (identical(other.latestSource, latestSource) ||
                const DeepCollectionEquality()
                    .equals(other.latestSource, latestSource)) &&
            (identical(other.latestTime, latestTime) ||
                const DeepCollectionEquality()
                    .equals(other.latestTime, latestTime)) &&
            (identical(other.latestVolume, latestVolume) ||
                const DeepCollectionEquality()
                    .equals(other.latestVolume, latestVolume)) &&
            (identical(other.volume, volume) ||
                const DeepCollectionEquality().equals(other.volume, volume)) &&
            (identical(other.realtimePrice, realtimePrice) ||
                const DeepCollectionEquality()
                    .equals(other.realtimePrice, realtimePrice)) &&
            (identical(other.realtimeSize, realtimeSize) ||
                const DeepCollectionEquality()
                    .equals(other.realtimeSize, realtimeSize)) &&
            (identical(other.lastUpdated, lastUpdated) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdated, lastUpdated)) &&
            (identical(other.delayedPrice, delayedPrice) ||
                const DeepCollectionEquality()
                    .equals(other.delayedPrice, delayedPrice)) &&
            (identical(other.extendedPrice, extendedPrice) ||
                const DeepCollectionEquality()
                    .equals(other.extendedPrice, extendedPrice)) &&
            (identical(other.extendedChange, extendedChange) ||
                const DeepCollectionEquality()
                    .equals(other.extendedChange, extendedChange)) &&
            (identical(other.extendedPriceTime, extendedPriceTime) ||
                const DeepCollectionEquality()
                    .equals(other.extendedPriceTime, extendedPriceTime)) &&
            (identical(other.previousClose, previousClose) ||
                const DeepCollectionEquality()
                    .equals(other.previousClose, previousClose)) &&
            (identical(other.previousVolume, previousVolume) ||
                const DeepCollectionEquality()
                    .equals(other.previousVolume, previousVolume)) &&
            (identical(other.change, change) ||
                const DeepCollectionEquality().equals(other.change, change)) &&
            (identical(other.changePercent, changePercent) ||
                const DeepCollectionEquality()
                    .equals(other.changePercent, changePercent)) &&
            (identical(other.peRatio, peRatio) ||
                const DeepCollectionEquality()
                    .equals(other.peRatio, peRatio)) &&
            (identical(other.marketCap, marketCap) ||
                const DeepCollectionEquality()
                    .equals(other.marketCap, marketCap)) &&
            (identical(other.week52High, week52High) ||
                const DeepCollectionEquality().equals(other.week52High, week52High)) &&
            (identical(other.week52Low, week52Low) || const DeepCollectionEquality().equals(other.week52Low, week52Low)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(open) ^
        const DeepCollectionEquality().hash(openTime) ^
        const DeepCollectionEquality().hash(close) ^
        const DeepCollectionEquality().hash(closeTime) ^
        const DeepCollectionEquality().hash(high) ^
        const DeepCollectionEquality().hash(low) ^
        const DeepCollectionEquality().hash(latestPrice) ^
        const DeepCollectionEquality().hash(latestSource) ^
        const DeepCollectionEquality().hash(latestTime) ^
        const DeepCollectionEquality().hash(latestVolume) ^
        const DeepCollectionEquality().hash(volume) ^
        const DeepCollectionEquality().hash(realtimePrice) ^
        const DeepCollectionEquality().hash(realtimeSize) ^
        const DeepCollectionEquality().hash(lastUpdated) ^
        const DeepCollectionEquality().hash(delayedPrice) ^
        const DeepCollectionEquality().hash(extendedPrice) ^
        const DeepCollectionEquality().hash(extendedChange) ^
        const DeepCollectionEquality().hash(extendedPriceTime) ^
        const DeepCollectionEquality().hash(previousClose) ^
        const DeepCollectionEquality().hash(previousVolume) ^
        const DeepCollectionEquality().hash(change) ^
        const DeepCollectionEquality().hash(changePercent) ^
        const DeepCollectionEquality().hash(peRatio) ^
        const DeepCollectionEquality().hash(marketCap) ^
        const DeepCollectionEquality().hash(week52High) ^
        const DeepCollectionEquality().hash(week52Low);
  }

  @override
  String toString() => 'Quote(${toJson()})';
}

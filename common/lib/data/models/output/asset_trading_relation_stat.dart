import 'package:collection/collection.dart';

class AssetTradingRelationStat {
  final double? percentUniqueTraded;
  final double? percentTraded;
  final int? totalUniqueTraded;
  final int? assetTotalUniqueTraded;
  final int? totalAssetTraded;
  final int? totalTraded;
  const AssetTradingRelationStat(
      {this.percentUniqueTraded,
      this.percentTraded,
      this.totalUniqueTraded,
      this.assetTotalUniqueTraded,
      this.totalAssetTraded,
      this.totalTraded});
  AssetTradingRelationStat copyWith(
      {double? percentUniqueTraded,
      double? percentTraded,
      int? totalUniqueTraded,
      int? assetTotalUniqueTraded,
      int? totalAssetTraded,
      int? totalTraded}) {
    return AssetTradingRelationStat(
      percentUniqueTraded: percentUniqueTraded ?? this.percentUniqueTraded,
      percentTraded: percentTraded ?? this.percentTraded,
      totalUniqueTraded: totalUniqueTraded ?? this.totalUniqueTraded,
      assetTotalUniqueTraded:
          assetTotalUniqueTraded ?? this.assetTotalUniqueTraded,
      totalAssetTraded: totalAssetTraded ?? this.totalAssetTraded,
      totalTraded: totalTraded ?? this.totalTraded,
    );
  }

  factory AssetTradingRelationStat.fromJson(Map<String, dynamic> json) {
    return AssetTradingRelationStat(
      percentUniqueTraded: json['percentUniqueTraded']?.toDouble(),
      percentTraded: json['percentTraded']?.toDouble(),
      totalUniqueTraded: json['totalUniqueTraded'],
      assetTotalUniqueTraded: json['assetTotalUniqueTraded'],
      totalAssetTraded: json['totalAssetTraded'],
      totalTraded: json['totalTraded'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['percentUniqueTraded'] = percentUniqueTraded;
    data['percentTraded'] = percentTraded;
    data['totalUniqueTraded'] = totalUniqueTraded;
    data['assetTotalUniqueTraded'] = assetTotalUniqueTraded;
    data['totalAssetTraded'] = totalAssetTraded;
    data['totalTraded'] = totalTraded;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssetTradingRelationStat &&
            (identical(other.percentUniqueTraded, percentUniqueTraded) ||
                const DeepCollectionEquality()
                    .equals(other.percentUniqueTraded, percentUniqueTraded)) &&
            (identical(other.percentTraded, percentTraded) ||
                const DeepCollectionEquality()
                    .equals(other.percentTraded, percentTraded)) &&
            (identical(other.totalUniqueTraded, totalUniqueTraded) ||
                const DeepCollectionEquality()
                    .equals(other.totalUniqueTraded, totalUniqueTraded)) &&
            (identical(other.assetTotalUniqueTraded, assetTotalUniqueTraded) ||
                const DeepCollectionEquality().equals(
                    other.assetTotalUniqueTraded, assetTotalUniqueTraded)) &&
            (identical(other.totalAssetTraded, totalAssetTraded) ||
                const DeepCollectionEquality()
                    .equals(other.totalAssetTraded, totalAssetTraded)) &&
            (identical(other.totalTraded, totalTraded) ||
                const DeepCollectionEquality()
                    .equals(other.totalTraded, totalTraded)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(percentUniqueTraded) ^
        const DeepCollectionEquality().hash(percentTraded) ^
        const DeepCollectionEquality().hash(totalUniqueTraded) ^
        const DeepCollectionEquality().hash(assetTotalUniqueTraded) ^
        const DeepCollectionEquality().hash(totalAssetTraded) ^
        const DeepCollectionEquality().hash(totalTraded);
  }

  @override
  String toString() => 'AssetTradingRelationStat(${toJson()})';
}

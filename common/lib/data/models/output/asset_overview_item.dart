import 'package:iris_common/data/models/output/asset.dart';
import 'package:collection/collection.dart';

class AssetOverviewItem {
  final Asset? asset;
  final int? assetKey;
  final double? bullishRatio;
  final double? bullishRatioTop;
  final int? nbrInvestorsTotal;
  final int? nbrInvestors;
  final int? nbrInvestorsBull;
  final int? nbrInvestorsBear;
  final int? nbrInvestorsDelta;
  final int? nbrInvestorsTotalTop;
  final int? nbrInvestorsTop;
  final int? nbrInvestorsBullTop;
  final int? nbrInvestorsBearTop;
  final int? nbrInvestorsDeltaTop;
  final double? amtInvested;
  final double? amtInvestedBear;
  final double? amtInvestedBull;
  final double? amtInvestedDelta;
  final double? amtInvestedTop;
  final double? amtInvestedBearTop;
  final double? amtInvestedBullTop;
  final double? amtInvestedDeltaTop;
  final double? pctInvestorsTotal;
  final double? pctInvestorsTotalBear;
  final double? pctInvestorsTotalBull;
  final double? pctInvestorsTotalDelta;
  final double? pctInvestorsTotalTop;
  final double? pctInvestorsTotalBearTop;
  final double? pctInvestorsTotalBullTop;
  final double? pctInvestorsTotalDeltaTop;
  final double? pctInvestorsBull;
  final double? pctInvestorsBullTop;
  final double? pctInvestorsBear;
  final double? pctInvestorsBearTop;
  final int? support;
  final int? supportTop;
  const AssetOverviewItem(
      {this.asset,
      this.assetKey,
      this.bullishRatio,
      this.bullishRatioTop,
      this.nbrInvestorsTotal,
      this.nbrInvestors,
      this.nbrInvestorsBull,
      this.nbrInvestorsBear,
      this.nbrInvestorsDelta,
      this.nbrInvestorsTotalTop,
      this.nbrInvestorsTop,
      this.nbrInvestorsBullTop,
      this.nbrInvestorsBearTop,
      this.nbrInvestorsDeltaTop,
      this.amtInvested,
      this.amtInvestedBear,
      this.amtInvestedBull,
      this.amtInvestedDelta,
      this.amtInvestedTop,
      this.amtInvestedBearTop,
      this.amtInvestedBullTop,
      this.amtInvestedDeltaTop,
      this.pctInvestorsTotal,
      this.pctInvestorsTotalBear,
      this.pctInvestorsTotalBull,
      this.pctInvestorsTotalDelta,
      this.pctInvestorsTotalTop,
      this.pctInvestorsTotalBearTop,
      this.pctInvestorsTotalBullTop,
      this.pctInvestorsTotalDeltaTop,
      this.pctInvestorsBull,
      this.pctInvestorsBullTop,
      this.pctInvestorsBear,
      this.pctInvestorsBearTop,
      this.support,
      this.supportTop});
  AssetOverviewItem copyWith(
      {Asset? asset,
      int? assetKey,
      double? bullishRatio,
      double? bullishRatioTop,
      int? nbrInvestorsTotal,
      int? nbrInvestors,
      int? nbrInvestorsBull,
      int? nbrInvestorsBear,
      int? nbrInvestorsDelta,
      int? nbrInvestorsTotalTop,
      int? nbrInvestorsTop,
      int? nbrInvestorsBullTop,
      int? nbrInvestorsBearTop,
      int? nbrInvestorsDeltaTop,
      double? amtInvested,
      double? amtInvestedBear,
      double? amtInvestedBull,
      double? amtInvestedDelta,
      double? amtInvestedTop,
      double? amtInvestedBearTop,
      double? amtInvestedBullTop,
      double? amtInvestedDeltaTop,
      double? pctInvestorsTotal,
      double? pctInvestorsTotalBear,
      double? pctInvestorsTotalBull,
      double? pctInvestorsTotalDelta,
      double? pctInvestorsTotalTop,
      double? pctInvestorsTotalBearTop,
      double? pctInvestorsTotalBullTop,
      double? pctInvestorsTotalDeltaTop,
      double? pctInvestorsBull,
      double? pctInvestorsBullTop,
      double? pctInvestorsBear,
      double? pctInvestorsBearTop,
      int? support,
      int? supportTop}) {
    return AssetOverviewItem(
      asset: asset ?? this.asset,
      assetKey: assetKey ?? this.assetKey,
      bullishRatio: bullishRatio ?? this.bullishRatio,
      bullishRatioTop: bullishRatioTop ?? this.bullishRatioTop,
      nbrInvestorsTotal: nbrInvestorsTotal ?? this.nbrInvestorsTotal,
      nbrInvestors: nbrInvestors ?? this.nbrInvestors,
      nbrInvestorsBull: nbrInvestorsBull ?? this.nbrInvestorsBull,
      nbrInvestorsBear: nbrInvestorsBear ?? this.nbrInvestorsBear,
      nbrInvestorsDelta: nbrInvestorsDelta ?? this.nbrInvestorsDelta,
      nbrInvestorsTotalTop: nbrInvestorsTotalTop ?? this.nbrInvestorsTotalTop,
      nbrInvestorsTop: nbrInvestorsTop ?? this.nbrInvestorsTop,
      nbrInvestorsBullTop: nbrInvestorsBullTop ?? this.nbrInvestorsBullTop,
      nbrInvestorsBearTop: nbrInvestorsBearTop ?? this.nbrInvestorsBearTop,
      nbrInvestorsDeltaTop: nbrInvestorsDeltaTop ?? this.nbrInvestorsDeltaTop,
      amtInvested: amtInvested ?? this.amtInvested,
      amtInvestedBear: amtInvestedBear ?? this.amtInvestedBear,
      amtInvestedBull: amtInvestedBull ?? this.amtInvestedBull,
      amtInvestedDelta: amtInvestedDelta ?? this.amtInvestedDelta,
      amtInvestedTop: amtInvestedTop ?? this.amtInvestedTop,
      amtInvestedBearTop: amtInvestedBearTop ?? this.amtInvestedBearTop,
      amtInvestedBullTop: amtInvestedBullTop ?? this.amtInvestedBullTop,
      amtInvestedDeltaTop: amtInvestedDeltaTop ?? this.amtInvestedDeltaTop,
      pctInvestorsTotal: pctInvestorsTotal ?? this.pctInvestorsTotal,
      pctInvestorsTotalBear:
          pctInvestorsTotalBear ?? this.pctInvestorsTotalBear,
      pctInvestorsTotalBull:
          pctInvestorsTotalBull ?? this.pctInvestorsTotalBull,
      pctInvestorsTotalDelta:
          pctInvestorsTotalDelta ?? this.pctInvestorsTotalDelta,
      pctInvestorsTotalTop: pctInvestorsTotalTop ?? this.pctInvestorsTotalTop,
      pctInvestorsTotalBearTop:
          pctInvestorsTotalBearTop ?? this.pctInvestorsTotalBearTop,
      pctInvestorsTotalBullTop:
          pctInvestorsTotalBullTop ?? this.pctInvestorsTotalBullTop,
      pctInvestorsTotalDeltaTop:
          pctInvestorsTotalDeltaTop ?? this.pctInvestorsTotalDeltaTop,
      pctInvestorsBull: pctInvestorsBull ?? this.pctInvestorsBull,
      pctInvestorsBullTop: pctInvestorsBullTop ?? this.pctInvestorsBullTop,
      pctInvestorsBear: pctInvestorsBear ?? this.pctInvestorsBear,
      pctInvestorsBearTop: pctInvestorsBearTop ?? this.pctInvestorsBearTop,
      support: support ?? this.support,
      supportTop: supportTop ?? this.supportTop,
    );
  }

  factory AssetOverviewItem.fromJson(Map<String, dynamic> json) {
    return AssetOverviewItem(
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      assetKey: json['assetKey'],
      bullishRatio: json['bullishRatio']?.toDouble(),
      bullishRatioTop: json['bullishRatioTop']?.toDouble(),
      nbrInvestorsTotal: json['nbrInvestorsTotal'],
      nbrInvestors: json['nbrInvestors'],
      nbrInvestorsBull: json['nbrInvestorsBull'],
      nbrInvestorsBear: json['nbrInvestorsBear'],
      nbrInvestorsDelta: json['nbrInvestorsDelta'],
      nbrInvestorsTotalTop: json['nbrInvestorsTotalTop'],
      nbrInvestorsTop: json['nbrInvestorsTop'],
      nbrInvestorsBullTop: json['nbrInvestorsBullTop'],
      nbrInvestorsBearTop: json['nbrInvestorsBearTop'],
      nbrInvestorsDeltaTop: json['nbrInvestorsDeltaTop'],
      amtInvested: json['amtInvested']?.toDouble(),
      amtInvestedBear: json['amtInvestedBear']?.toDouble(),
      amtInvestedBull: json['amtInvestedBull']?.toDouble(),
      amtInvestedDelta: json['amtInvestedDelta']?.toDouble(),
      amtInvestedTop: json['amtInvestedTop']?.toDouble(),
      amtInvestedBearTop: json['amtInvestedBearTop']?.toDouble(),
      amtInvestedBullTop: json['amtInvestedBullTop']?.toDouble(),
      amtInvestedDeltaTop: json['amtInvestedDeltaTop']?.toDouble(),
      pctInvestorsTotal: json['pctInvestorsTotal']?.toDouble(),
      pctInvestorsTotalBear: json['pctInvestorsTotalBear']?.toDouble(),
      pctInvestorsTotalBull: json['pctInvestorsTotalBull']?.toDouble(),
      pctInvestorsTotalDelta: json['pctInvestorsTotalDelta']?.toDouble(),
      pctInvestorsTotalTop: json['pctInvestorsTotalTop']?.toDouble(),
      pctInvestorsTotalBearTop: json['pctInvestorsTotalBearTop']?.toDouble(),
      pctInvestorsTotalBullTop: json['pctInvestorsTotalBullTop']?.toDouble(),
      pctInvestorsTotalDeltaTop: json['pctInvestorsTotalDeltaTop']?.toDouble(),
      pctInvestorsBull: json['pctInvestorsBull']?.toDouble(),
      pctInvestorsBullTop: json['pctInvestorsBullTop']?.toDouble(),
      pctInvestorsBear: json['pctInvestorsBear']?.toDouble(),
      pctInvestorsBearTop: json['pctInvestorsBearTop']?.toDouble(),
      support: json['support'],
      supportTop: json['supportTop'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['asset'] = asset?.toJson();
    data['assetKey'] = assetKey;
    data['bullishRatio'] = bullishRatio;
    data['bullishRatioTop'] = bullishRatioTop;
    data['nbrInvestorsTotal'] = nbrInvestorsTotal;
    data['nbrInvestors'] = nbrInvestors;
    data['nbrInvestorsBull'] = nbrInvestorsBull;
    data['nbrInvestorsBear'] = nbrInvestorsBear;
    data['nbrInvestorsDelta'] = nbrInvestorsDelta;
    data['nbrInvestorsTotalTop'] = nbrInvestorsTotalTop;
    data['nbrInvestorsTop'] = nbrInvestorsTop;
    data['nbrInvestorsBullTop'] = nbrInvestorsBullTop;
    data['nbrInvestorsBearTop'] = nbrInvestorsBearTop;
    data['nbrInvestorsDeltaTop'] = nbrInvestorsDeltaTop;
    data['amtInvested'] = amtInvested;
    data['amtInvestedBear'] = amtInvestedBear;
    data['amtInvestedBull'] = amtInvestedBull;
    data['amtInvestedDelta'] = amtInvestedDelta;
    data['amtInvestedTop'] = amtInvestedTop;
    data['amtInvestedBearTop'] = amtInvestedBearTop;
    data['amtInvestedBullTop'] = amtInvestedBullTop;
    data['amtInvestedDeltaTop'] = amtInvestedDeltaTop;
    data['pctInvestorsTotal'] = pctInvestorsTotal;
    data['pctInvestorsTotalBear'] = pctInvestorsTotalBear;
    data['pctInvestorsTotalBull'] = pctInvestorsTotalBull;
    data['pctInvestorsTotalDelta'] = pctInvestorsTotalDelta;
    data['pctInvestorsTotalTop'] = pctInvestorsTotalTop;
    data['pctInvestorsTotalBearTop'] = pctInvestorsTotalBearTop;
    data['pctInvestorsTotalBullTop'] = pctInvestorsTotalBullTop;
    data['pctInvestorsTotalDeltaTop'] = pctInvestorsTotalDeltaTop;
    data['pctInvestorsBull'] = pctInvestorsBull;
    data['pctInvestorsBullTop'] = pctInvestorsBullTop;
    data['pctInvestorsBear'] = pctInvestorsBear;
    data['pctInvestorsBearTop'] = pctInvestorsBearTop;
    data['support'] = support;
    data['supportTop'] = supportTop;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssetOverviewItem &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.bullishRatio, bullishRatio) ||
                const DeepCollectionEquality()
                    .equals(other.bullishRatio, bullishRatio)) &&
            (identical(other.bullishRatioTop, bullishRatioTop) ||
                const DeepCollectionEquality()
                    .equals(other.bullishRatioTop, bullishRatioTop)) &&
            (identical(other.nbrInvestorsTotal, nbrInvestorsTotal) ||
                const DeepCollectionEquality()
                    .equals(other.nbrInvestorsTotal, nbrInvestorsTotal)) &&
            (identical(other.nbrInvestors, nbrInvestors) ||
                const DeepCollectionEquality()
                    .equals(other.nbrInvestors, nbrInvestors)) &&
            (identical(other.nbrInvestorsBull, nbrInvestorsBull) ||
                const DeepCollectionEquality()
                    .equals(other.nbrInvestorsBull, nbrInvestorsBull)) &&
            (identical(other.nbrInvestorsBear, nbrInvestorsBear) ||
                const DeepCollectionEquality()
                    .equals(other.nbrInvestorsBear, nbrInvestorsBear)) &&
            (identical(other.nbrInvestorsDelta, nbrInvestorsDelta) ||
                const DeepCollectionEquality()
                    .equals(other.nbrInvestorsDelta, nbrInvestorsDelta)) &&
            (identical(other.nbrInvestorsTotalTop, nbrInvestorsTotalTop) ||
                const DeepCollectionEquality().equals(
                    other.nbrInvestorsTotalTop, nbrInvestorsTotalTop)) &&
            (identical(other.nbrInvestorsTop, nbrInvestorsTop) ||
                const DeepCollectionEquality()
                    .equals(other.nbrInvestorsTop, nbrInvestorsTop)) &&
            (identical(other.nbrInvestorsBullTop, nbrInvestorsBullTop) ||
                const DeepCollectionEquality()
                    .equals(other.nbrInvestorsBullTop, nbrInvestorsBullTop)) &&
            (identical(other.nbrInvestorsBearTop, nbrInvestorsBearTop) ||
                const DeepCollectionEquality()
                    .equals(other.nbrInvestorsBearTop, nbrInvestorsBearTop)) &&
            (identical(other.nbrInvestorsDeltaTop, nbrInvestorsDeltaTop) ||
                const DeepCollectionEquality().equals(
                    other.nbrInvestorsDeltaTop, nbrInvestorsDeltaTop)) &&
            (identical(other.amtInvested, amtInvested) ||
                const DeepCollectionEquality()
                    .equals(other.amtInvested, amtInvested)) &&
            (identical(other.amtInvestedBear, amtInvestedBear) ||
                const DeepCollectionEquality()
                    .equals(other.amtInvestedBear, amtInvestedBear)) &&
            (identical(other.amtInvestedBull, amtInvestedBull) ||
                const DeepCollectionEquality()
                    .equals(other.amtInvestedBull, amtInvestedBull)) &&
            (identical(other.amtInvestedDelta, amtInvestedDelta) ||
                const DeepCollectionEquality()
                    .equals(other.amtInvestedDelta, amtInvestedDelta)) &&
            (identical(other.amtInvestedTop, amtInvestedTop) ||
                const DeepCollectionEquality()
                    .equals(other.amtInvestedTop, amtInvestedTop)) &&
            (identical(other.amtInvestedBearTop, amtInvestedBearTop) ||
                const DeepCollectionEquality()
                    .equals(other.amtInvestedBearTop, amtInvestedBearTop)) &&
            (identical(other.amtInvestedBullTop, amtInvestedBullTop) ||
                const DeepCollectionEquality()
                    .equals(other.amtInvestedBullTop, amtInvestedBullTop)) &&
            (identical(other.amtInvestedDeltaTop, amtInvestedDeltaTop) ||
                const DeepCollectionEquality().equals(other.amtInvestedDeltaTop, amtInvestedDeltaTop)) &&
            (identical(other.pctInvestorsTotal, pctInvestorsTotal) || const DeepCollectionEquality().equals(other.pctInvestorsTotal, pctInvestorsTotal)) &&
            (identical(other.pctInvestorsTotalBear, pctInvestorsTotalBear) || const DeepCollectionEquality().equals(other.pctInvestorsTotalBear, pctInvestorsTotalBear)) &&
            (identical(other.pctInvestorsTotalBull, pctInvestorsTotalBull) || const DeepCollectionEquality().equals(other.pctInvestorsTotalBull, pctInvestorsTotalBull)) &&
            (identical(other.pctInvestorsTotalDelta, pctInvestorsTotalDelta) || const DeepCollectionEquality().equals(other.pctInvestorsTotalDelta, pctInvestorsTotalDelta)) &&
            (identical(other.pctInvestorsTotalTop, pctInvestorsTotalTop) || const DeepCollectionEquality().equals(other.pctInvestorsTotalTop, pctInvestorsTotalTop)) &&
            (identical(other.pctInvestorsTotalBearTop, pctInvestorsTotalBearTop) || const DeepCollectionEquality().equals(other.pctInvestorsTotalBearTop, pctInvestorsTotalBearTop)) &&
            (identical(other.pctInvestorsTotalBullTop, pctInvestorsTotalBullTop) || const DeepCollectionEquality().equals(other.pctInvestorsTotalBullTop, pctInvestorsTotalBullTop)) &&
            (identical(other.pctInvestorsTotalDeltaTop, pctInvestorsTotalDeltaTop) || const DeepCollectionEquality().equals(other.pctInvestorsTotalDeltaTop, pctInvestorsTotalDeltaTop)) &&
            (identical(other.pctInvestorsBull, pctInvestorsBull) || const DeepCollectionEquality().equals(other.pctInvestorsBull, pctInvestorsBull)) &&
            (identical(other.pctInvestorsBullTop, pctInvestorsBullTop) || const DeepCollectionEquality().equals(other.pctInvestorsBullTop, pctInvestorsBullTop)) &&
            (identical(other.pctInvestorsBear, pctInvestorsBear) || const DeepCollectionEquality().equals(other.pctInvestorsBear, pctInvestorsBear)) &&
            (identical(other.pctInvestorsBearTop, pctInvestorsBearTop) || const DeepCollectionEquality().equals(other.pctInvestorsBearTop, pctInvestorsBearTop)) &&
            (identical(other.support, support) || const DeepCollectionEquality().equals(other.support, support)) &&
            (identical(other.supportTop, supportTop) || const DeepCollectionEquality().equals(other.supportTop, supportTop)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(bullishRatio) ^
        const DeepCollectionEquality().hash(bullishRatioTop) ^
        const DeepCollectionEquality().hash(nbrInvestorsTotal) ^
        const DeepCollectionEquality().hash(nbrInvestors) ^
        const DeepCollectionEquality().hash(nbrInvestorsBull) ^
        const DeepCollectionEquality().hash(nbrInvestorsBear) ^
        const DeepCollectionEquality().hash(nbrInvestorsDelta) ^
        const DeepCollectionEquality().hash(nbrInvestorsTotalTop) ^
        const DeepCollectionEquality().hash(nbrInvestorsTop) ^
        const DeepCollectionEquality().hash(nbrInvestorsBullTop) ^
        const DeepCollectionEquality().hash(nbrInvestorsBearTop) ^
        const DeepCollectionEquality().hash(nbrInvestorsDeltaTop) ^
        const DeepCollectionEquality().hash(amtInvested) ^
        const DeepCollectionEquality().hash(amtInvestedBear) ^
        const DeepCollectionEquality().hash(amtInvestedBull) ^
        const DeepCollectionEquality().hash(amtInvestedDelta) ^
        const DeepCollectionEquality().hash(amtInvestedTop) ^
        const DeepCollectionEquality().hash(amtInvestedBearTop) ^
        const DeepCollectionEquality().hash(amtInvestedBullTop) ^
        const DeepCollectionEquality().hash(amtInvestedDeltaTop) ^
        const DeepCollectionEquality().hash(pctInvestorsTotal) ^
        const DeepCollectionEquality().hash(pctInvestorsTotalBear) ^
        const DeepCollectionEquality().hash(pctInvestorsTotalBull) ^
        const DeepCollectionEquality().hash(pctInvestorsTotalDelta) ^
        const DeepCollectionEquality().hash(pctInvestorsTotalTop) ^
        const DeepCollectionEquality().hash(pctInvestorsTotalBearTop) ^
        const DeepCollectionEquality().hash(pctInvestorsTotalBullTop) ^
        const DeepCollectionEquality().hash(pctInvestorsTotalDeltaTop) ^
        const DeepCollectionEquality().hash(pctInvestorsBull) ^
        const DeepCollectionEquality().hash(pctInvestorsBullTop) ^
        const DeepCollectionEquality().hash(pctInvestorsBear) ^
        const DeepCollectionEquality().hash(pctInvestorsBearTop) ^
        const DeepCollectionEquality().hash(support) ^
        const DeepCollectionEquality().hash(supportTop);
  }

  @override
  String toString() => 'AssetOverviewItem(${toJson()})';
}

import 'package:iris_common/data/models/enums/asset_type.dart';
import 'package:iris_common/data/models/output/asset_stat.dart';
import 'package:iris_common/data/models/output/historical.dart';
import 'package:iris_common/data/models/output/person.dart';
import 'package:iris_common/data/models/output/article.dart';
import 'package:iris_common/data/models/output/quote.dart';
import 'package:iris_common/data/models/output/order.dart';
import 'package:iris_common/data/models/output/asset_short_info.dart';
import 'package:iris_common/data/models/output/iris_asset_outlook.dart';
import 'package:iris_common/data/models/output/top_trader.dart';
import 'package:iris_common/data/models/output/stories_connection.dart';
import 'package:iris_common/data/models/output/asset_trading_relation_stat.dart';
import 'package:collection/collection.dart';

class Asset {
  final int? assetKey;
  final ASSET_TYPE? assetType;
  final String? symbol;
  final String? name;
  final String? companyUrl;
  final String? description;
  final String? pictureUrl;
  final DateTime? createdAt;
  final AssetStat? assetStat;
  final double? currentPrice;
  final Historical? historical;
  final DateTime? lastSyncedStockTwitsSentimentAt;
  final DateTime? lastSyncedInsiderInfo;
  final DateTime? lastSyncedOwnershipAt;
  final DateTime? lastSyncedArticlesAt;
  final DateTime? lastSyncedAdvancedStatsAt;
  final DateTime? lastSyncedBasicStatsAt;
  final DateTime? lastSyncedAssetInfoAt;
  final int? ceoPersonKey;
  final Person? ceo;
  final List<Article>? articles;
  final Quote? quote;
  final List<Order>? orders;
  final AssetShortInfo? shortInfo;
  final bool? authUserIsWatching;
  final IrisAssetOutlook? irisAssetOutlook;
  final List<TopTrader>? topTraders;
  final StoriesConnection? storiesConnection;
  final AssetTradingRelationStat? todaysTradingRelationStat;
  final Historical? dayHistorical;
  const Asset(
      {this.assetKey,
      this.assetType,
      this.symbol,
      this.name,
      this.companyUrl,
      this.description,
      this.pictureUrl,
      this.createdAt,
      this.assetStat,
      this.currentPrice,
      this.historical,
      this.lastSyncedStockTwitsSentimentAt,
      this.lastSyncedInsiderInfo,
      this.lastSyncedOwnershipAt,
      this.lastSyncedArticlesAt,
      this.lastSyncedAdvancedStatsAt,
      this.lastSyncedBasicStatsAt,
      this.lastSyncedAssetInfoAt,
      this.ceoPersonKey,
      this.ceo,
      this.articles,
      this.quote,
      this.orders,
      this.shortInfo,
      this.authUserIsWatching,
      this.irisAssetOutlook,
      this.topTraders,
      this.storiesConnection,
      this.todaysTradingRelationStat,
      this.dayHistorical});
  Asset copyWith(
      {int? assetKey,
      ASSET_TYPE? assetType,
      String? symbol,
      String? name,
      String? companyUrl,
      String? description,
      String? pictureUrl,
      DateTime? createdAt,
      AssetStat? assetStat,
      double? currentPrice,
      Historical? historical,
      DateTime? lastSyncedStockTwitsSentimentAt,
      DateTime? lastSyncedInsiderInfo,
      DateTime? lastSyncedOwnershipAt,
      DateTime? lastSyncedArticlesAt,
      DateTime? lastSyncedAdvancedStatsAt,
      DateTime? lastSyncedBasicStatsAt,
      DateTime? lastSyncedAssetInfoAt,
      int? ceoPersonKey,
      Person? ceo,
      List<Article>? articles,
      Quote? quote,
      List<Order>? orders,
      AssetShortInfo? shortInfo,
      bool? authUserIsWatching,
      IrisAssetOutlook? irisAssetOutlook,
      List<TopTrader>? topTraders,
      StoriesConnection? storiesConnection,
      AssetTradingRelationStat? todaysTradingRelationStat,
      Historical? dayHistorical}) {
    return Asset(
      assetKey: assetKey ?? this.assetKey,
      assetType: assetType ?? this.assetType,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      companyUrl: companyUrl ?? this.companyUrl,
      description: description ?? this.description,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      createdAt: createdAt ?? this.createdAt,
      assetStat: assetStat ?? this.assetStat,
      currentPrice: currentPrice ?? this.currentPrice,
      historical: historical ?? this.historical,
      lastSyncedStockTwitsSentimentAt: lastSyncedStockTwitsSentimentAt ??
          this.lastSyncedStockTwitsSentimentAt,
      lastSyncedInsiderInfo:
          lastSyncedInsiderInfo ?? this.lastSyncedInsiderInfo,
      lastSyncedOwnershipAt:
          lastSyncedOwnershipAt ?? this.lastSyncedOwnershipAt,
      lastSyncedArticlesAt: lastSyncedArticlesAt ?? this.lastSyncedArticlesAt,
      lastSyncedAdvancedStatsAt:
          lastSyncedAdvancedStatsAt ?? this.lastSyncedAdvancedStatsAt,
      lastSyncedBasicStatsAt:
          lastSyncedBasicStatsAt ?? this.lastSyncedBasicStatsAt,
      lastSyncedAssetInfoAt:
          lastSyncedAssetInfoAt ?? this.lastSyncedAssetInfoAt,
      ceoPersonKey: ceoPersonKey ?? this.ceoPersonKey,
      ceo: ceo ?? this.ceo,
      articles: articles ?? this.articles,
      quote: quote ?? this.quote,
      orders: orders ?? this.orders,
      shortInfo: shortInfo ?? this.shortInfo,
      authUserIsWatching: authUserIsWatching ?? this.authUserIsWatching,
      irisAssetOutlook: irisAssetOutlook ?? this.irisAssetOutlook,
      topTraders: topTraders ?? this.topTraders,
      storiesConnection: storiesConnection ?? this.storiesConnection,
      todaysTradingRelationStat:
          todaysTradingRelationStat ?? this.todaysTradingRelationStat,
      dayHistorical: dayHistorical ?? this.dayHistorical,
    );
  }

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      assetKey: json['assetKey'],
      assetType: json['assetType'] != null
          ? ASSET_TYPE.values.byName(json['assetType'])
          : null,
      symbol: json['symbol'],
      name: json['name'],
      companyUrl: json['companyUrl'],
      description: json['description'],
      pictureUrl: json['pictureUrl'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      assetStat: json['assetStat'] != null
          ? AssetStat.fromJson(json['assetStat'])
          : null,
      currentPrice: json['currentPrice']?.toDouble(),
      historical: json['historical'] != null
          ? Historical.fromJson(json['historical'])
          : null,
      lastSyncedStockTwitsSentimentAt:
          json['lastSyncedStockTwitsSentimentAt'] != null
              ? DateTime.parse(json['lastSyncedStockTwitsSentimentAt'])
              : null,
      lastSyncedInsiderInfo: json['lastSyncedInsiderInfo'] != null
          ? DateTime.parse(json['lastSyncedInsiderInfo'])
          : null,
      lastSyncedOwnershipAt: json['lastSyncedOwnershipAt'] != null
          ? DateTime.parse(json['lastSyncedOwnershipAt'])
          : null,
      lastSyncedArticlesAt: json['lastSyncedArticlesAt'] != null
          ? DateTime.parse(json['lastSyncedArticlesAt'])
          : null,
      lastSyncedAdvancedStatsAt: json['lastSyncedAdvancedStatsAt'] != null
          ? DateTime.parse(json['lastSyncedAdvancedStatsAt'])
          : null,
      lastSyncedBasicStatsAt: json['lastSyncedBasicStatsAt'] != null
          ? DateTime.parse(json['lastSyncedBasicStatsAt'])
          : null,
      lastSyncedAssetInfoAt: json['lastSyncedAssetInfoAt'] != null
          ? DateTime.parse(json['lastSyncedAssetInfoAt'])
          : null,
      ceoPersonKey: json['ceoPersonKey'],
      ceo: json['ceo'] != null ? Person.fromJson(json['ceo']) : null,
      articles:
          json['articles']?.map<Article>((o) => Article.fromJson(o)).toList(),
      quote: json['quote'] != null ? Quote.fromJson(json['quote']) : null,
      orders: json['orders']?.map<Order>((o) => Order.fromJson(o)).toList(),
      shortInfo: json['shortInfo'] != null
          ? AssetShortInfo.fromJson(json['shortInfo'])
          : null,
      authUserIsWatching: json['authUserIsWatching'],
      irisAssetOutlook: json['irisAssetOutlook'] != null
          ? IrisAssetOutlook.fromJson(json['irisAssetOutlook'])
          : null,
      topTraders: json['topTraders']
          ?.map<TopTrader>((o) => TopTrader.fromJson(o))
          .toList(),
      storiesConnection: json['storiesConnection'] != null
          ? StoriesConnection.fromJson(json['storiesConnection'])
          : null,
      todaysTradingRelationStat: json['todaysTradingRelationStat'] != null
          ? AssetTradingRelationStat.fromJson(json['todaysTradingRelationStat'])
          : null,
      dayHistorical: json['dayHistorical'] != null
          ? Historical.fromJson(json['dayHistorical'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['assetKey'] = assetKey;
    data['assetType'] = assetType?.name;
    data['symbol'] = symbol;
    data['name'] = name;
    data['companyUrl'] = companyUrl;
    data['description'] = description;
    data['pictureUrl'] = pictureUrl;
    data['createdAt'] = createdAt?.toString();
    data['assetStat'] = assetStat?.toJson();
    data['currentPrice'] = currentPrice;
    data['historical'] = historical?.toJson();
    data['lastSyncedStockTwitsSentimentAt'] =
        lastSyncedStockTwitsSentimentAt?.toString();
    data['lastSyncedInsiderInfo'] = lastSyncedInsiderInfo?.toString();
    data['lastSyncedOwnershipAt'] = lastSyncedOwnershipAt?.toString();
    data['lastSyncedArticlesAt'] = lastSyncedArticlesAt?.toString();
    data['lastSyncedAdvancedStatsAt'] = lastSyncedAdvancedStatsAt?.toString();
    data['lastSyncedBasicStatsAt'] = lastSyncedBasicStatsAt?.toString();
    data['lastSyncedAssetInfoAt'] = lastSyncedAssetInfoAt?.toString();
    data['ceoPersonKey'] = ceoPersonKey;
    data['ceo'] = ceo?.toJson();
    data['articles'] = articles?.map((item) => item.toJson()).toList();
    data['quote'] = quote?.toJson();
    data['orders'] = orders?.map((item) => item.toJson()).toList();
    data['shortInfo'] = shortInfo?.toJson();
    data['authUserIsWatching'] = authUserIsWatching;
    data['irisAssetOutlook'] = irisAssetOutlook?.toJson();
    data['topTraders'] = topTraders?.map((item) => item.toJson()).toList();
    data['storiesConnection'] = storiesConnection?.toJson();
    data['todaysTradingRelationStat'] = todaysTradingRelationStat?.toJson();
    data['dayHistorical'] = dayHistorical?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Asset &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.assetType, assetType) ||
                const DeepCollectionEquality()
                    .equals(other.assetType, assetType)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.companyUrl, companyUrl) ||
                const DeepCollectionEquality()
                    .equals(other.companyUrl, companyUrl)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.pictureUrl, pictureUrl) ||
                const DeepCollectionEquality()
                    .equals(other.pictureUrl, pictureUrl)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.assetStat, assetStat) ||
                const DeepCollectionEquality()
                    .equals(other.assetStat, assetStat)) &&
            (identical(other.currentPrice, currentPrice) ||
                const DeepCollectionEquality()
                    .equals(other.currentPrice, currentPrice)) &&
            (identical(other.historical, historical) ||
                const DeepCollectionEquality()
                    .equals(other.historical, historical)) &&
            (identical(other.lastSyncedStockTwitsSentimentAt, lastSyncedStockTwitsSentimentAt) ||
                const DeepCollectionEquality().equals(
                    other.lastSyncedStockTwitsSentimentAt,
                    lastSyncedStockTwitsSentimentAt)) &&
            (identical(other.lastSyncedInsiderInfo, lastSyncedInsiderInfo) ||
                const DeepCollectionEquality().equals(
                    other.lastSyncedInsiderInfo, lastSyncedInsiderInfo)) &&
            (identical(other.lastSyncedOwnershipAt, lastSyncedOwnershipAt) ||
                const DeepCollectionEquality().equals(
                    other.lastSyncedOwnershipAt, lastSyncedOwnershipAt)) &&
            (identical(other.lastSyncedArticlesAt, lastSyncedArticlesAt) ||
                const DeepCollectionEquality().equals(
                    other.lastSyncedArticlesAt, lastSyncedArticlesAt)) &&
            (identical(other.lastSyncedAdvancedStatsAt, lastSyncedAdvancedStatsAt) ||
                const DeepCollectionEquality().equals(
                    other.lastSyncedAdvancedStatsAt,
                    lastSyncedAdvancedStatsAt)) &&
            (identical(other.lastSyncedBasicStatsAt, lastSyncedBasicStatsAt) ||
                const DeepCollectionEquality().equals(
                    other.lastSyncedBasicStatsAt, lastSyncedBasicStatsAt)) &&
            (identical(other.lastSyncedAssetInfoAt, lastSyncedAssetInfoAt) ||
                const DeepCollectionEquality().equals(
                    other.lastSyncedAssetInfoAt, lastSyncedAssetInfoAt)) &&
            (identical(other.ceoPersonKey, ceoPersonKey) ||
                const DeepCollectionEquality().equals(other.ceoPersonKey, ceoPersonKey)) &&
            (identical(other.ceo, ceo) || const DeepCollectionEquality().equals(other.ceo, ceo)) &&
            (identical(other.articles, articles) || const DeepCollectionEquality().equals(other.articles, articles)) &&
            (identical(other.quote, quote) || const DeepCollectionEquality().equals(other.quote, quote)) &&
            (identical(other.orders, orders) || const DeepCollectionEquality().equals(other.orders, orders)) &&
            (identical(other.shortInfo, shortInfo) || const DeepCollectionEquality().equals(other.shortInfo, shortInfo)) &&
            (identical(other.authUserIsWatching, authUserIsWatching) || const DeepCollectionEquality().equals(other.authUserIsWatching, authUserIsWatching)) &&
            (identical(other.irisAssetOutlook, irisAssetOutlook) || const DeepCollectionEquality().equals(other.irisAssetOutlook, irisAssetOutlook)) &&
            (identical(other.topTraders, topTraders) || const DeepCollectionEquality().equals(other.topTraders, topTraders)) &&
            (identical(other.storiesConnection, storiesConnection) || const DeepCollectionEquality().equals(other.storiesConnection, storiesConnection)) &&
            (identical(other.todaysTradingRelationStat, todaysTradingRelationStat) || const DeepCollectionEquality().equals(other.todaysTradingRelationStat, todaysTradingRelationStat)) &&
            (identical(other.dayHistorical, dayHistorical) || const DeepCollectionEquality().equals(other.dayHistorical, dayHistorical)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(assetType) ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(companyUrl) ^
        const DeepCollectionEquality().hash(description) ^
        const DeepCollectionEquality().hash(pictureUrl) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(assetStat) ^
        const DeepCollectionEquality().hash(currentPrice) ^
        const DeepCollectionEquality().hash(historical) ^
        const DeepCollectionEquality().hash(lastSyncedStockTwitsSentimentAt) ^
        const DeepCollectionEquality().hash(lastSyncedInsiderInfo) ^
        const DeepCollectionEquality().hash(lastSyncedOwnershipAt) ^
        const DeepCollectionEquality().hash(lastSyncedArticlesAt) ^
        const DeepCollectionEquality().hash(lastSyncedAdvancedStatsAt) ^
        const DeepCollectionEquality().hash(lastSyncedBasicStatsAt) ^
        const DeepCollectionEquality().hash(lastSyncedAssetInfoAt) ^
        const DeepCollectionEquality().hash(ceoPersonKey) ^
        const DeepCollectionEquality().hash(ceo) ^
        const DeepCollectionEquality().hash(articles) ^
        const DeepCollectionEquality().hash(quote) ^
        const DeepCollectionEquality().hash(orders) ^
        const DeepCollectionEquality().hash(shortInfo) ^
        const DeepCollectionEquality().hash(authUserIsWatching) ^
        const DeepCollectionEquality().hash(irisAssetOutlook) ^
        const DeepCollectionEquality().hash(topTraders) ^
        const DeepCollectionEquality().hash(storiesConnection) ^
        const DeepCollectionEquality().hash(todaysTradingRelationStat) ^
        const DeepCollectionEquality().hash(dayHistorical);
  }

  @override
  String toString() => 'Asset(${toJson()})';
}

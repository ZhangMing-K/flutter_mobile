import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../../iris_common.dart';
// import 'package:iris_mobile/app/shared/types/index.dart';

class AnalyticsPopularRepository implements IAnalyticsPopularRepository {
  final IGraphqlProvider remoteProvider;

  final BaseRepository repository;
  AnalyticsPopularRepository({
    required this.remoteProvider,
    required this.repository,
  });

  @override
  Future<void> getTradeOverview({
    OVERVIEW_ORDER_BY? orderBy = OVERVIEW_ORDER_BY.ALL,
    SENTIMENT_TYPE? sentimentType = SENTIMENT_TYPE.BULLISH,
    int? limit,
    int? offset,
    OverviewBetweenInput? between,
    String? betweenString = 'Today', // to differentiate id
    QueryType queryType = QueryType.loadCache,
    required Function(AnalyticsPopularData<AssetOverviewItem> data) callback,
    required Function(OperationException error) onError,
  }) async {
    const document = '''
      query tradeOverview(\$input: TradeOverviewInput!){
        tradeOverview(input: \$input) {
          items{
            asset{
              assetKey
              symbol
              pictureUrl
              name
            }

            pctInvestorsTotalBull
            pctInvestorsTotalBear
            pctInvestorsTotalBullTop
            pctInvestorsTotalBearTop
            
            pctInvestorsBull
            pctInvestorsBullTop
            pctInvestorsBear
            pctInvestorsBearTop
            
            amtInvestedBull
            amtInvestedBear
            amtInvestedBullTop
            amtInvestedBearTop
          }
        }
      }
    ''';

    final inputVars = {
      'input': {
        'orderBy': describeEnum(orderBy!),
        'sentimentType': describeEnum(sentimentType!),
        'between': between == null
            ? null
            : {
                'start': between.start.toString(),
                'end': between.end?.toString()
              },
        'limit': limit,
        'offset': offset
      },
    };
    return repository.query(
      type: sentimentType == SENTIMENT_TYPE.BEARISH
          ? CacheType.bearishTradeOverview
          : CacheType.bullishTradeOverview,
      id: sentimentType == SENTIMENT_TYPE.BEARISH
          ? 'bearishTradeOverview' +
              describeEnum(orderBy) +
              between!.start.toString() +
              between.end.toString()
          : 'bullishTradeOverview' +
              describeEnum(orderBy) +
              between!.start.toString() +
              between.end.toString(),
      document: document,
      variables: inputVars,
      queryType: queryType,
      callback: (data) {
        final AnalyticsPopularFilterFields filterFields =
            AnalyticsPopularFilterFields(
                sentimentType: sentimentType,
                orderBy: orderBy,
                between: between);
        if (data == null) {
          return callback(AnalyticsPopularData(
              list: <AssetOverviewItem>[], filterFields: filterFields));
        }

        final response = TradeOverviewReturn.fromJson(data['tradeOverview']);

        final analyticsItemsData = response.items;

        callback(AnalyticsPopularData(
            list: analyticsItemsData, filterFields: filterFields));
      },
      onError: onError,
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../../iris_common.dart';

class AnalyticsOrderFlowRepository implements IAnalyticsOrderFlowRepository {
  final IGraphqlProvider remoteProvider;

  final BaseRepository repository;
  AnalyticsOrderFlowRepository({
    required this.remoteProvider,
    required this.repository,
  });

  @override
  Future<void> getOrderFlows({
    List<int>? assetKeys,
    bool? onlyTopTraders = false,
    double? minPortfolioAllocation = 0.01,
    double? minCost = 100,
    int? limit = 20,
    String? cursor = '',
    POSITION_TYPE? positionType = POSITION_TYPE.EQUITY,
    QueryType queryType = QueryType.loadCache,
    required Function(AnalyticsOrderFlowData<OrderFlow> data) callback,
    required Function(OperationException error) onError,
  }) async {
    var document = '''
      query orderFlowGet(\$input: OrderFlowInput!){
        orderFlowGet(input: \$input) {
          orderFlows{
            order{
              asset {
                currentPrice
                assetKey
              }
              orderKey
              fullfilledAt
              symbol
              portfolioAllocation
              positionType
              orderSide
              positionEffect
              positionType
              profitLoss
              profitLossPercent
              sentimentType
              optionType
              expirationDate
              strikePrice
              averageBuyPrice
              averagePrice
            }
            isTopTrader
            percentile
            tradeAccuracy
            transactionAmount
          }
          nextCursor
        }
      }
    ''';
    final inputVars = {
      'input': {
        'assetKeys': assetKeys,
        'limit': limit,
        'minPortfolioAllocation': minPortfolioAllocation,
        'onlyTopTraders': onlyTopTraders,
        'minCost': minCost,
        'positionType':
            positionType != null ? describeEnum(positionType) : null,
      },
    };
    if (cursor != '') {
      inputVars['input']!['cursor'] = cursor;
    }
    return repository.query(
      type: CacheType.analtycisOrderFlows,
      id: CacheType.analtycisOrderFlows +
          describeEnum(positionType!) +
          onlyTopTraders.toString() +
          minPortfolioAllocation.toString() +
          minCost.toString() +
          assetKeys.toString(),
      document: document,
      variables: inputVars,
      queryType: queryType,
      callback: (data) {
        final AnalyticsOrderFlowFilterFields filterFields =
            AnalyticsOrderFlowFilterFields(
                positionType: positionType,
                onlyTopTraders: onlyTopTraders!,
                minPortfolioAllocation: minPortfolioAllocation!,
                minCost: minCost!,
                assetKeys: assetKeys!);
        if (data == null || data['orderFlowGet'] == null) {
          return callback(AnalyticsOrderFlowData(
              list: <OrderFlow>[], cursor: '', filterFields: filterFields));
        }
        final cursor = data['orderFlowGet']['nextCursor'] ?? '';
        final List<OrderFlow> orderFlowList = List<OrderFlow>.from(
            data['orderFlowGet']['orderFlows']
                .map((i) => OrderFlow.fromJson(i)));
        callback(AnalyticsOrderFlowData(
            list: orderFlowList, cursor: cursor, filterFields: filterFields));
      },
      onError: onError,
    );
  }
}

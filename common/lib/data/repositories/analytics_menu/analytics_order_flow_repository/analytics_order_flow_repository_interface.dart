import 'package:graphql/client.dart';

import '../../../../iris_common.dart';

abstract class IAnalyticsOrderFlowRepository {
  Future<void> getOrderFlows({
    List<int>? assetKeys,
    bool? onlyTopTraders,
    double? minPortfolioAllocation,
    double? minCost,
    int? limit,
    String? cursor,
    POSITION_TYPE? positionType = POSITION_TYPE.EQUITY,
    QueryType queryType = QueryType.loadCache,
    required Function(AnalyticsOrderFlowData<OrderFlow> data) callback,
    required Function(OperationException error) onError,
  });
}

class AnalyticsOrderFlowData<T> {
  final List<T> list;
  final String cursor;
  final AnalyticsOrderFlowFilterFields filterFields;
  const AnalyticsOrderFlowData(
      {required this.list, required this.cursor, required this.filterFields});
}

class AnalyticsOrderFlowFilterFields {
  final POSITION_TYPE positionType;
  final bool onlyTopTraders;
  final double minPortfolioAllocation;
  final double minCost;
  final List<int> assetKeys;
  const AnalyticsOrderFlowFilterFields(
      {required this.positionType,
      required this.onlyTopTraders,
      required this.minPortfolioAllocation,
      required this.minCost,
      required this.assetKeys});
}

import 'package:graphql/client.dart';

import '../../../../iris_common.dart';

abstract class IAnalyticsPopularRepository {
  Future<void> getTradeOverview({
    OVERVIEW_ORDER_BY? orderBy,
    SENTIMENT_TYPE? sentimentType,
    int? limit,
    int? offset,
    OverviewBetweenInput? between,
    String? betweenString, // to differentiate id
    QueryType queryType = QueryType.loadCache,
    required Function(AnalyticsPopularData<AssetOverviewItem> data) callback,
    required Function(OperationException error) onError,
  });
}

class AnalyticsPopularData<T> {
  final List<AssetOverviewItem>? list;
  final AnalyticsPopularFilterFields filterFields;
  const AnalyticsPopularData({required this.list, required this.filterFields});
}

class AnalyticsPopularFilterFields {
  final SENTIMENT_TYPE sentimentType;
  final OVERVIEW_ORDER_BY orderBy;
  final OverviewBetweenInput between;
  const AnalyticsPopularFilterFields({
    required this.sentimentType,
    required this.orderBy,
    required this.between,
  });
}

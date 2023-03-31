import 'package:graphql/client.dart';

import '../../../iris_common.dart';

abstract class ILeaderboardRepository {
  Future<void> getGlobalLeaderboard({
    bool? mostRecent,
    int? limit,
    HISTORICAL_SPAN? span,
    QueryType queryType = QueryType.loadCache,
    required Function(bool isLocal, HISTORICAL_SPAN span, dynamic data)
        callback,
    required Function(OperationException error) onError,
  });

  Future<void> getPortfolios({
    int? offset,
    HISTORICAL_SPAN? orderBy,
    QueryType queryType = QueryType.loadCache,
    required Function(bool isLocal, HISTORICAL_SPAN span, dynamic data)
        callback,
    required Function(OperationException error) onError,
  });
}

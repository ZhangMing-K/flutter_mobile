import 'package:graphql/client.dart';

import '../../../iris_common.dart';

abstract class ISearchRepository {
  assetToWatchlist({required int assetKey, required bool watch});

  Future<void> followSuggestions({
    required FOLLOW_SUGGESTION_TYPE suggestionType,
    String cursor = '',
    QueryType queryType = QueryType.loadCache,
    required Function(List<User> data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> discoverPageGet({
    required DiscoverPageGetInput input,
    QueryType queryType = QueryType.loadCache,
    required Function(DiscoverPageGetResponse data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> loadAssets({
    String? partialSymbol,
    String? searchValue,
    int limit = 10,
    int? offset,
    List<int>? assetKeys,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> loadUsers({
    String? name,
    int limit = 10,
    int? offset,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> relevantUsersSearch({
    String? searchText = '',
    int limit = 10,
    int? offset = 0,
    bool? excludeAuthUser = true,
    List<int>? excludeUserKeys,
    CONTEXT_TYPE? contextType = CONTEXT_TYPE.FOLLOWING,
    int? contextKey,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> searchAssets({
    String? searchValue = '',
    int limit = 10,
    int? offset = 10,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> topInvestorsSuggestions({
    QueryType queryType = QueryType.loadCache,
    required Function(List<TopTraderData<User>> data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> topPerformersSuggestions({
    QueryType queryType = QueryType.loadCache,
    required Function(List<LeaderboardInstance> data) callback,
    required Function(OperationException error) onError,
  });
}

import '../../../iris_common.dart';

abstract class IProfileSearchRepository {
  Repository<List<User>> searchFollowers({
    required String? name,
    required int? offset,
    required int? entityKey,
    SEARCH_QUERY? entityType = SEARCH_QUERY.USER,
    SEARCH_QUERY? searchFollowing = SEARCH_QUERY.FOLLOWERS,
  });

  Repository<List<User>> searchFollowing({
    required String? name,
    required int? offset,
    required int? entityKey,
    SEARCH_QUERY? entityType = SEARCH_QUERY.USER,
    SEARCH_QUERY? searchFollowing = SEARCH_QUERY.FOLLOWING,
  });

  Repository<List<Portfolio>> searchPortfoliosFollowing({
    required String? name,
    required int? offset,
    required int? entityKey,
    SEARCH_QUERY? entityType = SEARCH_QUERY.USER,
    SEARCH_QUERY? searchFollowing = SEARCH_QUERY.PORTFOLIOS_FOLLOWING,
  });
}

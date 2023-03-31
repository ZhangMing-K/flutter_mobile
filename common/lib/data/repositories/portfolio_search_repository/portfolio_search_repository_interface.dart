import '../../../iris_common.dart';

abstract class IPortfolioSearchRepository {
  Repository<List<User>> loadUsers(
      {String? name,
      int limit = 10,
      int? offset,
      required int entityKey,
      required SEARCH_QUERY entityType,
      required SEARCH_QUERY searchFollowing});
}

import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;
import 'package:iris_common/iris_common.dart';

enum PUBLIC_FEED_CATEGORY { INVESTORS, TRENDING, TOP_TRADES, ORDER_FLOW }

class FeedTimeSpan {
  DateTime start;
  DateTime? end;
  FeedTimeSpan({required this.start, this.end});
}

abstract class IFeedRepository {
  Future<void> advancedFeedGet({
    List<TEXT_TYPE>? textTypes,
    String? requestedFields,
    int limit = 10,
    bool? featured = false,
    FEED_CATEGORY feedCategory = FEED_CATEGORY.ALL,
    int? offset,
    String? cursor,
    bool saved = true,
    FEED_ORDER_BY_TYPE? feedOrderBy,
    BetweenInput? timeSpan,
    QueryType queryType = QueryType.loadCache,
    required Function(FEED_CATEGORY category, AdvancedFeedGetResponse data)
        callback,
    required Function(OperationException error) onError,
  });

  Future<void> followingFeedGet({
    required FollowerFeedInput input,
    QueryType queryType = QueryType.loadCache,
    required Function(FeedItemReturn data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> trendingFeed({
    int limit = 10,
    String? cursor = '',
    QueryType queryType = QueryType.loadCache,
    required Function(PUBLIC_FEED_CATEGORY category, DataList<TextModel> data)
        callback,
    required Function(OperationException error) onError,
  });

  Future<void> topTradesFeed({
    int limit = 10,
    String? cursor = '',
    QueryType queryType = QueryType.loadCache,
    required Function(PUBLIC_FEED_CATEGORY category, DataList<TextModel> data)
        callback,
    required Function(OperationException error) onError,
  });

  Future<void> getFullPage({
    List<TEXT_TYPE>? textTypes,
    int? accountUserKey,
    int? portfolioKey,
    required int textKey,
    int? offset,
    QueryType queryType = QueryType.loadCache,
    required Function(List<TextModel> data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> getComments(
    CommentsGetInput input, {
    QueryType queryType = QueryType.loadRemote,
    required Function(CommentsGetResponse data) callback,
    required Function(OperationException error) onError,
  });

  Repository<List<Portfolio>> getPortfolios({
    int? offset,
    bool? saved,
    PORTFOLIO_ORDER_BY? orderBy,
  });

  Repository<DataList<TextModel>> textsGet({
    List<int?>? textKeys,
    List<int?>? orderKeys,
    List<int?>? assetKeys,
    List<String?>? orderGroupUUIDS,
    String? requestedFields,
    int? limit,
    String? cursor,
  });

  /// Mainly to be used when searching by "orderGroupUUID"
  Repository<DataList<Order>> ordersGet({
    List<int?>? orderKeys,
    List<String?>? orderGroupUUIDS,
    String? requestedFields,
    bool? withText,
    int? limit,
    String? cursor,
  });

  Future<void> setOnlineStatus();

  Future<TextModel> postCreate({
    required TEXT_TYPE? textType,
    String? value,
    int? parentKey,
    Giff? giff,
    List<http.MultipartFile>? fileUploads,
    int? collectionKey,
  });

  Future<TextModel> textEdit({
    int? textKey,
    String? value,
    Giff? giff,
    List<http.MultipartFile>? fileUploads,
    int? entityKey,
    APP_MEDIA_TYPE? entityType,
    int? collectionKey,
  });

  Future<User?> getAuthUser({required String requestedFields});

  Future userRelationsUpdate(
      {required USER_RELATION_ENTITY_TYPE entityType,
      required List<int?> entityKeys,
      bool? mute,
      bool? watch,
      bool? block,
      bool? hide,
      bool? seen,
      bool? save,
      USER_RELATION_NOTIFICATION_AMOUNT? notificationAmount,
      RELATION_LOCATION? relationLocation});

  Future<TextModel?> textDelete({int? textKey});

  Future<void> getUserSavedTexts({
    int? userKey,
    int offset = 0,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  });
}

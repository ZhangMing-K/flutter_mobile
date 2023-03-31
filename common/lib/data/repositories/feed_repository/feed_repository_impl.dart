import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;

import '../../../iris_common.dart';

class FeedRepository implements IFeedRepository {
  final IGraphqlProvider remoteProvider;
  final BaseRepository repository;

  FeedRepository({
    required this.remoteProvider,
    required this.repository,
  });

  @override
  Future<void> followingFeedGet({
    required FollowerFeedInput input,
    QueryType queryType = QueryType.loadCache,
    required Function(FeedItemReturn data) callback,
    required Function(OperationException error) onError,
  }) {
    const requestedFields = TextGql.feed;
    const document = '''
      query followingFeedGet(\$input: FollowerFeedInput){
        followingFeedGet(input:\$input) {
          nextCursor
          items {
            text{
              $requestedFields
            }
            symbol
            followSuggestion{
              carouselTitle
              userCards{
                subtitle
                user {
                  userKey
                  profilePictureUrl
                  firstName
                  lastName
                  username
                  description
                  email
                  verifiedAt
                  temporarySnapshotHistoricalPoints {
                    dayPercent
                    weekPercent
                    monthPercent
                    threeMonthPercent
                    yearPercent
                    allPercent
                  }
                  dailyPercentGain
                  badgeType
                  followStats{
                    numberOfFollowers
                  }
                }
              }
            }
          }
        }
      }
    ''';

    final variables = {
      'input': input.toJson(),
    };

    final id = input.cursor ?? '';

    return repository.query(
      type: CacheType.feed,
      id: id,
      document: document,
      variables: variables,
      callback: (data) {
        final feed = FeedItemReturn.fromJson(data?['followingFeedGet'] ?? {});
        return callback(feed);
      },
      onError: onError,
      queryType: queryType,
    );
  }

  @override
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
  }) async {
    requestedFields ??= TextGql.feed;
    final document = '''
      query advancedFeedGet(\$input: AdvancedFeedGetInput!){
        advancedFeedGet(input:\$input) {
          texts{
             $requestedFields
          }
          nextCursor
        }
      }
    ''';

    final List<String?> textTypesAux =
        textTypes?.map((item) => describeEnum(item)).toList() ?? <String>[];

    final variables = {
      'input': {
        'textTypes': textTypesAux,
        'limit': limit,
        'featured': featured,
        'saved': saved,
        'feedCategory': describeEnum(feedCategory),
      }
    };
    if (cursor != '') {
      variables['input']!['cursor'] = cursor;
    }

    if (feedOrderBy != null || timeSpan != null) {
      variables['input']!['orderBy'] = {
        'orderByType': feedOrderBy != null ? describeEnum(feedOrderBy) : null,
        'timeSpan': timeSpan != null
            ? {
                'start': timeSpan.start.toString(),
                'end': timeSpan.end?.toString()
              }
            : null
      };
    }
    final id = {
      'textTypes': textTypes.toString(),
      'featured': featured,
      'category': feedCategory,
      'saved': saved,
    }.toString();

    variables['input']!['feedCategory'] = describeEnum(feedCategory);
    return repository.query(
      type: CacheType.feed,
      id: id,
      document: document,
      variables: variables,
      callback: (data) {
        final advancedData =
            AdvancedFeedGetResponse.fromJson(data?['advancedFeedGet'] ?? {});
        callback(feedCategory, advancedData);
      },
      onError: onError,
      queryType: queryType,
    );
  }

  @override
  Future<void> topTradesFeed({
    int limit = 10,
    String? cursor = '',
    QueryType queryType = QueryType.loadCache,
    required Function(PUBLIC_FEED_CATEGORY category, DataList<TextModel> data)
        callback,
    required Function(OperationException error) onError,
  }) {
    const requestedFields = TextGql.feed;
    const document = '''
      query topOrdersFeedGet(\$input: FeedInput!){
        topOrdersFeedGet(input: \$input) {
          texts{
            $requestedFields
          }
          nextCursor
        }
      }
    ''';

    final Map<String, Map<String, dynamic>> variables = {
      'input': {
        'cursor': cursor,
      }
    };

    if (cursor != '') {
      variables['input']!['cursor'] = '"' + cursor! + '"';
    }
    return repository.query(
      type: CacheType.topTrades,
      id: 'TopTrades Feed',
      document: document,
      callback: (data) {
        if (data == null || data['topOrdersFeedGet'] == null) {
          return callback(PUBLIC_FEED_CATEGORY.TOP_TRADES,
              const DataList(list: [], cursor: ''));
        }
        final textsListData = data['topOrdersFeedGet']['texts'];
        final cursor = data['topOrdersFeedGet']['nextCursor'];

        final List<TextModel> textsList = List<TextModel>.from(
            textsListData.map((i) => TextModel.fromJson(i)));
        return callback(PUBLIC_FEED_CATEGORY.TOP_TRADES,
            DataList(list: textsList, cursor: cursor));
      },
      variables: variables,
      onError: onError,
      queryType: queryType,
    );
  }

  @override
  Future<void> trendingFeed({
    int limit = 10,
    String? cursor = '',
    QueryType queryType = QueryType.loadCache,
    required Function(PUBLIC_FEED_CATEGORY category, DataList<TextModel> data)
        callback,
    required Function(OperationException error) onError,
  }) {
    const requestedFields = TextGql.feed;
    const document = '''
      query trendingFeedGet(\$input: FeedInput!){
        trendingFeedGet(input: \$input) {
          texts{
            $requestedFields
          }
          nextCursor
        }
      }
    ''';

    final Map<String, Map<String, dynamic>> variables = {
      'input': {
        'cursor': cursor,
      }
    };

    if (cursor != '') {
      variables['input']!['cursor'] = '"' + cursor! + '"';
    }
    return repository.query(
      type: CacheType.forYouFeed,
      id: 'Trending Feed',
      document: document,
      callback: (data) {
        if (data == null || data['trendingFeedGet'] == null) {
          return callback(PUBLIC_FEED_CATEGORY.TRENDING,
              const DataList(list: [], cursor: ''));
        }
        final textsListData = data['trendingFeedGet']['texts'];
        final cursor = data['trendingFeedGet']['nextCursor'];

        final List<TextModel> textsList = List<TextModel>.from(
            textsListData.map((i) => TextModel.fromJson(i)));
        return callback(PUBLIC_FEED_CATEGORY.TRENDING,
            DataList(list: textsList, cursor: cursor));
      },
      variables: variables,
      onError: onError,
      queryType: queryType,
    );
  }

  @override
  Future<User?> getAuthUser({required String requestedFields}) async {
    var document = r'''
    query {
        whoami {
    ''';

    document += requestedFields;
    document += '}}';
    try {
      final queryOptions = remoteProvider.createQueryOptions(
          document: document, variables: {}, fetchPolicy: FetchPolicy.noCache);
      final res = await remoteProvider.queryWithOptions(queryOptions);
      final data = res?.data;
      if (data == null) {
        return null;
      }
      final userData = data['whoami'];
      final user = User.fromJson(userData);
      return user;
    } catch (err) {
      return null;
    }
  }

  @override
  Future<void> getComments(
    CommentsGetInput input, {
    QueryType queryType = QueryType.loadMore,
    required Function(CommentsGetResponse data) callback,
    required Function(OperationException error) onError,
  }) async {
    const document = '''
      query commentsGet(\$input: CommentsGetInput!){
        commentsGet(input:\$input) {
          comments{
              textKey
              value
              orderedCreatedAt
              numberOfReactions
              textType
              parentKey
              taggedGiffs{
                giffKey
                remoteId
                url
              }
              taggedFiles {
                fileKey
                url
                fileType
              }
              authUserReaction{
                user{
                  userKey
                  firstName
                  lastName
                }
              }
              reactions(input: {limit:3}){
                user{
                  userKey
                  firstName
                  lastName
                  profilePictureUrl
                  badgeType
                  createdAt
                }
              }
              user{
                userKey
                firstName
                lastName
                profilePictureUrl
                badgeType
                createdAt
              }
          }
        }
      }
    ''';

    final variables = {
      'input': input.toJson(),
    };

    return repository.query(
      type: CacheType.comments,
      id: input.parentKey.toString(),
      document: document,
      queryType: queryType,
      variables: variables,
      callback: (data) {
        final comments = CommentsGetResponse.fromJson(data?['commentsGet']);
        return callback(comments);
      },
      onError: onError,
    );
  }

  @override
  Future<void> getFullPage({
    List<TEXT_TYPE>? textTypes,
    int? accountUserKey,
    int? portfolioKey,
    required int textKey,
    int? offset,
    QueryType queryType = QueryType.loadCache,
    required Function(List<TextModel> data) callback,
    required Function(OperationException error) onError,
  }) async {
    //  requestedFields ??= TextGql.feedWithOrder;

    const String requestedFields = '''
            ${TextGql.feed}
            ''';

    var document = '''
      query textGet(\$input: TextGetInput
    ''';

    document += '''){
        textGet(input:\$input){
          texts{
            $requestedFields
          }
        }
      }
    ''';

    final List<String?>? textTypesAux =
        textTypes?.map((item) => describeEnum(item)).toList();

    final variables = {
      'input': {
        'textTypes': textTypesAux,
        'accountUserKey': accountUserKey,
        'portfolioKey': portfolioKey,
        'textKey': textKey,
        'limit': 10,
        'offset': offset,
      },
    };

    await repository.query(
        type: CacheType.fullPost,
        id: textKey.toString(),
        document: document,
        variables: variables,
        callback: (data) {
          if (data != null) {
            final textsListData = data?['textGet']?['texts'] ?? [];
            final List<TextModel> textsList = List<TextModel>.from(
                textsListData.map((i) => TextModel.fromJson(i)));
            return callback(textsList);
          } else {
            return callback(<TextModel>[]);
          }
        },
        onError: onError,
        queryType: queryType);
  }

  @override
  Repository<List<Portfolio>> getPortfolios({
    int? offset,
    bool? saved,
    PORTFOLIO_ORDER_BY? orderBy,
  }) {
    const document = '''
      query portfolioSearch(\$input: PortfolioSearchInput!){
        portfolioSearch(input: \$input){
          $portfolioSummaryGql
        }
      }
    ''';

    final variables = {
      'input': {
        'limit': 10,
        'saved': saved,
        'offset': offset,
        'orderBy': describeEnum(orderBy!)
      }
    };

    final dataFromRemote = Future<List<Portfolio>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
          document: document,
          variables: variables,
          fetchPolicy: FetchPolicy.networkOnly);
      final res = await remoteProvider.queryWithOptions(queryOptions);
      final portfolioSearch = res?.data?['portfolioSearch'];
      if (portfolioSearch != null) {
        final portfoliosListData = portfolioSearch['portfolios'];
        final List<Portfolio> portfoliosList = List<Portfolio>.from(
            portfoliosListData.map((i) => Portfolio.fromJson(i)));
        return portfoliosList;
      }
      return <Portfolio>[];
    });

    final dataFromLocal = Future<List<Portfolio>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
        document: document,
        variables: variables,
        fetchPolicy: FetchPolicy.cacheFirst,
      );
      final res = await remoteProvider.queryWithOptions(queryOptions);

      final portfolioSearch = res?.data?['portfolioSearch'];
      if (portfolioSearch != null) {
        final portfoliosListData = portfolioSearch['portfolios'];
        final List<Portfolio> portfoliosList = List<Portfolio>.from(
            portfoliosListData.map((i) => Portfolio.fromJson(i)));
        return portfoliosList;
      }
      return <Portfolio>[];
    });

    return Repository(local: dataFromLocal, remote: dataFromRemote);
  }

  @override
  Future<void> getUserSavedTexts({
    int? userKey,
    int offset = 0,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  }) async {
    final String savedPostsQuery = '''
      savedTexts(input:{limit:10, offset: $offset, textTypes: [POST, ORDER]}) {
            ${TextGql.feed}
          }
    ''';
    var document = r'''
    query {
        whoami {
          userKey
          email
    ''';
    document += savedPostsQuery;
    document += '}}';

    return repository.query(
      type: CacheType.savedTexts,
      id: userKey.toString(),
      document: document,
      queryType: queryType,
      variables: {},
      callback: (data) {
        final userData = data['whoami'];
        final user = User.fromJson(userData);
        callback(user.savedTexts);
      },
      onError: onError,
    );
  }

  @override
  Repository<DataList<Order>> ordersGet({
    List<int?>? orderKeys,
    List<String?>? orderGroupUUIDS,
    String? requestedFields,
    bool? withText = true,
    int? limit,
    String? cursor = '',
  }) {
    requestedFields ??= withText! ? OrderGql.orderWithText : OrderGql.order;
    final document = '''
      query ordersGet(\$input: OrdersGetInput!){
        ordersGet(input:\$input) {
          orders{
             $requestedFields
          }
          nextCursor
        }
      }
    ''';

    final variables = {
      'input': {
        'orderKeys': orderKeys,
        'orderGroupUUIDS': orderGroupUUIDS,
        'limit': limit,
      }
    };

    if (cursor != '') {
      variables['input']!['cursor'] = cursor;
    }

    final dataFromRemote = Future<DataList<Order>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
          document: document,
          variables: variables,
          fetchPolicy: FetchPolicy.networkOnly);
      final res = await remoteProvider.queryWithOptions(queryOptions);
      final data = res?.data;
      if (data == null) {
        return const DataList(list: <Order>[], cursor: '');
      }
      final orderListData = data['ordersGet']['orders'];
      final cursor = data['ordersGet']['nextCursor'];

      final List<Order> ordersList =
          List<Order>.from(orderListData.map((i) => Order.fromJson(i)));
      return DataList(list: ordersList, cursor: cursor);
    });

    final dataFromLocal = Future<DataList<Order>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
        document: document,
        variables: variables,
        fetchPolicy: FetchPolicy.cacheFirst,
      );
      final res = await remoteProvider.queryWithOptions(queryOptions);
      if (res == null || res.data == null || res.data!['ordersGet'] == null) {
        return const DataList(list: <Order>[], cursor: '');
      }
      final orderListData = res.data!['ordersGet']['orders'];
      final cursor = res.data!['ordersGet']['nextCursor'];
      final List<Order> ordersList =
          List<Order>.from(orderListData.map((i) => Order.fromJson(i)));
      return DataList(list: ordersList, cursor: cursor);
    });

    return Repository(local: dataFromLocal, remote: dataFromRemote);
  }

  @override
  Future<TextModel> postCreate({
    required TEXT_TYPE? textType,
    String? value,
    int? parentKey,
    Giff? giff,
    List<http.MultipartFile>? fileUploads,
    int? collectionKey,
  }) async {
    const document = '''
      mutation textCreateV2(\$input: TextCreateV2Input!, \$fileUploads: [Upload]){
        textCreateV2(input:\$input, fileUploads: \$fileUploads){
          text{
            ${TextGql.feed}
            collection {
              collectionKey
            }
          }
        }
      }
    ''';
    final Map<String, dynamic> variables = {};
    final Map<dynamic, dynamic> input = {'textType': describeEnum(textType!)};
    if (value != null) {
      input['value'] = value;
    }
    if (parentKey != null) {
      input['parentKey'] = parentKey;
    }
    if (collectionKey != null) {
      input['collectionKey'] = collectionKey;
    }
    if (giff != null) {
      input['giffInfo'] = {
        'giffSource': describeEnum(giff.giffSource!),
        'remoteId': giff.remoteId,
        'url': giff.url
      };
    }
    if (fileUploads != null && fileUploads.isNotEmpty) {
      variables['fileUploads'] = fileUploads;
    }
    variables['input'] = input;
    final mutationOptions = remoteProvider.createMutationOptions(
        document: document,
        variables: variables,
        fetchPolicy: FetchPolicy.noCache);
    try {
      final res = await remoteProvider.mutateWithOptions(mutationOptions);
      final TextModel text =
          TextModel.fromJson(res.data!['textCreateV2']['text']);
      return text;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setOnlineStatus() async {
    const document = r'''
      mutation{
        userOnline
      }
    ''';
    final mutationOptions =
        remoteProvider.createMutationOptions(document: document);
    try {
      //final res =
      await remoteProvider.mutateWithOptions(mutationOptions);
      // final data = res.data;
      // debugPrint(data);
      // debugPrint('status online setted');
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<TextModel?> textDelete({int? textKey}) async {
    // feedStore.delete(key: textKey);
    // userStore.removeAuthUserText(textKey: textKey);
    const document = r'''
      mutation textDelete($input: TextDeleteInput){
        textDelete(input:$input){
          text{
            textKey
          }
        }
      }
    ''';

    final mutationOptions =
        remoteProvider.createMutationOptions(document: document, variables: {
      'input': {'textKey': textKey},
    });

    try {
      final res = await remoteProvider
          .mutateWithOptions(mutationOptions)
          .catchError((e) {});
      final text = res.data!['textDelete']['text'];
      return TextModel.fromJson(text);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<TextModel> textEdit({
    int? textKey,
    String? value,
    Giff? giff,
    List<http.MultipartFile>? fileUploads,
    int? entityKey,
    APP_MEDIA_TYPE? entityType,
    int? collectionKey,
  }) async {
    // feedStore.upsert(
    //     key: textKey, i: TextModel(textKey: textKey, value: value));
    // userStore.editAuthUserText(textKey: textKey, value: value);
    const document = r'''
    mutation textEdit($input: TextEditInput, $fileUploads: [Upload]){
      textEdit(input: $input, fileUploads: $fileUploads){
        text{
          textKey
          value
          taggedGiffs{
            giffKey
            remoteId
            url
          }
          taggedFiles {
            fileKey
            url
            fileType
          }
        }
      }
    }
    ''';
    final Map<String, dynamic> variables = {};
    final Map<dynamic, dynamic> input = {'textKey': textKey, 'value': value};
    if (collectionKey != null) {
      input['collectionKey'] = collectionKey;
    }
    if (entityKey != null && entityType != null) {
      input['removeTextTags'] = [
        {
          'entityKey': entityKey,
          'entityType': entityType == APP_MEDIA_TYPE.GIFF ? 'GIFF' : 'FILE'
        }
      ];
    }
    if (giff != null) {
      input['giffInfo'] = {
        'giffSource': describeEnum(giff.giffSource!),
        'remoteId': giff.remoteId,
        'url': giff.url
      };
    }
    if (fileUploads != null && fileUploads.isNotEmpty) {
      variables['fileUploads'] = fileUploads;
    }
    variables['input'] = input;
    final mutationOptions = remoteProvider.createMutationOptions(
        document: document, variables: variables);

    try {
      final res = await remoteProvider
          .mutateWithOptions(mutationOptions)
          .catchError((e) {
        debugPrint(
            'Could not complete GraphQL request for textEdit. Error: $e');
        throw e;
      });
      final text = res.data!['textEdit']['text'];
      return TextModel.fromJson(text);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Repository<DataList<TextModel>> textsGet({
    List<int?>? textKeys,
    List<int?>? orderKeys,
    List<int?>? assetKeys,
    List<String?>? orderGroupUUIDS,
    String? requestedFields,
    int? limit,
    String? cursor = '',
  }) {
    requestedFields ??= TextGql.feed;
    final document = '''
      query textsGet(\$input: TextsGetInput!){
        textsGet(input:\$input) {
          texts{
             $requestedFields
          }
          nextCursor
        }
      }
    ''';

    final variables = {
      'input': {
        'textKeys': textKeys,
        'orderKeys': orderKeys,
        'assetKeys': assetKeys,
        'orderGroupUUIDS': orderGroupUUIDS,
        'limit': limit,
      }
    };

    if (cursor != '') {
      variables['input']!['cursor'] = cursor;
    }

    final dataFromRemote = Future<DataList<TextModel>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
          document: document,
          variables: variables,
          fetchPolicy: FetchPolicy.networkOnly);
      final res = await remoteProvider.queryWithOptions(queryOptions);

      final data = res?.data;
      if (data == null) {
        return const DataList(list: <TextModel>[], cursor: '');
      }
      final textsListData = data['textsGet']['texts'];
      final cursor = data['textsGet']['nextCursor'];

      final List<TextModel> textsList =
          List<TextModel>.from(textsListData.map((i) => TextModel.fromJson(i)));
      return DataList(list: textsList, cursor: cursor);
    });

    final dataFromLocal = Future<DataList<TextModel>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
        document: document,
        variables: variables,
        fetchPolicy: FetchPolicy.cacheFirst,
      );
      final res = await remoteProvider.queryWithOptions(queryOptions);
      if (res == null || res.data == null || res.data!['textsGet'] == null) {
        return const DataList(list: <TextModel>[], cursor: '');
      }
      final textsListData = res.data!['textsGet']['texts'];
      final cursor = res.data!['textsGet']['nextCursor'];
      final List<TextModel> textsList =
          List<TextModel>.from(textsListData.map((i) => TextModel.fromJson(i)));
      return DataList(list: textsList, cursor: cursor);
    });

    return Repository(local: dataFromLocal, remote: dataFromRemote);
  }

  @override
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
      RELATION_LOCATION? relationLocation}) async {
    const document = r'''
      mutation userRelationsUpdate($input:UserRelationsUpdateInput!){
          userRelationsUpdate(input:$input){
            userRelations {
              userRelationKey
              mutedAt
              hideAt
              relationLocation
              seenAt
              savedAt
              notificationAmount
            }
          }
        }
    ''';

    final Map<String, dynamic> input = {
      'entityType': describeEnum(entityType),
      'entityKeys': [...entityKeys],
      'mute': mute,
      'watch': watch,
      'block': block,
      'hide': hide,
      'seen': seen,
      'save': save,
    };

    if (notificationAmount != null) {
      input['notificationAmount'] = describeEnum(notificationAmount);
    }

    if (relationLocation != null) {
      input['relationLocation'] = describeEnum(relationLocation);
    }

    final mutationOptions = remoteProvider.createMutationOptions(
      document: document,
      variables: {'input': input},
    );
    try {
      final res = await remoteProvider.mutateWithOptions(mutationOptions);
      final relationData = res.data!['userRelationsUpdate']['userRelations'][0];
      return UserRelation.fromJson(relationData);
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }
}

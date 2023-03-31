import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class ProfileSearchRepository implements IProfileSearchRepository {
  final IGraphqlProvider remoteProvider;
  ProfileSearchRepository({
    required this.remoteProvider,
    //  @required this.localProvider,
  });
  // final IEncriptedDatabase localProvider;
  // final ICacheManager localProvider;

  Map getQueryInfo({
    required String? name,
    required int? offset,
    required int? entityKey,
    required SEARCH_QUERY entityType,
    required SEARCH_QUERY searchFollowing,
  }) {
    const document = r'''
      query search($input: SearchInput) {
        search(input: $input) {
          users{
            userKey
            profilePictureUrl
            firstName
            lastName
            email
            verifiedAt
            badgeType
            firstOrderAt
            authUserFollowInfo{
              followStatus
            }
          }
          portfolios{
            brokerName
            portfolioKey
            portfolioName
            authUserFollowInfo{
              followStatus
            }
            connectionStatus
            user{
              userKey
              firstName
              lastName
              badgeType
            }
          }
        }
      }
    ''';

    final variables = {
      'input': {
        'name': name,
        'limit': 10,
        'offset': offset,
        'options': {
          'entityType': describeEnum(entityType),
          'entityKey': entityKey,
          'searchFollowing': describeEnum(searchFollowing)
        }
      },
    };

    return {'document': document, 'variables': variables};
  }

  @override
  Repository<List<User>> searchFollowers({
    required String? name,
    required int? offset,
    required int? entityKey,
    SEARCH_QUERY? entityType = SEARCH_QUERY.USER,
    SEARCH_QUERY? searchFollowing = SEARCH_QUERY.FOLLOWERS,
  }) {
    return searchFollowersOrFollowing(
        name: name,
        offset: offset,
        entityKey: entityKey,
        entityType: entityType!,
        searchFollowing: searchFollowing!);
  }

  Repository<List<User>> searchFollowersOrFollowing({
    required String? name,
    required int? offset,
    required int? entityKey,
    SEARCH_QUERY entityType = SEARCH_QUERY.USER,
    required SEARCH_QUERY searchFollowing,
  }) {
    final Map queryInfo = getQueryInfo(
        name: name,
        offset: offset,
        entityKey: entityKey,
        entityType: entityType,
        searchFollowing: searchFollowing);
    final document = queryInfo['document'];
    final variables = queryInfo['variables'];

    final dataFromRemote = Future<List<User>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
          document: document,
          variables: variables,
          fetchPolicy: FetchPolicy.networkOnly);
      final res = await remoteProvider.queryWithOptions(queryOptions);
      final data = res?.data;
      if (data == null) {
        return <User>[];
      }
      final userListData = data['search']['users'];
      final List<User> userList =
          List<User>.from(userListData.map((i) => User.fromJson(i)));
      return userList;
    });

    final dataFromLocal = Future<List<User>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
        document: document,
        variables: variables,
        fetchPolicy: FetchPolicy.cacheFirst,
      );
      final res = await remoteProvider.queryWithOptions(queryOptions);

      final data = res?.data;
      if (data == null) {
        return <User>[];
      }

      final userListData = data['search']['users'];
      final List<User> userList =
          List<User>.from(userListData.map((i) => User.fromJson(i)));
      return userList;
    });
    return Repository(local: dataFromLocal, remote: dataFromRemote);
  }

  @override
  Repository<List<User>> searchFollowing({
    required String? name,
    required int? offset,
    required int? entityKey,
    SEARCH_QUERY? entityType = SEARCH_QUERY.USER,
    SEARCH_QUERY? searchFollowing = SEARCH_QUERY.FOLLOWING,
  }) {
    return searchFollowersOrFollowing(
        name: name,
        offset: offset,
        entityKey: entityKey,
        entityType: entityType!,
        searchFollowing: searchFollowing!);
  }

  @override
  Repository<List<Portfolio>> searchPortfoliosFollowing({
    required String? name,
    required int? offset,
    required int? entityKey,
    SEARCH_QUERY? entityType = SEARCH_QUERY.USER,
    SEARCH_QUERY? searchFollowing = SEARCH_QUERY.PORTFOLIOS_FOLLOWING,
  }) {
    final Map queryInfo = getQueryInfo(
        name: name,
        offset: offset,
        entityKey: entityKey,
        entityType: entityType!,
        searchFollowing: searchFollowing!);
    final document = queryInfo['document'];
    final variables = queryInfo['variables'];

    final dataFromRemote = Future<List<Portfolio>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
          document: document,
          variables: variables,
          fetchPolicy: FetchPolicy.networkOnly);

      final res = await remoteProvider.queryWithOptions(queryOptions);

      final data = res?.data;
      if (data == null) {
        return <Portfolio>[];
      }

      final portfolioListData = data['search']['portfolios'];
      final List<Portfolio> portfolioList = List<Portfolio>.from(
          portfolioListData.map((i) => Portfolio.fromJson(i)));
      return portfolioList;
    });

    final dataFromLocal = Future<List<Portfolio>>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
        document: document,
        variables: variables,
        fetchPolicy: FetchPolicy.cacheFirst,
      );
      final res = await remoteProvider.queryWithOptions(queryOptions);

      final data = res?.data;
      if (data == null) {
        return <Portfolio>[];
      }

      final portfolioListData = data['search']['portfolios'];
      final List<Portfolio> portfolioList = List<Portfolio>.from(
          portfolioListData.map((i) => Portfolio.fromJson(i)));
      return portfolioList;
    });
    return Repository(local: dataFromLocal, remote: dataFromRemote);
  }
}

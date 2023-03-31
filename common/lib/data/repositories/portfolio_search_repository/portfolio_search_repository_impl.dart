import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class PortfolioSearchRepository implements IPortfolioSearchRepository {
  final IGraphqlProvider remoteProvider;
  PortfolioSearchRepository({
    required this.remoteProvider,
    //  @required this.localProvider,
  });
  // final IEncriptedDatabase localProvider;
  // final ICacheManager localProvider;

  @override
  Repository<List<User>> loadUsers(
      {String? name = '',
      int limit = 10,
      int? offset = 10,
      required entityKey,
      required SEARCH_QUERY entityType,
      required SEARCH_QUERY searchFollowing}) {
    final dataFromRemote = searchUser(
        name: name!,
        offset: offset!,
        entityKey: entityKey,
        entityType: entityType,
        searchFollowing: searchFollowing,
        fetchPolicy: FetchPolicy.networkOnly);
    final dataFromLocal = searchUser(
        name: name,
        offset: offset,
        entityKey: entityKey,
        entityType: entityType,
        searchFollowing: searchFollowing,
        fetchPolicy: FetchPolicy.cacheFirst);
    return Repository(local: dataFromLocal, remote: dataFromRemote);
  }

  Future<List<User>> searchUser({
    required String name,
    required int offset,
    required int entityKey,
    required SEARCH_QUERY entityType,
    required SEARCH_QUERY searchFollowing,
    required FetchPolicy fetchPolicy,
  }) async {
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
        
            connectedBrokerNames
          }
        }
      }
    ''';
    final queryOptions = remoteProvider.createQueryOptions(
        document: document,
        variables: {
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
        },
        fetchPolicy: fetchPolicy);
    try {
      final res = await remoteProvider
          .queryWithOptions(queryOptions)
          .catchError((e) {});
      final userListData = res!.data!['search']['users'];
      final List<User> userList =
          List<User>.from(userListData.map((i) => User.fromJson(i)));
      return userList;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}

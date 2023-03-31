import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class SearchService extends GetxService {
  SearchService();
  IGraphqlProvider iGraphqlProvider = Get.find();

  Future<List<User>> relevantUsersSearch({
    required String? name,
    required int offset,
    bool? excludeAuthUser = true,
    List<int>? excludeUserKeys,
    CONTEXT_TYPE? contextType = CONTEXT_TYPE.GENERAL,
    int? contextKey,
  }) async {
    if (name == null) {
      throw 'ERROR: SearchService usersSearch name is null';
    }
    const document = r'''
      query relevantUsersSearch($input: RelevantUsersSearchInput) {
        relevantUsersSearch(input: $input) {
          users{
            userKey
            profilePictureUrl
            firstName
            lastName
            username
            email
            verifiedAt
            verifiedText
            firstOrderAt
            avatar {
              avatarKey
              avatarName
              code
              url
            }
            connectedBrokerNames
          }
        }
      }
    ''';
    final Map<String, dynamic> variables = {
      'input': {
        'searchText': name,
        'limit': 10,
        'offset': offset,
        'excludeAuthUser': excludeAuthUser,
        'context': {
          'contextType': describeEnum(contextType!),
        }
      }
    };

    if (contextKey != null) {
      variables['input']['context'] = {
        'contextType': variables['input']['context']['contextType'],
        'contextKey': contextKey,
      };
    }

    if (excludeUserKeys != null && excludeUserKeys.isNotEmpty) {
      variables['excludeUserKeys'] = excludeUserKeys;
    }
    final queryOptions = iGraphqlProvider.createQueryOptions(
        document: document, variables: variables, fragments: ['']);
    final res = await iGraphqlProvider
        .queryWithOptions(queryOptions)
        .catchError((e) {});
    final data = res?.data;
    if (data == null) {
      return <User>[];
    } else {
      final userListData = data['relevantUsersSearch']['users'];
      final List<User> userList =
          List<User>.from(userListData.map((i) => User.fromJson(i)));
      return userList;
    }
  }

  Future<List<User>> usersSearch(
      {required String? name, required int offset}) async {
    if (name == null) {
      throw 'ERROR: SearchService usersSearch name is null';
    }
    const document = r'''
      query usersSearch($input: UsersSearchInput) {
        usersSearch(input: $input) {
          users{
            userKey
            profilePictureUrl
            firstName
            lastName
            username
            email
            verifiedAt
            verifiedText
            firstOrderAt
            authUserFollowInfo{
              followStatus
            }
            avatar {
              avatarKey
              avatarName
              code
              url
            }
          }
        }
      }
    ''';
    final queryOptions =
        iGraphqlProvider.createQueryOptions(document: document, variables: {
      'input': {'name': name, 'limit': 10, 'offset': offset},
    }, fragments: [
      ''
    ]);
    final res = await iGraphqlProvider
        .queryWithOptions(queryOptions)
        .catchError((e) {});
    final data = res?.data;
    if (data == null) {
      return <User>[];
    } else {
      final userListData = data['usersSearch']['users'];
      final List<User> userList =
          List<User>.from(userListData.map((i) => User.fromJson(i)));
      return userList;
    }
  }

  Future<List<T>?> search<T>({
    required String name,
    required int offset,
    required int entityKey,
    required SEARCH_QUERY entityType,
    required SEARCH_QUERY searchFollowing,
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
            verifiedText
            firstOrderAt
            authUserFollowInfo{
              followStatus
            }
            avatar {
              avatarKey
              avatarName
              code
              url
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
            }
          }
        }
      }
    ''';
    final queryOptions = iGraphqlProvider.createQueryOptions(
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
    );
    try {
      final res = await iGraphqlProvider
          .queryWithOptions(queryOptions)
          .catchError((e) {});
      if (searchFollowing == SEARCH_QUERY.PORTFOLIOS_FOLLOWING) {
        final portfolioListData = res!.data!['search']['portfolios'];
        final List<Portfolio> portfolioList = List<Portfolio>.from(
            portfolioListData.map((i) => Portfolio.fromJson(i)));
        return portfolioList as List<T>;
      }
      final userListData = res!.data!['search']['users'];
      final List<User> userList =
          List<User>.from(userListData.map((i) => User.fromJson(i)));
      return userList as List<T>;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}

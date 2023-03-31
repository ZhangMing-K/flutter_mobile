import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class FollowService extends GetxService {
  FollowService({required this.iGraphqlProvider});
  final IGraphqlProvider iGraphqlProvider;

  Future editFollowingSettings(
      {required int entityKey,
      required FOLLOW_REQUEST_ENTITY_TYPE entityType,
      bool? watch,
      bool? mute,
      double? notificationPercentage}) async {
    const document = r'''
      mutation editFollowingSettings($input: EditFollowingSettings){
        editFollowingSettings(input: $input) {
          followRequest{
            followRequestKey
            favoritedAt
            notificationPercentage
            mutedAt
          }
        }
      }
    ''';
    final mutationOptions =
        iGraphqlProvider.createMutationOptions(document: document, variables: {
      'input': {
        'entityKey': entityKey,
        'entityType': describeEnum(entityType),
        'watch': watch,
        'mute': mute,
        'notificationPercentage': notificationPercentage
      }
    });

    final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
    if (res.data == null) {
      throw 'Error did not receive data from api';
    }
    return FollowRequest.fromJson(
        res.data!['editFollowingSettings']['followRequest']);
  }

  Future<dynamic> respondToFollowRequest(
      {required int? followRequestKey,
      required FOLLOW_REQUEST_ACTION action}) async {
    const document = r'''
      mutation respondToFollowRequest($input: RespondToFollowRequestInput){
        respondToFollowRequest(input:$input){
          followRequest{
            followRequestKey
            status
          }
        }
      }
    ''';
    final mutationOptions =
        iGraphqlProvider.createMutationOptions(document: document, variables: {
      'input': {
        'followRequestKey': followRequestKey,
        'action': describeEnum(action),
      }
    });

    final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
    if (res.data == null) {
      throw 'Error did not receive data from api';
    }
    return FollowRequest.fromJson(
        res.data!['respondToFollowRequest']['followRequest']);
  }

  Future<FollowRequest?> requestToFollowType(
      {required FOLLOW_REQUEST_ENTITY_TYPE entityType,
      required int? lookupKey}) async {
    const document = r'''
      mutation requestToFollowType($input: RequestToFollowTypeInput){
        requestToFollowType(input:$input){
          ...followRequestResponseTypeFragment
        }
      }
    ''';
    final mutationOptions =
        iGraphqlProvider.createMutationOptions(document: document, variables: {
      'input': {'entityType': describeEnum(entityType), 'lookupKey': lookupKey}
    }, fragments: [
      followRequestResponseTypeFragment
    ]);
    try {
      final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
      final data = res.data!['requestToFollowType'];
      return FollowRequest.fromJson(data['followRequest']);
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<FollowRequest?> follow(
      {required int userKey, int? fromTextKey}) async {
    debugPrint('FOLOWIfkajsdfhasd');
    const document = r'''
      mutation follow($input: FollowInput!){
        follow(input: $input){
          followRequest{
            accountUser{
              userKey
              authUserFollowInfo{
                followStatus
              }
            }
            portfolio{
              portfolioKey
              authUserFollowInfo{
                followStatus
              }
            }
          }
        }
      }
    ''';

    final Map<String, dynamic> input = {
      'userKey': userKey,
    };
    if (fromTextKey != null) {
      input['fromTextKey'] = fromTextKey;
    }
    final mutationOptions = iGraphqlProvider.createMutationOptions(
      document: document,
      variables: {'input': input},
    );
    try {
      final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
      final data = res.data!['follow'];
      return FollowRequest.fromJson(data['followRequest']);
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<List<FollowRequest>?> bulkRequestToFollowType(
      {required FOLLOW_REQUEST_ENTITY_TYPE entityType,
      required List<int?> lookupKeys}) async {
    const document = r'''
      mutation bulkRequestToFollowType($input: BulkRequestToFollowTypeInput){
        bulkRequestToFollowType(input:$input){
          followRequests {
            accountUser{
              authUserFollowInfo{
                followStatus
              }
            }
            portfolio{
              portfolioKey
              authUserFollowInfo{
                followStatus
              }
            }
          }
        }
      }
    ''';
    final mutationOptions =
        iGraphqlProvider.createMutationOptions(document: document, variables: {
      'input': {
        'entityType': describeEnum(entityType),
        'lookupKeys': [...lookupKeys]
      }
    });
    try {
      final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
      final data = res.data!['bulkRequestToFollowType']['followRequests'];
      final List<FollowRequest> followRequests =
          List<FollowRequest>.from(data.map((i) => FollowRequest.fromJson(i)));
      return followRequests;
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<User?> removeFollower(
      {required int? userKey, int? portfolioKey}) async {
    const document = r'''
      mutation removeFollower($input: RemoveFollowerInput){
        removeFollower(input:$input){
          followRequests{
            accountUser{
              userKey
              followStats{
                numberOfFollowers,
                numberFollowing,
                numberOfPortfoliosFollowing
                entityType,
                lookupKey,  
              }    
            }
          }
        }
      }
    ''';
    final mutationOptions = iGraphqlProvider.createMutationOptions(
      document: document,
      variables: {
        'input': {'userKey': userKey, 'portfolioKey': portfolioKey}
      },
    );
    try {
      final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
      final data = res.data!['removeFollower'];
      return User.fromJson(data['followRequests'][0]['accountUser']);
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future unfollow(
      {required FOLLOW_REQUEST_ENTITY_TYPE entityType, int? entityKey}) async {
    const document = r'''
      mutation unfollow($input: UnfollowInput){
        unfollow(input:$input){
          success
        }
      }
    ''';
    final mutationOptions = iGraphqlProvider.createMutationOptions(
      document: document,
      variables: {
        'input': {
          'entityType': describeEnum(entityType),
          'entityKey': entityKey
        }
      },
    );
    try {
      final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
      return res;
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  final followRequestResponseTypeFragment = '''
  fragment followRequestResponseTypeFragment on RequestToFollowTypeResponse {
      followRequest{
        accountUser{
          userKey
          authUserFollowInfo{
            followStatus
          }
        }
        portfolio{
          portfolioKey
          authUserFollowInfo{
            followStatus
          }
        }
      }
  }          
  ''';
}

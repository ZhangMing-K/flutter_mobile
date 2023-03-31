import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class UserService extends GetxService {
  final IGraphqlProvider iGraphqlProvider;

  UserService({required this.iGraphqlProvider});

  Future<User?> getUserByKey(
      {required int? userKey, required String requestedFields}) async {
    var document = r'''
    query getUserByKey($userKey: Int) {
        usersGet(input: {
          userKeys: [$userKey]
        }) {
          users {
    ''';
    document += requestedFields;
    document += '}}}';
    final queryOptions = iGraphqlProvider.createQueryOptions(
        document: document, variables: {'userKey': userKey});
    try {
      final res = await iGraphqlProvider.queryWithOptions(queryOptions);
      if (res?.hasException ?? false) {
        debugPrint(res?.exception.toString());
      }
      final data = res?.data;
      if (data == null) {
        return null;
      }

      if (data['usersGet']['users'] == null ||
          data['usersGet']['users'].length < 1) {
        return null;
      }
      final userData = data['usersGet']['users'][0];
      final user = User.fromJson(userData);
      return user;
    } catch (err) {
      rethrow;
    }
  }

  Future<bool?> userDelete({required int? userKey}) async {
    const document = r'''
    mutation userDelete($input: UserDeleteInput) {
      userDelete(input:$input) {
          user {
            userKey
            firstName
            lastName
            username
            deletedAt
          }
        }
    }
    ''';
    final variables = {
      'input': {'userKey': userKey}
    };
    final options = iGraphqlProvider.createMutationOptions(
        document: document, variables: variables);
    try {
      final res = await iGraphqlProvider.mutateWithOptions(options);
      if (res.data == null) {
        return null;
      }
      return true;
    } catch (err) {
      debugPrint(err.toString());
      return false;
    }
  }

  Future<User?> userEdit({
    String? firstName,
    String? lastName,
    String? description,
    String? username,
    String? email,
    String? avatarCode,
    USER_PRIVACY_TYPE? userPrivacyType,
    EXPERIENCE_LEVEL? experienceLevel,
    String? phoneNumber,
  }) async {
    const document = r'''
    mutation userEdit($input: UserEditInput) {
      userEdit(input:$input){
        user{
          firstName
          lastName
          description
          email
          profilePictureUrl
          username
          userKey
          userPrivacyType
          nbrUnreadMessages
          invitedByUser{
            userKey
            firstName
            lastName
            profilePictureUrl
            portfolios {
              brokerName
            }
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

    var input = {};
    if (firstName != null) input['firstName'] = firstName;

    if (lastName != null) input['lastName'] = lastName;

    if (description != null) input['description'] = description;

    if (avatarCode != null) input['avatarCode'] = avatarCode;

    if (username != null) input['username'] = username.toLowerCase();
    if (email != null) input['email'] = email.toLowerCase();

    if (userPrivacyType != null) {
      input['userPrivacyType'] = describeEnum(userPrivacyType);
    }

    if (experienceLevel != null) {
      input['experienceLevel'] = describeEnum(experienceLevel);
    }

    if (phoneNumber != null) input['phoneNumber'] = phoneNumber;

    final options = iGraphqlProvider
        .createMutationOptions(document: document, variables: {'input': input});

    final res = await iGraphqlProvider.mutateWithOptions(options);
    if (res.exception != null) {
      throw res.exception!.graphqlErrors;
    }
    final userData = res.data?['userEdit']['user'];
    final user = User.fromJson(userData);
    return user;
  }
}

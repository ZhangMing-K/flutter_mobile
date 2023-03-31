import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:iris_common/iris_common.dart';

class AuthService extends GetxService {
  AuthService({
    required this.iGraphqlProvider,
    required this.deeplinkService,
    required this.keyChainService,
  });
  final IGraphqlProvider iGraphqlProvider;
  final DeeplinkService deeplinkService;
  final KeyChainService keyChainService;

  Future<UserCreateResponse> registerUser(String? password, String? email,
      String? firstName, String? lastName, String? username) async {
    const document = r'''
        mutation userCreate($input: UserCreateInput){
          userCreate(input:$input){
            ...registerFieldsResponseFragment
          }
        }
    ''';

    final Map<String, dynamic> input = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'username': username
    };
    if (deeplinkService.invitedByUserKey != null) {
      input['invitedByUserKey'] = deeplinkService.invitedByUserKey;
    }
    if (deeplinkService.invitedByInviteLinkKey != null) {
      input['invitedByInviteLinkKey'] = deeplinkService.invitedByInviteLinkKey;
    }
    if (deeplinkService.deeplinkFrom != null) {
      input['deeplinkFrom'] = deeplinkService.deeplinkFrom;
    }

    final _options = iGraphqlProvider.createMutationOptions(
        document: document,
        variables: {'input': input},
        fetchPolicy: FetchPolicy.noCache,
        fragments: [registerFieldsResponseFragment]);
    final res = await iGraphqlProvider.mutateWithOptions(_options);

    final response = UserCreateResponse.fromJson(res.data?['userCreate'] ?? {});

    keyChainService.upsert(
        key: KeyChainAuthCredKeyNames.usernameKey, value: email);
    keyChainService.upsert(
        key: KeyChainAuthCredKeyNames.passwordKey, value: password);
    return response;
  }

  Future<UserCreateResponse> registerUserMfa({
    required String? challengeId,
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) async {
    const document = r'''
        mutation userCreateMFA($input: UserCreateMFAInput!){
          userCreateMFA(input:$input){
            ...registerFieldsResponseFragment
          }
        }
    ''';

    final Map<String, dynamic> input = {
      'firstName': firstName,
      'lastName': lastName,
      'mfaChallengeId': challengeId,
      'phoneNumber': phoneNumber
    };
    if (deeplinkService.invitedByUserKey != null) {
      input['invitedByUserKey'] = deeplinkService.invitedByUserKey;
    }
    if (deeplinkService.invitedByInviteLinkKey != null) {
      input['invitedByInviteLinkKey'] = deeplinkService.invitedByInviteLinkKey;
    }
    if (deeplinkService.deeplinkFrom != null) {
      input['deeplinkFrom'] = deeplinkService.deeplinkFrom;
    }

    final _options = iGraphqlProvider.createMutationOptions(
        document: document,
        variables: {'input': input},
        fetchPolicy: FetchPolicy.noCache,
        fragments: [registerFieldsResponseFragment]);
    final res = await iGraphqlProvider.mutateWithOptions(_options);

    final response =
        UserCreateResponse.fromJson(res.data?['userCreateMFA'] ?? {});
    return response;
  }

  // Future<LoginResponse> loginWithEmailandPassword(
  //     String? email, String? password) async {
  //   const document = r'''
  //     query login($input: LoginInput){
  //       login(input:$input) {
  //         ...loginFieldsResponseFragment
  //       }
  //     }
  //   ''';
  //   final _options = iGraphqlProvider.createQueryOptions(
  //     document: document,
  //     fragments: [loginFieldsResponseFragment],
  //     variables: {
  //       'input': {'email': email, 'password': password}
  //     },
  //     fetchPolicy: FetchPolicy.noCache,
  //   );
  //   final res = await iGraphqlProvider.queryWithOptions(_options);
  //   final data = res?.data;
  //   if (res!.hasException) {
  //     throw res.exception!;
  //   }
  //   if (data == null || data['login'] == null) {
  //     return LoginResponse(authUserJson: null, authToken: null);
  //   }
  //   final authToken = data['login']['auth']['token'];
  //   // iGraphqlProvider.authToken = 'Bearer $authToken';
  //   final authUserJson = data['login']['user'];

  //   keyChainService.upsert(
  //       key: KeyChainAuthCredKeyNames.usernameKey, value: email);
  //   keyChainService.upsert(
  //       key: KeyChainAuthCredKeyNames.passwordKey, value: password);

  //   return LoginResponse(authUserJson: authUserJson, authToken: authToken);
  // }

  final loginFieldsResponseFragment = '''
  fragment loginFieldsResponseFragment on LoginResponse {
      user{
        userKey
        email
        firstName
        lastName
        username
        verifiedAt
        verifiedText
        firstOrderAt
        description
        profilePictureUrl
        inviteLink
        lastOnlineAt
        nbrUnreadMessages
        followStats{
          numberOfFollowers
        }
        portfolios{
          portfolioKey
        }
        notifications(input: {limit: 3, offset: 0, seen: false}){
          userKey
        }
        avatar {
          avatarKey
          avatarName
          code
          url
        }
      }
      auth{
        token
        type
      }
      newlyCreated
  }
  ''';

  final registerFieldsResponseFragment = '''
  fragment registerFieldsResponseFragment on UserCreateResponse {
      user{
        userKey
        email
        firstName
        lastName
        description
        profilePictureUrl
        inviteLink
        followStats{
          numberOfFollowers
        }
        portfolios{
          portfolioKey
        }
        avatar {
          avatarKey
          url
          avatarName
          code
        }
      }
      auth{
        token
        type
      }
  }
  ''';

  final defaultFields = '''
        userKey
        email
        firstName
        lastName
        profilePictureUrl
        inviteLink
        description
        lastOnlineAt
        username
        nbrUnreadMessages
        goldConnection {
          isGoldMember
        }
        avatar {
          avatarKey
          avatarName
          code
          url
        }
  ''';
  Future<User?> getAuthUser({String? requestedFields}) async {
    requestedFields ??= defaultFields;
    var document = r'''
    query {
        whoami {
    ''';

    document += requestedFields;
    document += '}}';
    try {
      final queryOptions = iGraphqlProvider.createQueryOptions(
          document: document, variables: {}, fetchPolicy: FetchPolicy.noCache);
      final res = await iGraphqlProvider.queryWithOptions(queryOptions);
      final data = res?.data;
      if (data == null) {
        return null;
      }
      final userData = data['whoami'];
      final user = User.fromJson(userData);
      return user;
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<String?> userResetPasswordEmail({String? username}) async {
    const document = r'''
    mutation userResetPasswordEmail($input: UserResetPasswordEmailInput){
          userResetPasswordEmail(input:$input){
            user{
              userKey
              email
              firstName
              lastName
              profilePictureUrl
              inviteLink
              description
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

    final mutationOptions = iGraphqlProvider.createMutationOptions(
        document: document,
        variables: {
          'input': {'username': username}
        },
        fetchPolicy: FetchPolicy.noCache);
    try {
      final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
      final email = res.data!['userResetPasswordEmail']['user']['email'];
      return email;
    } catch (err) {
      rethrow;
    }
  }

  Future<String?> userResetPasswordConfirm(
      {String? username, String? code, String? password}) async {
    const document = r'''
    mutation userResetPasswordConfirm($input: UserResetPasswordConfirmInput){
          userResetPasswordConfirm(input:$input){
            pass
          }
        }
    ''';
    final mutationOptions = iGraphqlProvider.createMutationOptions(
        document: document,
        variables: {
          'input': {'username': username, 'code': code, 'password': password}
        },
        fetchPolicy: FetchPolicy.noCache);
    try {
      final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
      final resData = res.data!['userResetPasswordConfirm']['pass'];
      return resData.toString();
    } catch (err) {
      if (err.toString() == '[Incorrect code: Undefined location]') {
        return 'codeIncorrect';
      }
      if (err.toString() ==
          '[Reset code has expired, you must request a new code: Undefined location]') {
        return 'codeExpired';
      }
      return null;
    }
  }
}

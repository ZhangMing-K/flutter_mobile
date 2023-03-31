import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';

import '../../iris_common.dart';

class InstitutionService extends GetxService {
  InstitutionService();

  IGraphqlProvider iGraphqlProvider = Get.find();

  Future<InstitutionConnectResponse?> connect({
    required INSTITUTION_NAME institutionName,
    required String? username,
    required String? password,
    INSTITUTION_CONNECTED_FROM connectedFrom =
        INSTITUTION_CONNECTED_FROM.PROFILE,
    String? oauthKey,
    int? institutionKey,
    int? portfolioKey,
  }) async {
    const document = r'''
    mutation institutionConnect($input: InstitutionConnectInput!){
      institutionConnect(input: $input){
        challengeId
        institution{
          institutionKey
          institutionAccounts{
            portfolio{
              portfolioKey
            }
            isBrokerage
            accountId
            name
          }
        }
        connectStep
        challengeOptions
        challengeType
        selectedChallengeValue
      }
    }
    ''';

    final Map input = {
      'oauthKey': oauthKey,
      'username': username,
      'password': password,
      'institutionName': describeEnum(institutionName),
      'institutionKey': institutionKey,
      'portfolioKey': portfolioKey,
      'connectedFrom': describeEnum(connectedFrom)
    };

    final queryOptions = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});

    final res = await iGraphqlProvider.queryWithOptions(queryOptions);
    if (res?.hasException ?? false) {
      final GraphQLError? graphQlError = res!.exception!.graphqlErrors[0];
      final String message =
          graphQlError?.message ?? 'username or password is incorrect';
      throw InstitutionInvalidCreds(message);
    }

    final dataResponse = res?.data?['institutionConnect'];
    if (dataResponse == null) {
      return null;
    } else {
      debugPrint('RESP $dataResponse');
      return InstitutionConnectResponse.fromJson(dataResponse);
    }
  }

  selectChallenge(
      {required String challengeId,
      required int institutionKey,
      required String challengeOptionSelected}) {}

  Future<InstitutionConnectResponse?> respondToChallenge(
      {required String challengeId,
      required int institutionKey,
      required String challengeResponseValue}) async {
    const document = r'''
        mutation institutionConnectRespondToChallenge($input: InstitutionConnectRespondToChallenge!){
          institutionConnectRespondToChallenge(input: $input) {
            challengeId
            institution{
              institutionKey
              institutionAccounts{
                portfolio{
                  portfolioKey
                }
                isBrokerage
                accountId
                name
              }
            }                  
            challengeType
            challengeOptions
            selectedChallengeValue
            connectStep
          }
        }
        ''';

    final variables = {
      'input': {
        'institutionKey': institutionKey,
        'challengeResponseValue': challengeResponseValue,
        'challengeId': challengeId,
      }
    };

    final options = iGraphqlProvider.createMutationOptions(
        document: document, variables: variables);

    final res = await iGraphqlProvider.mutateWithOptions(options);
    if (res.hasException) {
      if (res.exception!.graphqlErrors[0].message
          .contains('password is incorrect')) {
        throw InstitutionInvalidCreds('username or password is incorrect');
      }
      if (res.exception!.graphqlErrors[0].message
          .contains('trade password invalid')) {
        throw InstitutionInvalidCreds('trade password invalid');
      }
    }

    final dataResponse = res.data?['institutionConnectRespondToChallenge'];
    if (dataResponse == null) {
      throw InstitutionConnectError('Unable to connect to server');
    } else {
      return InstitutionConnectResponse.fromJson(dataResponse);
    }
  }

  Future<List<InstitutionAccount>?> addAccounts({
    required List<String?> accountIds,
    required int? institutionKey,
  }) async {
    const document = r'''
    mutation institutionAddAccounts($input: InstitutionAddAccountsInput!){
      institutionAddAccounts(input: $input){
        institutionAccounts{
          accountId
          name
          portfolio{
            portfolioKey
          }
        }
      }
    }
    ''';

    final dynamic input = {
      'accountIds': accountIds,
      'institutionKey': institutionKey,
    };

    final queryOptions = iGraphqlProvider
        .createMutationOptions(document: document, variables: {'input': input});

    final res = await iGraphqlProvider.mutateWithOptions(queryOptions);
    if (res.hasException) {
      debugPrint(res.exception.toString());
    }
    final data = res.data?['institutionAddAccounts'];
    if (data == null) {
      return null;
    }

    final response = InstitutionAddAccountsResponse.fromJson(data);
    return response.institutionAccounts;
  }
}

class InstitutionError implements Exception {
  final dynamic message;

  const InstitutionError({this.message});

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception($runtimeType): $message";
  }
}

class InstitutionInvalidCreds extends InstitutionError {
  InstitutionInvalidCreds(String cause) : super(message: cause);
}

class InstitutionConnectError extends InstitutionError {
  InstitutionConnectError(String cause) : super(message: cause);
}

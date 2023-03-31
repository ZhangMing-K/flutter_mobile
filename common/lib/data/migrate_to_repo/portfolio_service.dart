import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

enum PORTFOLIO_CONNECT_RESULT {
  INVALID_CREDS,
  TWO_FACTOR_VERIFICATION,
  RESPOND_TO_CHALLENGE,
  SUCCESSFUL_LOGIN,
  SERVER_ERROR,
  INVALID_VERIFICATION_CODE,
}

class PortfolioConnectWrapper {
  String? deviceToken;
  String? challengeId;
  PORTFOLIO_CONNECT_RESULT portfolioConnectResult;
  String? errorMessage;
  List<AccountFromBroker>? brokerAccounts;
  Portfolio? portfolio;
  int? portfolioKey;
  PortfolioConnectWrapper(
      {this.deviceToken,
      this.challengeId,
      this.errorMessage,
      this.brokerAccounts,
      this.portfolioKey,
      this.portfolio,
      required this.portfolioConnectResult});
}

class PortfolioService extends GetxService {
  IGraphqlProvider iGraphqlProvider = Get.find();
  final portfolioResponseFragment = r'''
  fragment portfolioResponseFragment on PortfoliosGetResponse {
    portfolios{
      portfolioKey
      brokerName
      accountId
      followStats{
        numberOfFollowers
      }
      averageTradesPerMonth
      user{
        userKey
        firstName
        lastName
        verifiedAt
        verifiedText
        firstOrderAt
        profilePictureUrl
        portfolios{
          portfolioKey
        }
        avatar {
          avatarKey
          avatarName
          code
          url
        }
      }
      portfolioName
      authUserFollowInfo{
          followStatus
          watching
      }
      connectionStatus
      brokerConnection {
          dayHistorical : historicalV2(input:{span:DAY}){
            ...historicalSpanResponseFragment
          }
          positions{
          symbol
          stock{
            symbol
            companyName
          }
          asset{
            assetKey
            symbol
            name
            pictureUrl
          }
          orderGroupUUID
          positionType
          optionType
          averageBuyPrice
          currentPrice
          percentOfPortfolio
          percentOfPositions
          returnPercentage
          todayReturnPercentage
          optionInfo{
            optionType
            expiresAt
            strikePrice
          }
        }
      }
    }
  }
  ''';

  final historicalSpanResponseFragment = r'''
  fragment historicalSpanResponseFragment on Historical {
    returnPercentage
    closeAmount
    returnAmount
    historicalType
      points {
        closeAmount
        openAmount
        spanReturnPercentage
        spanReturnAmount
        beginsAt
        buyVolume
        sellVolume
      }
  }
  ''';

  Future<List<AccountFromBroker>?> brokerAccountsGet(int? portfolioKey) async {
    const document = r'''
      query brokerAccountsGet($input: AccountsBrokerInput) {
        brokerAccountsGet(input: $input) {
          brokerAccounts {
            accountId
            connected
            accountName
          }
        }
      }
    ''';
    final queryOptions =
        iGraphqlProvider.createQueryOptions(document: document, variables: {
      'input': {'portfolioKey': portfolioKey}
    });
    final res = await iGraphqlProvider
        .queryWithOptions(queryOptions)
        .catchError((e) {});

    final response = res?.data;
    if (response == null) {
      return null;
    }
    final data =
        AccountsBrokerResponse.fromJson(response['brokerAccountsGet'] ?? {});
    final brokerAccounts = data.brokerAccounts;
    return brokerAccounts;
  }

  Future<PortfolioConnectWrapper> connect(
      {required BROKER_NAME brokerName,
      String? username,
      String? password,
      String? oAuthKey,
      String? accountId,
      CHALLENGE_TYPE? challengeType}) async {
    const document = r'''
    mutation portfolioConnect($input: PortfolioConnectInput){
      portfolioConnect(input:$input) {
        deviceToken
        challengeId
        portfolioKey
        portfolio{
          portfolioKey
        }
        brokerAccounts {
          accountId
          accountName
          connected
        }
      }
    }
    ''';

    final variables = {
      'input': {
        'brokerName': describeEnum(brokerName),
        'username': username,
        'password': password,
        'oAuthKey': oAuthKey,
        'accountId': accountId,
      }
    };

    if (challengeType != null) {
      variables['input']!['challengeType'] = describeEnum(challengeType);
    }

    final options = iGraphqlProvider.createMutationOptions(
        document: document, variables: variables);

    try {
      final res = await iGraphqlProvider.mutateWithOptions(options);
      final data = res.data?['portfolioConnect'];
      final response = PortfolioConnectResponse.fromJson(data);

      if (response.deviceToken != null) {
        return PortfolioConnectWrapper(
            portfolioConnectResult:
                PORTFOLIO_CONNECT_RESULT.RESPOND_TO_CHALLENGE,
            challengeId: response.challengeId,
            deviceToken: response.deviceToken);
      } else if (response.brokerAccounts != null) {
        return PortfolioConnectWrapper(
          portfolioConnectResult: PORTFOLIO_CONNECT_RESULT.SUCCESSFUL_LOGIN,
          portfolioKey: response.portfolioKey,
          brokerAccounts: response.brokerAccounts,
        );
      }
      final portfolio = response.portfolio;

      return PortfolioConnectWrapper(
          portfolioConnectResult: PORTFOLIO_CONNECT_RESULT.SUCCESSFUL_LOGIN,
          portfolio: portfolio);
    } catch (error) {
      final err = error as List;
      final String errorString = err[0].toString();
      const invalidUsernameErrorMessage = 'Invalid username or password';
      const requiresVerification = 'Two factor verification required';
      if (errorString.contains(invalidUsernameErrorMessage)) {
        return PortfolioConnectWrapper(
            portfolioConnectResult: PORTFOLIO_CONNECT_RESULT.INVALID_CREDS,
            errorMessage: invalidUsernameErrorMessage);
      } else if (errorString.contains(requiresVerification)) {
        return PortfolioConnectWrapper(
            portfolioConnectResult:
                PORTFOLIO_CONNECT_RESULT.TWO_FACTOR_VERIFICATION);
      } else {
        return PortfolioConnectWrapper(
            portfolioConnectResult: PORTFOLIO_CONNECT_RESULT.SERVER_ERROR);
      }
    }
  }

  Future<Portfolio?> disconnect({int? portfolioKey}) async {
    const document = r'''
    mutation portfolioDisconnect($input: PortfolioDisconnectInput){
      portfolioDisconnect(input:$input) {
        portfolio{
          portfolioKey
          portfolioName
          brokerName
          connectionStatus
        }
      }
    }
    ''';

    final variables = {
      'input': {
        'portfolioKey': portfolioKey,
      }
    };

    final options = iGraphqlProvider.createMutationOptions(
        document: document, variables: variables);
    try {
      final res = await iGraphqlProvider.mutateWithOptions(options);
      final data = res.data!['portfolioDisconnect']['portfolio'];
      final Portfolio portfolio = Portfolio.fromJson(data);
      return portfolio;
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<User> getUserByKey(
      {required int userKey, required String requestedFields}) async {
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
    final res = await iGraphqlProvider.queryWithOptions(queryOptions);
    final userData = res!.data!['usersGet']['users'][0];
    final user = User.fromJson(userData);
    return user;
  }

  Future<List<Portfolio>?> linkAccounts(
      {required int? portfolioKey, required List<String?> accountIds}) async {
    const document = r'''
      mutation linkAccounts($input: LinkAccountsInput) {
        linkAccounts(input:$input) {
          portfolios {
            portfolioKey
            portfolioName
          }
        }
      }
    ''';
    final variables = {
      'input': {
        'portfolioKey': portfolioKey,
        'accountIds': accountIds,
      }
    };
    try {
      final options = iGraphqlProvider.createMutationOptions(
          document: document, variables: variables);
      final res = await iGraphqlProvider.mutateWithOptions(options);
      return LinkAccountsResponse.fromJson(res.data?['linkAccounts'] ?? {})
          .portfolios;
    } catch (err) {
      rethrow;
    }
  }

  Future<Portfolio?> portfolioAction(
      {required PORTFOLIO_ACTION action, required int? portfolioKey}) async {
    const document = r'''
      mutation portfolioAction($input: PortfolioActionInput){
        portfolioAction(input:$input) {
          portfolio{
            portfolioKey
            portfolioName
            authUserFollowInfo{
              followStatus
              watching
            }
          }
        }
      }
    ''';

    final variables = {
      'input': {
        'portfolioKey': portfolioKey,
        'action': describeEnum(action),
      }
    };
    try {
      final options = iGraphqlProvider.createMutationOptions(
          document: document, variables: variables);
      final res = await iGraphqlProvider.mutateWithOptions(options);
      final response =
          PortfolioActionResponse.fromJson(res.data?['portfolioAction'] ?? {});
      return response.portfolio;
    } catch (err) {
      rethrow;
    }
  }

  Future<Portfolio?> portfolioDelete({
    required int? portfolioKey,
  }) async {
    const document = r'''
    mutation portfolioDelete($input:PortfolioDeleteInput){
      portfolioDelete(input:$input){
        portfolio{
          portfolioKey
          portfolioName
          connectionStatus
          portfolioVisibilitySetting
        }
      }
    }
    ''';

    final input = {
      'portfolioKey': portfolioKey,
    };

    final options = iGraphqlProvider
        .createMutationOptions(document: document, variables: {'input': input});
    try {
      final res = await iGraphqlProvider.mutateWithOptions(options);
      final data = res.data!['portfolioDelete']['portfolio'];
      final Portfolio portfolio = Portfolio.fromJson(data);
      return portfolio;
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<Portfolio> portfolioGet(
      {required int? portfolioKey, String? requestedFields}) async {
    List<String>? fragments;

    if (requestedFields == null) {
      fragments = [portfolioResponseFragment, historicalSpanResponseFragment];
      requestedFields = '...portfolioResponseFragment';
    }

    final document = '''
      query portfoliosGet(\$input: PortfoliosGetInput) {
        portfoliosGet(input: \$input) {
          $requestedFields
        }
      }
    ''';

    final queryOptions = iGraphqlProvider.createQueryOptions(
        document: document,
        variables: {
          'input': {
            'portfolioKeys': [portfolioKey],
          },
        },
        fragments: fragments);

    try {
      final res = await iGraphqlProvider.queryWithOptions(queryOptions);
      if (res?.hasException ?? false) {
        if (res!.exception!.graphqlErrors[0].message.contains('Unauthorized')) {
          throw PortfolioDisconnectedException();
        } else {
          throw 'Unknown error';
        }
      }
      final portfolioData = res!.data!['portfoliosGet']['portfolios'][0];
      final Portfolio portfolio = Portfolio.fromJson(portfolioData);
      return portfolio;
    } catch (err) {
      rethrow;
    }
  }

  Future<Portfolio> portfoliosGet({required int portfolioKeys}) async {
    const document = r'''
      query portfoliosGet($input: PortfoliosGetInput) {
        portfoliosGet(input: $input) {
          ...portfolioResponseFragment
        }
      }
    ''';
    final queryOptions =
        iGraphqlProvider.createQueryOptions(document: document, variables: {
      'input': {
        'portfolioKeys': [portfolioKeys]
      }
    }, fragments: [
      portfolioResponseFragment,
      historicalSpanResponseFragment
    ]);
    final res = await iGraphqlProvider
        .queryWithOptions(queryOptions)
        .catchError((e) {});
    final portfolioData = res?.data?['portfoliosGet']['portfolios'][0];
    final Portfolio portfolio = Portfolio.fromJson(portfolioData);
    return portfolio;
  }

  Future<Portfolio?> portfolioUpdate({
    required int? portfolioKey,
    String? portfolioName,
    PORTFOLIO_VISIBILITY_SETTING? portfolioVisibilitySetting,
   // bool? showPreview,
  }) async {
    const document = r'''
    mutation portfolioUpdate($input:PortfolioUpdateInput){
      portfolioUpdate(input:$input){
        portfolio{
          portfolioKey
          portfolioName
          connectionStatus
          portfolioVisibilitySetting
        }
      }
    }
    ''';

    final input = {
      'portfolioKey': portfolioKey,
      'portfolioName': portfolioName,
     
    };

    if (portfolioVisibilitySetting != null) {
      input['portfolioVisibilitySetting'] =
          describeEnum(portfolioVisibilitySetting);
    }
    final options = iGraphqlProvider
        .createMutationOptions(document: document, variables: {'input': input});
    try {
      final res = await iGraphqlProvider.mutateWithOptions(options);
      final data = res.data!['portfolioUpdate']['portfolio'];
      final Portfolio portfolio = Portfolio.fromJson(data);
      return portfolio;
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<PortfolioConnectWrapper> respondToChallenge(
      {required String? username,
      required String? password,
      required String? challengeId,
      required String? deviceToken,
      required String verificationNumber}) async {
    const document = r'''
    mutation portfolioConnectRespondToChallenge($input: PortfolioConnectRespondToChallengeInput){
      portfolioConnectRespondToChallenge(input: $input) {
        message
        portfolio{
          portfolioKey
        }
      }
    }
    ''';

    final variables = {
      'input': {
        'username': username,
        'password': password,
        'challengeId': challengeId,
        'deviceToken': deviceToken,
        'verificationNumber': verificationNumber
      }
    };

    final options = iGraphqlProvider.createMutationOptions(
        document: document, variables: variables);

    try {
      final res = await iGraphqlProvider.mutateWithOptions(options);
      if (res.hasException) {
        debugPrint(res.exception.toString());
      }
      final data = res.data!['portfolioConnectRespondToChallenge']['portfolio'];
      Portfolio? portfolio;
      if (data != null) {
        portfolio = Portfolio.fromJson(data);
      }

      return PortfolioConnectWrapper(
          portfolioConnectResult: PORTFOLIO_CONNECT_RESULT.SUCCESSFUL_LOGIN,
          portfolio: portfolio);
    } catch (err) {
      debugPrint(err.toString());
      return PortfolioConnectWrapper(
          portfolioConnectResult:
              PORTFOLIO_CONNECT_RESULT.INVALID_VERIFICATION_CODE);
    }
  }
}

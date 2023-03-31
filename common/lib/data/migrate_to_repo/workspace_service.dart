import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class PortfolioArg {
  int? workspaceIntegrationPortfolioKey;
  bool? showAmounts;
  int? portfolioKey;
  bool? connect;
  bool? mute;

  PortfolioArg(
      {this.workspaceIntegrationPortfolioKey,
      this.showAmounts,
      this.portfolioKey,
      this.connect,
      this.mute});
}

class WorkspaceService extends GetxService {
  IGraphqlProvider iGraphqlProvider = Get.find();

  Future<Workspace?> getWorkspaceByKey(
      {required int workspaceKey, required String requestedFields}) async {
    var document = r'''
    query getWorkspaceByKey($workspaceKey: Int) {
        workspacesGet(input: {
          workspaceKeys: [$workspaceKey]
        }) {
          workspaces {
    ''';
    document += requestedFields;
    document += '}}}';
    final queryOptions = iGraphqlProvider.createQueryOptions(
        document: document, variables: {'workspaceKey': workspaceKey});
    try {
      final res = await iGraphqlProvider.queryWithOptions(queryOptions);
      if (res?.hasException ?? false) {
        debugPrint(res?.exception.toString());
      }

      final data = res?.data;
      if (data == null) {
        return null;
      }

      final workspaceData = data['workspacesGet']['workspaces'][0];
      final workspace = Workspace.fromJson(workspaceData);
      return workspace;
    } catch (err) {
      return null;
    }
  }

  Future<List<WorkspaceIntegrationPortfolio>?> removePortfoliosFromWorkspace(
      {required List<int> portfolioKeys, int? workspaceKey}) async {
    const document = r'''
        mutation workspacePortfolioUpsert($input: WorkspacePortfolioUpsertInput) {
          workspacePortfolioUpsert(input: $input) {
            workspaceIntegrationPortfolios {
              workspaceKey
            }
          }
        }
    ''';

    final Map<String, dynamic> input = {
      'portfolios': portfolioKeys.map((p) => {
            'portfolioKey': p,
            'connect': false,
          }),
      'workspaceKey': workspaceKey,
    };

    final _options = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});

    try {
      final res = await iGraphqlProvider.queryWithOptions(_options);
      if (res?.hasException ?? false) {
        throw 'Could not authenticate with provider';
      } else {
        final workspaceData = res!.data!['workspacePortfolioUpsert']
            ['workspaceIntegrationPortfolios'];
        final List<WorkspaceIntegrationPortfolio>
            workspacesIntegrationPortfolios =
            List<WorkspaceIntegrationPortfolio>.from(workspaceData
                .map((i) => WorkspaceIntegrationPortfolio.fromJson(i)));

        return workspacesIntegrationPortfolios;
      }
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<Workspace?> updateWorkspace(
      {required int? workspaceKey,
      bool? botEnabled,
      ORDER_POSTING_PERMISSIONS? orderPostingPermission,
      bool? setPermissionAsDefault}) async {
    const document = r'''
      mutation workspaceUpdate($input:WorkspaceUpdateInput){
        workspaceUpdate(input:$input) {
          workspace {
            workspaceKey
            name
            remoteId
            pictureUrl
            orderPostingPermission
            botEnabled
            authUserPermissionLevel
            authUserPortfolios {
              brokerName
              portfolioKey
              accountId
              connectionStatus
              portfolioName
            }
          }
        }
      }
    ''';

    final Map<String, dynamic> input = {'workspaceKey': workspaceKey};

    if (botEnabled != null) {
      input['botEnabled'] = botEnabled;
    }

    if (orderPostingPermission != null) {
      input['orderPostingPermissionOptions'] = {
        'orderPostingPermission': describeEnum(orderPostingPermission),
        'setDefault': setPermissionAsDefault
      };
    }

    final _options = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});

    try {
      final res = await iGraphqlProvider.queryWithOptions(_options);
      if (res?.hasException ?? false) {
        throw 'Could not authenticate with provider';
      } else {
        final workspaceData = res!.data!['workspaceUpdate']['workspace'];
        final workspace = Workspace.fromJson(workspaceData);
        return workspace;
      }
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<List<void>?> upsertPortfoliosInWorkspace(
      {required List<PortfolioArg> portfolioArgs, int? workspaceKey}) async {
    const document = r'''
        mutation workspacePortfolioUpsert($input: WorkspacePortfolioUpsertInput) {
          workspacePortfolioUpsert(input: $input) {
            workspaceIntegrationPortfolios {
              workspaceKey
            }
          }
        }
    ''';

    final args = portfolioArgs.map((p) => {
          'portfolioKey': p.portfolioKey,
          'connect': p.connect,
          'mute': p.mute,
          'showAmounts': p.showAmounts
        });

    final Map<String, dynamic> input = {
      'portfolios': [...args],
      'workspaceKey': workspaceKey,
    };

    final _options = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});

    try {
      final res = await iGraphqlProvider.queryWithOptions(_options);
      if (res?.hasException ?? false) {
        throw 'Could not authenticate with provider';
      } else {
        final workspaceData = res!.data!['workspacePortfolioUpsert']
            ['workspaceIntegrationPortfolios'];
        final List<WorkspaceIntegrationPortfolio>
            workspacesIntegrationPortfolios =
            List<WorkspaceIntegrationPortfolio>.from(workspaceData
                .map((i) => WorkspaceIntegrationPortfolio.fromJson(i)));
        // debugPrint(workspacesIntegrationPortfolios);
        return workspacesIntegrationPortfolios;
      }
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<List<Integration>?> workspaceConnect(
      {required String? token,
      required WORKSPACE_SOURCE source,
      String? guildId,
      required ORDER_POSTING_PERMISSIONS orderPostingPermission,
      int? integrationKey}) async {
    const document = r'''
        query workspaceConnect($input: WorkspaceConnectInput, $integrationInput: IntegrationsInput) {
          workspaceConnect(input: $input) {
            user {
              userKey
              integrations(input: $integrationInput) {
                integrationKey
                source
                username
                token
              }
            }
          }
        }
    ''';

    final Map<String, dynamic> input = {
      'token': token,
      'remoteId': guildId,
      'source': describeEnum(source),
      'orderPostingPermission': describeEnum(orderPostingPermission),
    };

    final SOCIAL_SOURCE socialSource = convertWorkspaceToSocial(source);
    final socials = [describeEnum(socialSource)];

    final Map<String, dynamic> integrationInput = {
      'sources': [...socials]
    };

    final _options = iGraphqlProvider.createQueryOptions(
        document: document,
        variables: {'input': input, 'integrationInput': integrationInput});

    try {
      final res = await iGraphqlProvider.queryWithOptions(_options);
      if (res?.hasException ?? false) {
        if (res!.exception!.graphqlErrors.isNotEmpty) {
          throw res.exception!.graphqlErrors[0].message;
        }
      } else {
        final userData = res!.data!['workspaceConnect']['user'];
        final User user = User.fromJson(userData);
        return user.integrations;
      }
    } catch (err) {
      rethrow;
    }
    return null;
  }

  Future<List<Workspace>?> workspacesGet(
      {bool? botEnabled,
      List<WORKSPACE_SOURCE>? workspaceTypes,
      List<int>? portfolioKeys}) async {
    const document = r'''
        query workspacesGet($input: WorkspacesGetInput) {
          workspacesGet(input: $input) {
            workspaces {
              workspaceKey
              name
              parent {
                workspaceKey
                name
              }
            }
          }
        }
    ''';

    final workspaceTypesToInclude =
        workspaceTypes?.map((e) => describeEnum(e)) ?? [];

    final Map<String, dynamic> input = {
      'botEnabled': botEnabled,
      'portfolioKeys': portfolioKeys ?? [],
      'workspaceTypes': [...workspaceTypesToInclude],
    };

    final _options = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});

    try {
      final res = await iGraphqlProvider.queryWithOptions(_options);
      if (res?.hasException ?? false) {
        debugPrint(res?.exception.toString());
        return null;
      } else {
        final workspaceData = res!.data!['workspacesGet']['workspaces'];
        final List<Workspace> workspaces = List<Workspace>.from(
            workspaceData.map((i) => Workspace.fromJson(i)));

        return workspaces;
      }
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  Future<bool?> workspacesSync({
    int? integrationKey,
  }) async {
    const document = r'''
      mutation workspacesSync($input:WorkspacesSyncInput!) {
        workspacesSync(input:$input) {
          success
        }
      }
    ''';

    final Map<String, dynamic> input = {'integrationKey': integrationKey};

    final _options = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});

    try {
      final res = await iGraphqlProvider.queryWithOptions(_options);
      if (res?.hasException ?? false) {
        debugPrint(res?.exception.toString());
        return null;
      } else {
        final bool? success = res!.data!['workspacesSync']['success'];
        return success;
      }
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }
}

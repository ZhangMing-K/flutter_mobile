import 'package:iris_common/data/models/enums/workspace_source.dart';
import 'package:iris_common/data/models/enums/workspace_type.dart';
import 'package:iris_common/data/models/enums/order_posting_permissions.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/workspace_integration.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/enums/permission_level.dart';
import 'package:collection/collection.dart';

class Workspace {
  final int? workspaceKey;
  final int? parentKey;
  final String? remoteId;
  final String? name;
  final WORKSPACE_SOURCE? source;
  final WORKSPACE_TYPE? workspaceType;
  final ORDER_POSTING_PERMISSIONS? orderPostingPermission;
  final String? pictureUrl;
  final bool? botEnabled;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? botJoinedAt;
  final int? addedByUserKey;
  final User? addedByUser;
  final Workspace? parent;
  final Workspace? globalParent;
  final List<WorkspaceIntegration>? workspaceIntegrations;
  final List<User>? users;
  final List<Portfolio>? portfolios;
  final List<Portfolio>? authUserPortfolios;
  final PERMISSION_LEVEL? authUserPermissionLevel;
  final List<Workspace>? children;
  final List<Workspace>? globalChildren;
  final List<Workspace>? authUserChildren;
  final List<Workspace>? workspacesWithoutBot;
  final int? nbrWorkspacesWithoutBot;
  const Workspace(
      {this.workspaceKey,
      this.parentKey,
      this.remoteId,
      this.name,
      this.source,
      this.workspaceType,
      this.orderPostingPermission,
      this.pictureUrl,
      this.botEnabled,
      this.createdAt,
      this.deletedAt,
      this.botJoinedAt,
      this.addedByUserKey,
      this.addedByUser,
      this.parent,
      this.globalParent,
      this.workspaceIntegrations,
      this.users,
      this.portfolios,
      this.authUserPortfolios,
      this.authUserPermissionLevel,
      this.children,
      this.globalChildren,
      this.authUserChildren,
      this.workspacesWithoutBot,
      this.nbrWorkspacesWithoutBot});
  Workspace copyWith(
      {int? workspaceKey,
      int? parentKey,
      String? remoteId,
      String? name,
      WORKSPACE_SOURCE? source,
      WORKSPACE_TYPE? workspaceType,
      ORDER_POSTING_PERMISSIONS? orderPostingPermission,
      String? pictureUrl,
      bool? botEnabled,
      DateTime? createdAt,
      DateTime? deletedAt,
      DateTime? botJoinedAt,
      int? addedByUserKey,
      User? addedByUser,
      Workspace? parent,
      Workspace? globalParent,
      List<WorkspaceIntegration>? workspaceIntegrations,
      List<User>? users,
      List<Portfolio>? portfolios,
      List<Portfolio>? authUserPortfolios,
      PERMISSION_LEVEL? authUserPermissionLevel,
      List<Workspace>? children,
      List<Workspace>? globalChildren,
      List<Workspace>? authUserChildren,
      List<Workspace>? workspacesWithoutBot,
      int? nbrWorkspacesWithoutBot}) {
    return Workspace(
      workspaceKey: workspaceKey ?? this.workspaceKey,
      parentKey: parentKey ?? this.parentKey,
      remoteId: remoteId ?? this.remoteId,
      name: name ?? this.name,
      source: source ?? this.source,
      workspaceType: workspaceType ?? this.workspaceType,
      orderPostingPermission:
          orderPostingPermission ?? this.orderPostingPermission,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      botEnabled: botEnabled ?? this.botEnabled,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      botJoinedAt: botJoinedAt ?? this.botJoinedAt,
      addedByUserKey: addedByUserKey ?? this.addedByUserKey,
      addedByUser: addedByUser ?? this.addedByUser,
      parent: parent ?? this.parent,
      globalParent: globalParent ?? this.globalParent,
      workspaceIntegrations:
          workspaceIntegrations ?? this.workspaceIntegrations,
      users: users ?? this.users,
      portfolios: portfolios ?? this.portfolios,
      authUserPortfolios: authUserPortfolios ?? this.authUserPortfolios,
      authUserPermissionLevel:
          authUserPermissionLevel ?? this.authUserPermissionLevel,
      children: children ?? this.children,
      globalChildren: globalChildren ?? this.globalChildren,
      authUserChildren: authUserChildren ?? this.authUserChildren,
      workspacesWithoutBot: workspacesWithoutBot ?? this.workspacesWithoutBot,
      nbrWorkspacesWithoutBot:
          nbrWorkspacesWithoutBot ?? this.nbrWorkspacesWithoutBot,
    );
  }

  factory Workspace.fromJson(Map<String, dynamic> json) {
    return Workspace(
      workspaceKey: json['workspaceKey'],
      parentKey: json['parentKey'],
      remoteId: json['remoteId'],
      name: json['name'],
      source: json['source'] != null
          ? WORKSPACE_SOURCE.values.byName(json['source'])
          : null,
      workspaceType: json['workspaceType'] != null
          ? WORKSPACE_TYPE.values.byName(json['workspaceType'])
          : null,
      orderPostingPermission: json['orderPostingPermission'] != null
          ? ORDER_POSTING_PERMISSIONS.values
              .byName(json['orderPostingPermission'])
          : null,
      pictureUrl: json['pictureUrl'],
      botEnabled: json['botEnabled'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      botJoinedAt: json['botJoinedAt'] != null
          ? DateTime.parse(json['botJoinedAt'])
          : null,
      addedByUserKey: json['addedByUserKey'],
      addedByUser: json['addedByUser'] != null
          ? User.fromJson(json['addedByUser'])
          : null,
      parent:
          json['parent'] != null ? Workspace.fromJson(json['parent']) : null,
      globalParent: json['globalParent'] != null
          ? Workspace.fromJson(json['globalParent'])
          : null,
      workspaceIntegrations: json['workspaceIntegrations']
          ?.map<WorkspaceIntegration>((o) => WorkspaceIntegration.fromJson(o))
          .toList(),
      users: json['users']?.map<User>((o) => User.fromJson(o)).toList(),
      portfolios: json['portfolios']
          ?.map<Portfolio>((o) => Portfolio.fromJson(o))
          .toList(),
      authUserPortfolios: json['authUserPortfolios']
          ?.map<Portfolio>((o) => Portfolio.fromJson(o))
          .toList(),
      authUserPermissionLevel: json['authUserPermissionLevel'] != null
          ? PERMISSION_LEVEL.values.byName(json['authUserPermissionLevel'])
          : null,
      children: json['children']
          ?.map<Workspace>((o) => Workspace.fromJson(o))
          .toList(),
      globalChildren: json['globalChildren']
          ?.map<Workspace>((o) => Workspace.fromJson(o))
          .toList(),
      authUserChildren: json['authUserChildren']
          ?.map<Workspace>((o) => Workspace.fromJson(o))
          .toList(),
      workspacesWithoutBot: json['workspacesWithoutBot']
          ?.map<Workspace>((o) => Workspace.fromJson(o))
          .toList(),
      nbrWorkspacesWithoutBot: json['nbrWorkspacesWithoutBot'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['workspaceKey'] = workspaceKey;
    data['parentKey'] = parentKey;
    data['remoteId'] = remoteId;
    data['name'] = name;
    data['source'] = source?.name;
    data['workspaceType'] = workspaceType?.name;
    data['orderPostingPermission'] = orderPostingPermission?.name;
    data['pictureUrl'] = pictureUrl;
    data['botEnabled'] = botEnabled;
    data['createdAt'] = createdAt?.toString();
    data['deletedAt'] = deletedAt?.toString();
    data['botJoinedAt'] = botJoinedAt?.toString();
    data['addedByUserKey'] = addedByUserKey;
    data['addedByUser'] = addedByUser?.toJson();
    data['parent'] = parent?.toJson();
    data['globalParent'] = globalParent?.toJson();
    data['workspaceIntegrations'] =
        workspaceIntegrations?.map((item) => item.toJson()).toList();
    data['users'] = users?.map((item) => item.toJson()).toList();
    data['portfolios'] = portfolios?.map((item) => item.toJson()).toList();
    data['authUserPortfolios'] =
        authUserPortfolios?.map((item) => item.toJson()).toList();
    data['authUserPermissionLevel'] = authUserPermissionLevel?.name;
    data['children'] = children?.map((item) => item.toJson()).toList();
    data['globalChildren'] =
        globalChildren?.map((item) => item.toJson()).toList();
    data['authUserChildren'] =
        authUserChildren?.map((item) => item.toJson()).toList();
    data['workspacesWithoutBot'] =
        workspacesWithoutBot?.map((item) => item.toJson()).toList();
    data['nbrWorkspacesWithoutBot'] = nbrWorkspacesWithoutBot;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Workspace &&
            (identical(other.workspaceKey, workspaceKey) ||
                const DeepCollectionEquality()
                    .equals(other.workspaceKey, workspaceKey)) &&
            (identical(other.parentKey, parentKey) ||
                const DeepCollectionEquality()
                    .equals(other.parentKey, parentKey)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.workspaceType, workspaceType) ||
                const DeepCollectionEquality()
                    .equals(other.workspaceType, workspaceType)) &&
            (identical(other.orderPostingPermission, orderPostingPermission) ||
                const DeepCollectionEquality().equals(
                    other.orderPostingPermission, orderPostingPermission)) &&
            (identical(other.pictureUrl, pictureUrl) ||
                const DeepCollectionEquality()
                    .equals(other.pictureUrl, pictureUrl)) &&
            (identical(other.botEnabled, botEnabled) ||
                const DeepCollectionEquality()
                    .equals(other.botEnabled, botEnabled)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.deletedAt, deletedAt) ||
                const DeepCollectionEquality()
                    .equals(other.deletedAt, deletedAt)) &&
            (identical(other.botJoinedAt, botJoinedAt) ||
                const DeepCollectionEquality()
                    .equals(other.botJoinedAt, botJoinedAt)) &&
            (identical(other.addedByUserKey, addedByUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.addedByUserKey, addedByUserKey)) &&
            (identical(other.addedByUser, addedByUser) ||
                const DeepCollectionEquality()
                    .equals(other.addedByUser, addedByUser)) &&
            (identical(other.parent, parent) ||
                const DeepCollectionEquality().equals(other.parent, parent)) &&
            (identical(other.globalParent, globalParent) ||
                const DeepCollectionEquality()
                    .equals(other.globalParent, globalParent)) &&
            (identical(other.workspaceIntegrations, workspaceIntegrations) ||
                const DeepCollectionEquality().equals(
                    other.workspaceIntegrations, workspaceIntegrations)) &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)) &&
            (identical(other.portfolios, portfolios) ||
                const DeepCollectionEquality()
                    .equals(other.portfolios, portfolios)) &&
            (identical(other.authUserPortfolios, authUserPortfolios) ||
                const DeepCollectionEquality()
                    .equals(other.authUserPortfolios, authUserPortfolios)) &&
            (identical(other.authUserPermissionLevel, authUserPermissionLevel) ||
                const DeepCollectionEquality().equals(
                    other.authUserPermissionLevel, authUserPermissionLevel)) &&
            (identical(other.children, children) ||
                const DeepCollectionEquality()
                    .equals(other.children, children)) &&
            (identical(other.globalChildren, globalChildren) ||
                const DeepCollectionEquality()
                    .equals(other.globalChildren, globalChildren)) &&
            (identical(other.authUserChildren, authUserChildren) || const DeepCollectionEquality().equals(other.authUserChildren, authUserChildren)) &&
            (identical(other.workspacesWithoutBot, workspacesWithoutBot) || const DeepCollectionEquality().equals(other.workspacesWithoutBot, workspacesWithoutBot)) &&
            (identical(other.nbrWorkspacesWithoutBot, nbrWorkspacesWithoutBot) || const DeepCollectionEquality().equals(other.nbrWorkspacesWithoutBot, nbrWorkspacesWithoutBot)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(workspaceKey) ^
        const DeepCollectionEquality().hash(parentKey) ^
        const DeepCollectionEquality().hash(remoteId) ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(source) ^
        const DeepCollectionEquality().hash(workspaceType) ^
        const DeepCollectionEquality().hash(orderPostingPermission) ^
        const DeepCollectionEquality().hash(pictureUrl) ^
        const DeepCollectionEquality().hash(botEnabled) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(deletedAt) ^
        const DeepCollectionEquality().hash(botJoinedAt) ^
        const DeepCollectionEquality().hash(addedByUserKey) ^
        const DeepCollectionEquality().hash(addedByUser) ^
        const DeepCollectionEquality().hash(parent) ^
        const DeepCollectionEquality().hash(globalParent) ^
        const DeepCollectionEquality().hash(workspaceIntegrations) ^
        const DeepCollectionEquality().hash(users) ^
        const DeepCollectionEquality().hash(portfolios) ^
        const DeepCollectionEquality().hash(authUserPortfolios) ^
        const DeepCollectionEquality().hash(authUserPermissionLevel) ^
        const DeepCollectionEquality().hash(children) ^
        const DeepCollectionEquality().hash(globalChildren) ^
        const DeepCollectionEquality().hash(authUserChildren) ^
        const DeepCollectionEquality().hash(workspacesWithoutBot) ^
        const DeepCollectionEquality().hash(nbrWorkspacesWithoutBot);
  }

  @override
  String toString() => 'Workspace(${toJson()})';
}

import 'package:iris_common/data/models/enums/permission_level.dart';
import 'package:iris_common/data/models/output/workspace.dart';
import 'package:iris_common/data/models/output/integration.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class WorkspaceIntegration {
  final int? workspaceIntegrationKey;
  final int? integrationKey;
  final int? workspaceKey;
  final int? userKey;
  final PERMISSION_LEVEL? permissionLevel;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Workspace? workspace;
  final Integration? integration;
  final User? user;
  const WorkspaceIntegration(
      {this.workspaceIntegrationKey,
      this.integrationKey,
      this.workspaceKey,
      this.userKey,
      this.permissionLevel,
      this.createdAt,
      this.updatedAt,
      this.workspace,
      this.integration,
      this.user});
  WorkspaceIntegration copyWith(
      {int? workspaceIntegrationKey,
      int? integrationKey,
      int? workspaceKey,
      int? userKey,
      PERMISSION_LEVEL? permissionLevel,
      DateTime? createdAt,
      DateTime? updatedAt,
      Workspace? workspace,
      Integration? integration,
      User? user}) {
    return WorkspaceIntegration(
      workspaceIntegrationKey:
          workspaceIntegrationKey ?? this.workspaceIntegrationKey,
      integrationKey: integrationKey ?? this.integrationKey,
      workspaceKey: workspaceKey ?? this.workspaceKey,
      userKey: userKey ?? this.userKey,
      permissionLevel: permissionLevel ?? this.permissionLevel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      workspace: workspace ?? this.workspace,
      integration: integration ?? this.integration,
      user: user ?? this.user,
    );
  }

  factory WorkspaceIntegration.fromJson(Map<String, dynamic> json) {
    return WorkspaceIntegration(
      workspaceIntegrationKey: json['workspaceIntegrationKey'],
      integrationKey: json['integrationKey'],
      workspaceKey: json['workspaceKey'],
      userKey: json['userKey'],
      permissionLevel: json['permissionLevel'] != null
          ? PERMISSION_LEVEL.values.byName(json['permissionLevel'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      workspace: json['workspace'] != null
          ? Workspace.fromJson(json['workspace'])
          : null,
      integration: json['integration'] != null
          ? Integration.fromJson(json['integration'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['workspaceIntegrationKey'] = workspaceIntegrationKey;
    data['integrationKey'] = integrationKey;
    data['workspaceKey'] = workspaceKey;
    data['userKey'] = userKey;
    data['permissionLevel'] = permissionLevel?.name;
    data['createdAt'] = createdAt?.toString();
    data['updatedAt'] = updatedAt?.toString();
    data['workspace'] = workspace?.toJson();
    data['integration'] = integration?.toJson();
    data['user'] = user?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkspaceIntegration &&
            (identical(
                    other.workspaceIntegrationKey, workspaceIntegrationKey) ||
                const DeepCollectionEquality().equals(
                    other.workspaceIntegrationKey, workspaceIntegrationKey)) &&
            (identical(other.integrationKey, integrationKey) ||
                const DeepCollectionEquality()
                    .equals(other.integrationKey, integrationKey)) &&
            (identical(other.workspaceKey, workspaceKey) ||
                const DeepCollectionEquality()
                    .equals(other.workspaceKey, workspaceKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.permissionLevel, permissionLevel) ||
                const DeepCollectionEquality()
                    .equals(other.permissionLevel, permissionLevel)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.workspace, workspace) ||
                const DeepCollectionEquality()
                    .equals(other.workspace, workspace)) &&
            (identical(other.integration, integration) ||
                const DeepCollectionEquality()
                    .equals(other.integration, integration)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(workspaceIntegrationKey) ^
        const DeepCollectionEquality().hash(integrationKey) ^
        const DeepCollectionEquality().hash(workspaceKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(permissionLevel) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(updatedAt) ^
        const DeepCollectionEquality().hash(workspace) ^
        const DeepCollectionEquality().hash(integration) ^
        const DeepCollectionEquality().hash(user);
  }

  @override
  String toString() => 'WorkspaceIntegration(${toJson()})';
}

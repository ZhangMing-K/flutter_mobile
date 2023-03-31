import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/workspace.dart';
import 'package:collection/collection.dart';

class WorkspaceIntegrationPortfolio {
  final int? workspaceIntegrationPortfolioKey;
  final int? portfolioKey;
  final int? workspaceKey;
  final int? userKey;
  final bool? showAmounts;
  final int? deletedByUserKey;
  final DateTime? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? mutedAt;
  final Portfolio? portfolio;
  final User? user;
  final User? deletedByUser;
  final Workspace? workspace;
  const WorkspaceIntegrationPortfolio(
      {this.workspaceIntegrationPortfolioKey,
      this.portfolioKey,
      this.workspaceKey,
      this.userKey,
      this.showAmounts,
      this.deletedByUserKey,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.mutedAt,
      this.portfolio,
      this.user,
      this.deletedByUser,
      this.workspace});
  WorkspaceIntegrationPortfolio copyWith(
      {int? workspaceIntegrationPortfolioKey,
      int? portfolioKey,
      int? workspaceKey,
      int? userKey,
      bool? showAmounts,
      int? deletedByUserKey,
      DateTime? deletedAt,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? mutedAt,
      Portfolio? portfolio,
      User? user,
      User? deletedByUser,
      Workspace? workspace}) {
    return WorkspaceIntegrationPortfolio(
      workspaceIntegrationPortfolioKey: workspaceIntegrationPortfolioKey ??
          this.workspaceIntegrationPortfolioKey,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      workspaceKey: workspaceKey ?? this.workspaceKey,
      userKey: userKey ?? this.userKey,
      showAmounts: showAmounts ?? this.showAmounts,
      deletedByUserKey: deletedByUserKey ?? this.deletedByUserKey,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      mutedAt: mutedAt ?? this.mutedAt,
      portfolio: portfolio ?? this.portfolio,
      user: user ?? this.user,
      deletedByUser: deletedByUser ?? this.deletedByUser,
      workspace: workspace ?? this.workspace,
    );
  }

  factory WorkspaceIntegrationPortfolio.fromJson(Map<String, dynamic> json) {
    return WorkspaceIntegrationPortfolio(
      workspaceIntegrationPortfolioKey:
          json['workspaceIntegrationPortfolioKey'],
      portfolioKey: json['portfolioKey'],
      workspaceKey: json['workspaceKey'],
      userKey: json['userKey'],
      showAmounts: json['showAmounts'],
      deletedByUserKey: json['deletedByUserKey'],
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      mutedAt: json['mutedAt'] != null ? DateTime.parse(json['mutedAt']) : null,
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      deletedByUser: json['deletedByUser'] != null
          ? User.fromJson(json['deletedByUser'])
          : null,
      workspace: json['workspace'] != null
          ? Workspace.fromJson(json['workspace'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['workspaceIntegrationPortfolioKey'] = workspaceIntegrationPortfolioKey;
    data['portfolioKey'] = portfolioKey;
    data['workspaceKey'] = workspaceKey;
    data['userKey'] = userKey;
    data['showAmounts'] = showAmounts;
    data['deletedByUserKey'] = deletedByUserKey;
    data['deletedAt'] = deletedAt?.toString();
    data['createdAt'] = createdAt?.toString();
    data['updatedAt'] = updatedAt?.toString();
    data['mutedAt'] = mutedAt?.toString();
    data['portfolio'] = portfolio?.toJson();
    data['user'] = user?.toJson();
    data['deletedByUser'] = deletedByUser?.toJson();
    data['workspace'] = workspace?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkspaceIntegrationPortfolio &&
            (identical(other.workspaceIntegrationPortfolioKey,
                    workspaceIntegrationPortfolioKey) ||
                const DeepCollectionEquality().equals(
                    other.workspaceIntegrationPortfolioKey,
                    workspaceIntegrationPortfolioKey)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.workspaceKey, workspaceKey) ||
                const DeepCollectionEquality()
                    .equals(other.workspaceKey, workspaceKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.showAmounts, showAmounts) ||
                const DeepCollectionEquality()
                    .equals(other.showAmounts, showAmounts)) &&
            (identical(other.deletedByUserKey, deletedByUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.deletedByUserKey, deletedByUserKey)) &&
            (identical(other.deletedAt, deletedAt) ||
                const DeepCollectionEquality()
                    .equals(other.deletedAt, deletedAt)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.mutedAt, mutedAt) ||
                const DeepCollectionEquality()
                    .equals(other.mutedAt, mutedAt)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.deletedByUser, deletedByUser) ||
                const DeepCollectionEquality()
                    .equals(other.deletedByUser, deletedByUser)) &&
            (identical(other.workspace, workspace) ||
                const DeepCollectionEquality()
                    .equals(other.workspace, workspace)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(workspaceIntegrationPortfolioKey) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(workspaceKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(showAmounts) ^
        const DeepCollectionEquality().hash(deletedByUserKey) ^
        const DeepCollectionEquality().hash(deletedAt) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(updatedAt) ^
        const DeepCollectionEquality().hash(mutedAt) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(deletedByUser) ^
        const DeepCollectionEquality().hash(workspace);
  }

  @override
  String toString() => 'WorkspaceIntegrationPortfolio(${toJson()})';
}

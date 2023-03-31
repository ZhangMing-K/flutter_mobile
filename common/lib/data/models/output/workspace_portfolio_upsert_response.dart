import 'package:iris_common/data/models/output/workspace_integration_portfolio.dart';
import 'package:collection/collection.dart';

class WorkspacePortfolioUpsertResponse {
  final List<WorkspaceIntegrationPortfolio>? workspaceIntegrationPortfolios;
  const WorkspacePortfolioUpsertResponse({this.workspaceIntegrationPortfolios});
  WorkspacePortfolioUpsertResponse copyWith(
      {List<WorkspaceIntegrationPortfolio>? workspaceIntegrationPortfolios}) {
    return WorkspacePortfolioUpsertResponse(
      workspaceIntegrationPortfolios:
          workspaceIntegrationPortfolios ?? this.workspaceIntegrationPortfolios,
    );
  }

  factory WorkspacePortfolioUpsertResponse.fromJson(Map<String, dynamic> json) {
    return WorkspacePortfolioUpsertResponse(
      workspaceIntegrationPortfolios: json['workspaceIntegrationPortfolios']
          ?.map<WorkspaceIntegrationPortfolio>(
              (o) => WorkspaceIntegrationPortfolio.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['workspaceIntegrationPortfolios'] =
        workspaceIntegrationPortfolios?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkspacePortfolioUpsertResponse &&
            (identical(other.workspaceIntegrationPortfolios,
                    workspaceIntegrationPortfolios) ||
                const DeepCollectionEquality().equals(
                    other.workspaceIntegrationPortfolios,
                    workspaceIntegrationPortfolios)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(workspaceIntegrationPortfolios);
  }

  @override
  String toString() => 'WorkspacePortfolioUpsertResponse(${toJson()})';
}

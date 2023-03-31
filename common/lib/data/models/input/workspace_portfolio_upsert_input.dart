import 'package:iris_common/data/models/input/portfolio_args.dart';
import 'package:collection/collection.dart';

class WorkspacePortfolioUpsertInput {
  final List<PortfolioArgs>? portfolios;
  final int? workspaceKey;
  const WorkspacePortfolioUpsertInput({this.portfolios, this.workspaceKey});
  WorkspacePortfolioUpsertInput copyWith(
      {List<PortfolioArgs>? portfolios, int? workspaceKey}) {
    return WorkspacePortfolioUpsertInput(
      portfolios: portfolios ?? this.portfolios,
      workspaceKey: workspaceKey ?? this.workspaceKey,
    );
  }

  factory WorkspacePortfolioUpsertInput.fromJson(Map<String, dynamic> json) {
    return WorkspacePortfolioUpsertInput(
      portfolios: json['portfolios']
          ?.map<PortfolioArgs>((o) => PortfolioArgs.fromJson(o))
          .toList(),
      workspaceKey: json['workspaceKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolios'] = portfolios?.map((item) => item.toJson()).toList();
    data['workspaceKey'] = workspaceKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkspacePortfolioUpsertInput &&
            (identical(other.portfolios, portfolios) ||
                const DeepCollectionEquality()
                    .equals(other.portfolios, portfolios)) &&
            (identical(other.workspaceKey, workspaceKey) ||
                const DeepCollectionEquality()
                    .equals(other.workspaceKey, workspaceKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolios) ^
        const DeepCollectionEquality().hash(workspaceKey);
  }

  @override
  String toString() => 'WorkspacePortfolioUpsertInput(${toJson()})';
}

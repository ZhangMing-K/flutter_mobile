import 'package:collection/collection.dart';

class PortfolioArgs {
  final int? workspaceIntegrationPortfolioKey;
  final bool? showAmounts;
  final int? portfolioKey;
  final bool? connect;
  final bool? mute;
  const PortfolioArgs(
      {this.workspaceIntegrationPortfolioKey,
      this.showAmounts,
      this.portfolioKey,
      this.connect,
      this.mute});
  PortfolioArgs copyWith(
      {int? workspaceIntegrationPortfolioKey,
      bool? showAmounts,
      int? portfolioKey,
      bool? connect,
      bool? mute}) {
    return PortfolioArgs(
      workspaceIntegrationPortfolioKey: workspaceIntegrationPortfolioKey ??
          this.workspaceIntegrationPortfolioKey,
      showAmounts: showAmounts ?? this.showAmounts,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      connect: connect ?? this.connect,
      mute: mute ?? this.mute,
    );
  }

  factory PortfolioArgs.fromJson(Map<String, dynamic> json) {
    return PortfolioArgs(
      workspaceIntegrationPortfolioKey:
          json['workspaceIntegrationPortfolioKey'],
      showAmounts: json['showAmounts'],
      portfolioKey: json['portfolioKey'],
      connect: json['connect'],
      mute: json['mute'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['workspaceIntegrationPortfolioKey'] = workspaceIntegrationPortfolioKey;
    data['showAmounts'] = showAmounts;
    data['portfolioKey'] = portfolioKey;
    data['connect'] = connect;
    data['mute'] = mute;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioArgs &&
            (identical(other.workspaceIntegrationPortfolioKey,
                    workspaceIntegrationPortfolioKey) ||
                const DeepCollectionEquality().equals(
                    other.workspaceIntegrationPortfolioKey,
                    workspaceIntegrationPortfolioKey)) &&
            (identical(other.showAmounts, showAmounts) ||
                const DeepCollectionEquality()
                    .equals(other.showAmounts, showAmounts)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.connect, connect) ||
                const DeepCollectionEquality()
                    .equals(other.connect, connect)) &&
            (identical(other.mute, mute) ||
                const DeepCollectionEquality().equals(other.mute, mute)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(workspaceIntegrationPortfolioKey) ^
        const DeepCollectionEquality().hash(showAmounts) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(connect) ^
        const DeepCollectionEquality().hash(mute);
  }

  @override
  String toString() => 'PortfolioArgs(${toJson()})';
}

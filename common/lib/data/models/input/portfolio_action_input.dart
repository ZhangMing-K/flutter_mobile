import 'package:iris_common/data/models/enums/portfolio_action.dart';
import 'package:collection/collection.dart';

class PortfolioActionInput {
  final int? portfolioKey;
  final PORTFOLIO_ACTION? action;
  const PortfolioActionInput({required this.portfolioKey, this.action});
  PortfolioActionInput copyWith({int? portfolioKey, PORTFOLIO_ACTION? action}) {
    return PortfolioActionInput(
      portfolioKey: portfolioKey ?? this.portfolioKey,
      action: action ?? this.action,
    );
  }

  factory PortfolioActionInput.fromJson(Map<String, dynamic> json) {
    return PortfolioActionInput(
      portfolioKey: json['portfolioKey'],
      action: json['action'] != null
          ? PORTFOLIO_ACTION.values.byName(json['action'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolioKey'] = portfolioKey;
    data['action'] = action?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioActionInput &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.action, action) ||
                const DeepCollectionEquality().equals(other.action, action)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(action);
  }

  @override
  String toString() => 'PortfolioActionInput(${toJson()})';
}

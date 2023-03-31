import 'package:iris_common/data/models/enums/broker_name.dart';
import 'package:iris_common/data/models/enums/portfolio_queue_action.dart';
import 'package:collection/collection.dart';

class PortfolioManageActionInput {
  final bool? force;
  final bool? global;
  final List<int>? portfolioKeys;
  final List<int>? userKeys;
  final List<int>? assetKeys;
  final List<BROKER_NAME>? brokerNames;
  final PORTFOLIO_QUEUE_ACTION? portfolioQueueAction;
  final int? limit;
  final int? offset;
  final List<String>? symbols;
  const PortfolioManageActionInput(
      {this.force,
      this.global,
      this.portfolioKeys,
      this.userKeys,
      this.assetKeys,
      this.brokerNames,
      this.portfolioQueueAction,
      this.limit,
      this.offset,
      this.symbols});
  PortfolioManageActionInput copyWith(
      {bool? force,
      bool? global,
      List<int>? portfolioKeys,
      List<int>? userKeys,
      List<int>? assetKeys,
      List<BROKER_NAME>? brokerNames,
      PORTFOLIO_QUEUE_ACTION? portfolioQueueAction,
      int? limit,
      int? offset,
      List<String>? symbols}) {
    return PortfolioManageActionInput(
      force: force ?? this.force,
      global: global ?? this.global,
      portfolioKeys: portfolioKeys ?? this.portfolioKeys,
      userKeys: userKeys ?? this.userKeys,
      assetKeys: assetKeys ?? this.assetKeys,
      brokerNames: brokerNames ?? this.brokerNames,
      portfolioQueueAction: portfolioQueueAction ?? this.portfolioQueueAction,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      symbols: symbols ?? this.symbols,
    );
  }

  factory PortfolioManageActionInput.fromJson(Map<String, dynamic> json) {
    return PortfolioManageActionInput(
      force: json['force'],
      global: json['global'],
      portfolioKeys:
          json['portfolioKeys']?.map<int>((o) => (o as int)).toList(),
      userKeys: json['userKeys']?.map<int>((o) => (o as int)).toList(),
      assetKeys: json['assetKeys']?.map<int>((o) => (o as int)).toList(),
      brokerNames: json['brokerNames']
          ?.map<BROKER_NAME>((o) => BROKER_NAME.values.byName(o))
          .toList(),
      portfolioQueueAction: json['portfolioQueueAction'] != null
          ? PORTFOLIO_QUEUE_ACTION.values.byName(json['portfolioQueueAction'])
          : null,
      limit: json['limit'],
      offset: json['offset'],
      symbols: json['symbols']?.map<String>((o) => o.toString()).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['force'] = force;
    data['global'] = global;
    data['portfolioKeys'] = portfolioKeys;
    data['userKeys'] = userKeys;
    data['assetKeys'] = assetKeys;
    data['brokerNames'] = brokerNames?.map((item) => item.name).toList();
    data['portfolioQueueAction'] = portfolioQueueAction?.name;
    data['limit'] = limit;
    data['offset'] = offset;
    data['symbols'] = symbols;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioManageActionInput &&
            (identical(other.force, force) ||
                const DeepCollectionEquality().equals(other.force, force)) &&
            (identical(other.global, global) ||
                const DeepCollectionEquality().equals(other.global, global)) &&
            (identical(other.portfolioKeys, portfolioKeys) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKeys, portfolioKeys)) &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)) &&
            (identical(other.assetKeys, assetKeys) ||
                const DeepCollectionEquality()
                    .equals(other.assetKeys, assetKeys)) &&
            (identical(other.brokerNames, brokerNames) ||
                const DeepCollectionEquality()
                    .equals(other.brokerNames, brokerNames)) &&
            (identical(other.portfolioQueueAction, portfolioQueueAction) ||
                const DeepCollectionEquality().equals(
                    other.portfolioQueueAction, portfolioQueueAction)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.symbols, symbols) ||
                const DeepCollectionEquality().equals(other.symbols, symbols)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(force) ^
        const DeepCollectionEquality().hash(global) ^
        const DeepCollectionEquality().hash(portfolioKeys) ^
        const DeepCollectionEquality().hash(userKeys) ^
        const DeepCollectionEquality().hash(assetKeys) ^
        const DeepCollectionEquality().hash(brokerNames) ^
        const DeepCollectionEquality().hash(portfolioQueueAction) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(symbols);
  }

  @override
  String toString() => 'PortfolioManageActionInput(${toJson()})';
}

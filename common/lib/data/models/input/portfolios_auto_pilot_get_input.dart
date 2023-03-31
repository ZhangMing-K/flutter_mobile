import 'package:iris_common/data/models/enums/broker_name.dart';
import 'package:collection/collection.dart';

class PortfoliosAutoPilotGetInput {
  final bool? onlyConnected;
  final List<BROKER_NAME>? brokerNames;
  final List<int>? portfolioKeys;
  const PortfoliosAutoPilotGetInput(
      {this.onlyConnected, this.brokerNames, this.portfolioKeys});
  PortfoliosAutoPilotGetInput copyWith(
      {bool? onlyConnected,
      List<BROKER_NAME>? brokerNames,
      List<int>? portfolioKeys}) {
    return PortfoliosAutoPilotGetInput(
      onlyConnected: onlyConnected ?? this.onlyConnected,
      brokerNames: brokerNames ?? this.brokerNames,
      portfolioKeys: portfolioKeys ?? this.portfolioKeys,
    );
  }

  factory PortfoliosAutoPilotGetInput.fromJson(Map<String, dynamic> json) {
    return PortfoliosAutoPilotGetInput(
      onlyConnected: json['onlyConnected'],
      brokerNames: json['brokerNames']
          ?.map<BROKER_NAME>((o) => BROKER_NAME.values.byName(o))
          .toList(),
      portfolioKeys:
          json['portfolioKeys']?.map<int>((o) => (o as int)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['onlyConnected'] = onlyConnected;
    data['brokerNames'] = brokerNames?.map((item) => item.name).toList();
    data['portfolioKeys'] = portfolioKeys;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfoliosAutoPilotGetInput &&
            (identical(other.onlyConnected, onlyConnected) ||
                const DeepCollectionEquality()
                    .equals(other.onlyConnected, onlyConnected)) &&
            (identical(other.brokerNames, brokerNames) ||
                const DeepCollectionEquality()
                    .equals(other.brokerNames, brokerNames)) &&
            (identical(other.portfolioKeys, portfolioKeys) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKeys, portfolioKeys)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(onlyConnected) ^
        const DeepCollectionEquality().hash(brokerNames) ^
        const DeepCollectionEquality().hash(portfolioKeys);
  }

  @override
  String toString() => 'PortfoliosAutoPilotGetInput(${toJson()})';
}

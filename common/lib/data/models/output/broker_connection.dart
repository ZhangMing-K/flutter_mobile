import 'package:iris_common/data/models/output/broker_account.dart';
import 'package:iris_common/data/models/output/position_model.dart';
import 'package:iris_common/data/models/output/investment_profile.dart';
import 'package:iris_common/data/models/output/portfolio_historical.dart';
import 'package:iris_common/data/models/output/historical.dart';
import 'package:collection/collection.dart';

class BrokerConnection {
  final BrokerAccount? brokerAccount;
  final List<PositionModel>? positions;
  final InvestmentProfile? investmentProfile;
  final PortfolioHistorical? historical;
  final Historical? historicalV2;
  final Historical? dayHistorical;
  const BrokerConnection(
      {this.brokerAccount,
      this.positions,
      this.investmentProfile,
      this.historical,
      this.historicalV2,
      this.dayHistorical});
  BrokerConnection copyWith(
      {BrokerAccount? brokerAccount,
      List<PositionModel>? positions,
      InvestmentProfile? investmentProfile,
      PortfolioHistorical? historical,
      Historical? historicalV2,
      Historical? dayHistorical}) {
    return BrokerConnection(
      brokerAccount: brokerAccount ?? this.brokerAccount,
      positions: positions ?? this.positions,
      investmentProfile: investmentProfile ?? this.investmentProfile,
      historical: historical ?? this.historical,
      historicalV2: historicalV2 ?? this.historicalV2,
      dayHistorical: dayHistorical ?? this.dayHistorical,
    );
  }

  factory BrokerConnection.fromJson(Map<String, dynamic> json) {
    return BrokerConnection(
      brokerAccount: json['brokerAccount'] != null
          ? BrokerAccount.fromJson(json['brokerAccount'])
          : null,
      positions: json['positions']
          ?.map<PositionModel>((o) => PositionModel.fromJson(o))
          .toList(),
      investmentProfile: json['investmentProfile'] != null
          ? InvestmentProfile.fromJson(json['investmentProfile'])
          : null,
      historical: json['historical'] != null
          ? PortfolioHistorical.fromJson(json['historical'])
          : null,
      historicalV2: json['historicalV2'] != null
          ? Historical.fromJson(json['historicalV2'])
          : null,
      dayHistorical: json['dayHistorical'] != null
          ? Historical.fromJson(json['dayHistorical'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['brokerAccount'] = brokerAccount?.toJson();
    data['positions'] = positions?.map((item) => item.toJson()).toList();
    data['investmentProfile'] = investmentProfile?.toJson();
    data['historical'] = historical?.toJson();
    data['historicalV2'] = historicalV2?.toJson();
    data['dayHistorical'] = dayHistorical?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BrokerConnection &&
            (identical(other.brokerAccount, brokerAccount) ||
                const DeepCollectionEquality()
                    .equals(other.brokerAccount, brokerAccount)) &&
            (identical(other.positions, positions) ||
                const DeepCollectionEquality()
                    .equals(other.positions, positions)) &&
            (identical(other.investmentProfile, investmentProfile) ||
                const DeepCollectionEquality()
                    .equals(other.investmentProfile, investmentProfile)) &&
            (identical(other.historical, historical) ||
                const DeepCollectionEquality()
                    .equals(other.historical, historical)) &&
            (identical(other.historicalV2, historicalV2) ||
                const DeepCollectionEquality()
                    .equals(other.historicalV2, historicalV2)) &&
            (identical(other.dayHistorical, dayHistorical) ||
                const DeepCollectionEquality()
                    .equals(other.dayHistorical, dayHistorical)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(brokerAccount) ^
        const DeepCollectionEquality().hash(positions) ^
        const DeepCollectionEquality().hash(investmentProfile) ^
        const DeepCollectionEquality().hash(historical) ^
        const DeepCollectionEquality().hash(historicalV2) ^
        const DeepCollectionEquality().hash(dayHistorical);
  }

  @override
  String toString() => 'BrokerConnection(${toJson()})';
}

import 'package:iris_common/data/models/output/position_model.dart';
import 'package:iris_common/data/models/output/outlook_division.dart';
import 'package:collection/collection.dart';

class PositionsConnection {
  final List<PositionModel>? positions;
  final double? numberOfPositions;
  final OutlookDivision? outlookDivision;
  final double? cashPercentOfPortfolio;
  final double? cashAmount;
  final double? leveragePercentOfPortfolio;
  final double? leverageAmount;
  const PositionsConnection(
      {this.positions,
      this.numberOfPositions,
      this.outlookDivision,
      this.cashPercentOfPortfolio,
      this.cashAmount,
      this.leveragePercentOfPortfolio,
      this.leverageAmount});
  PositionsConnection copyWith(
      {List<PositionModel>? positions,
      double? numberOfPositions,
      OutlookDivision? outlookDivision,
      double? cashPercentOfPortfolio,
      double? cashAmount,
      double? leveragePercentOfPortfolio,
      double? leverageAmount}) {
    return PositionsConnection(
      positions: positions ?? this.positions,
      numberOfPositions: numberOfPositions ?? this.numberOfPositions,
      outlookDivision: outlookDivision ?? this.outlookDivision,
      cashPercentOfPortfolio:
          cashPercentOfPortfolio ?? this.cashPercentOfPortfolio,
      cashAmount: cashAmount ?? this.cashAmount,
      leveragePercentOfPortfolio:
          leveragePercentOfPortfolio ?? this.leveragePercentOfPortfolio,
      leverageAmount: leverageAmount ?? this.leverageAmount,
    );
  }

  factory PositionsConnection.fromJson(Map<String, dynamic> json) {
    return PositionsConnection(
      positions: json['positions']
          ?.map<PositionModel>((o) => PositionModel.fromJson(o))
          .toList(),
      numberOfPositions: json['numberOfPositions']?.toDouble(),
      outlookDivision: json['outlookDivision'] != null
          ? OutlookDivision.fromJson(json['outlookDivision'])
          : null,
      cashPercentOfPortfolio: json['cashPercentOfPortfolio']?.toDouble(),
      cashAmount: json['cashAmount']?.toDouble(),
      leveragePercentOfPortfolio:
          json['leveragePercentOfPortfolio']?.toDouble(),
      leverageAmount: json['leverageAmount']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['positions'] = positions?.map((item) => item.toJson()).toList();
    data['numberOfPositions'] = numberOfPositions;
    data['outlookDivision'] = outlookDivision?.toJson();
    data['cashPercentOfPortfolio'] = cashPercentOfPortfolio;
    data['cashAmount'] = cashAmount;
    data['leveragePercentOfPortfolio'] = leveragePercentOfPortfolio;
    data['leverageAmount'] = leverageAmount;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionsConnection &&
            (identical(other.positions, positions) ||
                const DeepCollectionEquality()
                    .equals(other.positions, positions)) &&
            (identical(other.numberOfPositions, numberOfPositions) ||
                const DeepCollectionEquality()
                    .equals(other.numberOfPositions, numberOfPositions)) &&
            (identical(other.outlookDivision, outlookDivision) ||
                const DeepCollectionEquality()
                    .equals(other.outlookDivision, outlookDivision)) &&
            (identical(other.cashPercentOfPortfolio, cashPercentOfPortfolio) ||
                const DeepCollectionEquality().equals(
                    other.cashPercentOfPortfolio, cashPercentOfPortfolio)) &&
            (identical(other.cashAmount, cashAmount) ||
                const DeepCollectionEquality()
                    .equals(other.cashAmount, cashAmount)) &&
            (identical(other.leveragePercentOfPortfolio,
                    leveragePercentOfPortfolio) ||
                const DeepCollectionEquality().equals(
                    other.leveragePercentOfPortfolio,
                    leveragePercentOfPortfolio)) &&
            (identical(other.leverageAmount, leverageAmount) ||
                const DeepCollectionEquality()
                    .equals(other.leverageAmount, leverageAmount)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(positions) ^
        const DeepCollectionEquality().hash(numberOfPositions) ^
        const DeepCollectionEquality().hash(outlookDivision) ^
        const DeepCollectionEquality().hash(cashPercentOfPortfolio) ^
        const DeepCollectionEquality().hash(cashAmount) ^
        const DeepCollectionEquality().hash(leveragePercentOfPortfolio) ^
        const DeepCollectionEquality().hash(leverageAmount);
  }

  @override
  String toString() => 'PositionsConnection(${toJson()})';
}

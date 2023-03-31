import 'package:collection/collection.dart';

class AutoPilotExpectedReturnConnection {
  final double? expectedYearlyReturn;
  final double? expectedYearlyReturnAmount;
  const AutoPilotExpectedReturnConnection(
      {this.expectedYearlyReturn, this.expectedYearlyReturnAmount});
  AutoPilotExpectedReturnConnection copyWith(
      {double? expectedYearlyReturn, double? expectedYearlyReturnAmount}) {
    return AutoPilotExpectedReturnConnection(
      expectedYearlyReturn: expectedYearlyReturn ?? this.expectedYearlyReturn,
      expectedYearlyReturnAmount:
          expectedYearlyReturnAmount ?? this.expectedYearlyReturnAmount,
    );
  }

  factory AutoPilotExpectedReturnConnection.fromJson(
      Map<String, dynamic> json) {
    return AutoPilotExpectedReturnConnection(
      expectedYearlyReturn: json['expectedYearlyReturn']?.toDouble(),
      expectedYearlyReturnAmount:
          json['expectedYearlyReturnAmount']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['expectedYearlyReturn'] = expectedYearlyReturn;
    data['expectedYearlyReturnAmount'] = expectedYearlyReturnAmount;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotExpectedReturnConnection &&
            (identical(other.expectedYearlyReturn, expectedYearlyReturn) ||
                const DeepCollectionEquality().equals(
                    other.expectedYearlyReturn, expectedYearlyReturn)) &&
            (identical(other.expectedYearlyReturnAmount,
                    expectedYearlyReturnAmount) ||
                const DeepCollectionEquality().equals(
                    other.expectedYearlyReturnAmount,
                    expectedYearlyReturnAmount)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(expectedYearlyReturn) ^
        const DeepCollectionEquality().hash(expectedYearlyReturnAmount);
  }

  @override
  String toString() => 'AutoPilotExpectedReturnConnection(${toJson()})';
}

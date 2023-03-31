import 'package:collection/collection.dart';

class InvestmentProfile {
  final String? annualIncome;
  final String? liquidNetWorth;
  final bool? professionalTrader;
  const InvestmentProfile(
      {this.annualIncome, this.liquidNetWorth, this.professionalTrader});
  InvestmentProfile copyWith(
      {String? annualIncome,
      String? liquidNetWorth,
      bool? professionalTrader}) {
    return InvestmentProfile(
      annualIncome: annualIncome ?? this.annualIncome,
      liquidNetWorth: liquidNetWorth ?? this.liquidNetWorth,
      professionalTrader: professionalTrader ?? this.professionalTrader,
    );
  }

  factory InvestmentProfile.fromJson(Map<String, dynamic> json) {
    return InvestmentProfile(
      annualIncome: json['annualIncome'],
      liquidNetWorth: json['liquidNetWorth'],
      professionalTrader: json['professionalTrader'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['annualIncome'] = annualIncome;
    data['liquidNetWorth'] = liquidNetWorth;
    data['professionalTrader'] = professionalTrader;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InvestmentProfile &&
            (identical(other.annualIncome, annualIncome) ||
                const DeepCollectionEquality()
                    .equals(other.annualIncome, annualIncome)) &&
            (identical(other.liquidNetWorth, liquidNetWorth) ||
                const DeepCollectionEquality()
                    .equals(other.liquidNetWorth, liquidNetWorth)) &&
            (identical(other.professionalTrader, professionalTrader) ||
                const DeepCollectionEquality()
                    .equals(other.professionalTrader, professionalTrader)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(annualIncome) ^
        const DeepCollectionEquality().hash(liquidNetWorth) ^
        const DeepCollectionEquality().hash(professionalTrader);
  }

  @override
  String toString() => 'InvestmentProfile(${toJson()})';
}

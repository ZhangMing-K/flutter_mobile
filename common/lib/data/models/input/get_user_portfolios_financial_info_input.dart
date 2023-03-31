import 'package:collection/collection.dart';

class GetUserPortfoliosFinancialInfoInput {
  final bool? hard;
  final bool? autoPilotEnabled;
  final int? portfolioKey;
  const GetUserPortfoliosFinancialInfoInput(
      {this.hard, this.autoPilotEnabled, this.portfolioKey});
  GetUserPortfoliosFinancialInfoInput copyWith(
      {bool? hard, bool? autoPilotEnabled, int? portfolioKey}) {
    return GetUserPortfoliosFinancialInfoInput(
      hard: hard ?? this.hard,
      autoPilotEnabled: autoPilotEnabled ?? this.autoPilotEnabled,
      portfolioKey: portfolioKey ?? this.portfolioKey,
    );
  }

  factory GetUserPortfoliosFinancialInfoInput.fromJson(
      Map<String, dynamic> json) {
    return GetUserPortfoliosFinancialInfoInput(
      hard: json['hard'],
      autoPilotEnabled: json['autoPilotEnabled'],
      portfolioKey: json['portfolioKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['hard'] = hard;
    data['autoPilotEnabled'] = autoPilotEnabled;
    data['portfolioKey'] = portfolioKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetUserPortfoliosFinancialInfoInput &&
            (identical(other.hard, hard) ||
                const DeepCollectionEquality().equals(other.hard, hard)) &&
            (identical(other.autoPilotEnabled, autoPilotEnabled) ||
                const DeepCollectionEquality()
                    .equals(other.autoPilotEnabled, autoPilotEnabled)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(hard) ^
        const DeepCollectionEquality().hash(autoPilotEnabled) ^
        const DeepCollectionEquality().hash(portfolioKey);
  }

  @override
  String toString() => 'GetUserPortfoliosFinancialInfoInput(${toJson()})';
}

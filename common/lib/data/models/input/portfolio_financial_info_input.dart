import 'package:collection/collection.dart';

class PortfolioFinancialInfoInput {
  final bool? hard;
  const PortfolioFinancialInfoInput({this.hard});
  PortfolioFinancialInfoInput copyWith({bool? hard}) {
    return PortfolioFinancialInfoInput(
      hard: hard ?? this.hard,
    );
  }

  factory PortfolioFinancialInfoInput.fromJson(Map<String, dynamic> json) {
    return PortfolioFinancialInfoInput(
      hard: json['hard'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['hard'] = hard;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioFinancialInfoInput &&
            (identical(other.hard, hard) ||
                const DeepCollectionEquality().equals(other.hard, hard)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(hard);
  }

  @override
  String toString() => 'PortfolioFinancialInfoInput(${toJson()})';
}

import 'package:collection/collection.dart';

class PortfolioDeleteInput {
  final int? portfolioKey;
  const PortfolioDeleteInput({required this.portfolioKey});
  PortfolioDeleteInput copyWith({int? portfolioKey}) {
    return PortfolioDeleteInput(
      portfolioKey: portfolioKey ?? this.portfolioKey,
    );
  }

  factory PortfolioDeleteInput.fromJson(Map<String, dynamic> json) {
    return PortfolioDeleteInput(
      portfolioKey: json['portfolioKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolioKey'] = portfolioKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioDeleteInput &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolioKey);
  }

  @override
  String toString() => 'PortfolioDeleteInput(${toJson()})';
}

import 'package:collection/collection.dart';

class PortfolioDisconnectInput {
  final int? portfolioKey;
  const PortfolioDisconnectInput({required this.portfolioKey});
  PortfolioDisconnectInput copyWith({int? portfolioKey}) {
    return PortfolioDisconnectInput(
      portfolioKey: portfolioKey ?? this.portfolioKey,
    );
  }

  factory PortfolioDisconnectInput.fromJson(Map<String, dynamic> json) {
    return PortfolioDisconnectInput(
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
        (other is PortfolioDisconnectInput &&
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
  String toString() => 'PortfolioDisconnectInput(${toJson()})';
}

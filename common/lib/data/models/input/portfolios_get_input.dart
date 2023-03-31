import 'package:collection/collection.dart';

class PortfoliosGetInput {
  final List<int>? portfolioKeys;
  const PortfoliosGetInput({this.portfolioKeys});
  PortfoliosGetInput copyWith({List<int>? portfolioKeys}) {
    return PortfoliosGetInput(
      portfolioKeys: portfolioKeys ?? this.portfolioKeys,
    );
  }

  factory PortfoliosGetInput.fromJson(Map<String, dynamic> json) {
    return PortfoliosGetInput(
      portfolioKeys:
          json['portfolioKeys']?.map<int>((o) => (o as int)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolioKeys'] = portfolioKeys;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfoliosGetInput &&
            (identical(other.portfolioKeys, portfolioKeys) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKeys, portfolioKeys)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolioKeys);
  }

  @override
  String toString() => 'PortfoliosGetInput(${toJson()})';
}

import 'package:collection/collection.dart';

class AutoPilotFeaturedPortfoliosGetInput {
  final String? searchTerm;
  final List<int>? portfolioKeys;
  const AutoPilotFeaturedPortfoliosGetInput(
      {this.searchTerm, this.portfolioKeys});
  AutoPilotFeaturedPortfoliosGetInput copyWith(
      {String? searchTerm, List<int>? portfolioKeys}) {
    return AutoPilotFeaturedPortfoliosGetInput(
      searchTerm: searchTerm ?? this.searchTerm,
      portfolioKeys: portfolioKeys ?? this.portfolioKeys,
    );
  }

  factory AutoPilotFeaturedPortfoliosGetInput.fromJson(
      Map<String, dynamic> json) {
    return AutoPilotFeaturedPortfoliosGetInput(
      searchTerm: json['searchTerm'],
      portfolioKeys:
          json['portfolioKeys']?.map<int>((o) => (o as int)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['searchTerm'] = searchTerm;
    data['portfolioKeys'] = portfolioKeys;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotFeaturedPortfoliosGetInput &&
            (identical(other.searchTerm, searchTerm) ||
                const DeepCollectionEquality()
                    .equals(other.searchTerm, searchTerm)) &&
            (identical(other.portfolioKeys, portfolioKeys) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKeys, portfolioKeys)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(searchTerm) ^
        const DeepCollectionEquality().hash(portfolioKeys);
  }

  @override
  String toString() => 'AutoPilotFeaturedPortfoliosGetInput(${toJson()})';
}

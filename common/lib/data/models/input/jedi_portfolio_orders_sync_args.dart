import 'package:collection/collection.dart';

class JediPortfolioOrdersSyncArgs {
  final List<int>? portfolioKeys;
  final bool? global;
  const JediPortfolioOrdersSyncArgs({this.portfolioKeys, this.global});
  JediPortfolioOrdersSyncArgs copyWith(
      {List<int>? portfolioKeys, bool? global}) {
    return JediPortfolioOrdersSyncArgs(
      portfolioKeys: portfolioKeys ?? this.portfolioKeys,
      global: global ?? this.global,
    );
  }

  factory JediPortfolioOrdersSyncArgs.fromJson(Map<String, dynamic> json) {
    return JediPortfolioOrdersSyncArgs(
      portfolioKeys:
          json['portfolioKeys']?.map<int>((o) => (o as int)).toList(),
      global: json['global'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolioKeys'] = portfolioKeys;
    data['global'] = global;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediPortfolioOrdersSyncArgs &&
            (identical(other.portfolioKeys, portfolioKeys) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKeys, portfolioKeys)) &&
            (identical(other.global, global) ||
                const DeepCollectionEquality().equals(other.global, global)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolioKeys) ^
        const DeepCollectionEquality().hash(global);
  }

  @override
  String toString() => 'JediPortfolioOrdersSyncArgs(${toJson()})';
}

import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class CollectionCurrentPortfoliosConnection {
  final List<Portfolio>? portfolios;
  const CollectionCurrentPortfoliosConnection({this.portfolios});
  CollectionCurrentPortfoliosConnection copyWith(
      {List<Portfolio>? portfolios}) {
    return CollectionCurrentPortfoliosConnection(
      portfolios: portfolios ?? this.portfolios,
    );
  }

  factory CollectionCurrentPortfoliosConnection.fromJson(
      Map<String, dynamic> json) {
    return CollectionCurrentPortfoliosConnection(
      portfolios: json['portfolios']
          ?.map<Portfolio>((o) => Portfolio.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolios'] = portfolios?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionCurrentPortfoliosConnection &&
            (identical(other.portfolios, portfolios) ||
                const DeepCollectionEquality()
                    .equals(other.portfolios, portfolios)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolios);
  }

  @override
  String toString() => 'CollectionCurrentPortfoliosConnection(${toJson()})';
}

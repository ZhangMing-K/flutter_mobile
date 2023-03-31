import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class PortfolioSearchResponse {
  final List<Portfolio>? portfolios;
  const PortfolioSearchResponse({this.portfolios});
  PortfolioSearchResponse copyWith({List<Portfolio>? portfolios}) {
    return PortfolioSearchResponse(
      portfolios: portfolios ?? this.portfolios,
    );
  }

  factory PortfolioSearchResponse.fromJson(Map<String, dynamic> json) {
    return PortfolioSearchResponse(
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
        (other is PortfolioSearchResponse &&
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
  String toString() => 'PortfolioSearchResponse(${toJson()})';
}

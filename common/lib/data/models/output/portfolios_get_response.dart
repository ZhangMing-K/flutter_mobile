import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class PortfoliosGetResponse {
  final List<Portfolio>? portfolios;
  const PortfoliosGetResponse({this.portfolios});
  PortfoliosGetResponse copyWith({List<Portfolio>? portfolios}) {
    return PortfoliosGetResponse(
      portfolios: portfolios ?? this.portfolios,
    );
  }

  factory PortfoliosGetResponse.fromJson(Map<String, dynamic> json) {
    return PortfoliosGetResponse(
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
        (other is PortfoliosGetResponse &&
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
  String toString() => 'PortfoliosGetResponse(${toJson()})';
}

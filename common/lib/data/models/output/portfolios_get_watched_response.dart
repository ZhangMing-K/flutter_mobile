import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class PortfoliosGetWatchedResponse {
  final List<Portfolio>? portfolios;
  const PortfoliosGetWatchedResponse({this.portfolios});
  PortfoliosGetWatchedResponse copyWith({List<Portfolio>? portfolios}) {
    return PortfoliosGetWatchedResponse(
      portfolios: portfolios ?? this.portfolios,
    );
  }

  factory PortfoliosGetWatchedResponse.fromJson(Map<String, dynamic> json) {
    return PortfoliosGetWatchedResponse(
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
        (other is PortfoliosGetWatchedResponse &&
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
  String toString() => 'PortfoliosGetWatchedResponse(${toJson()})';
}

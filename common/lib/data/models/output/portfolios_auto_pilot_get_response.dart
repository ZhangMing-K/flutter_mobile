import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class PortfoliosAutoPilotGetResponse {
  final List<Portfolio>? portfolios;
  const PortfoliosAutoPilotGetResponse({this.portfolios});
  PortfoliosAutoPilotGetResponse copyWith({List<Portfolio>? portfolios}) {
    return PortfoliosAutoPilotGetResponse(
      portfolios: portfolios ?? this.portfolios,
    );
  }

  factory PortfoliosAutoPilotGetResponse.fromJson(Map<String, dynamic> json) {
    return PortfoliosAutoPilotGetResponse(
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
        (other is PortfoliosAutoPilotGetResponse &&
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
  String toString() => 'PortfoliosAutoPilotGetResponse(${toJson()})';
}

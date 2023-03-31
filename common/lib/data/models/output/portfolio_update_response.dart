import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class PortfolioUpdateResponse {
  final Portfolio? portfolio;
  const PortfolioUpdateResponse({this.portfolio});
  PortfolioUpdateResponse copyWith({Portfolio? portfolio}) {
    return PortfolioUpdateResponse(
      portfolio: portfolio ?? this.portfolio,
    );
  }

  factory PortfolioUpdateResponse.fromJson(Map<String, dynamic> json) {
    return PortfolioUpdateResponse(
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolio'] = portfolio?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioUpdateResponse &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolio);
  }

  @override
  String toString() => 'PortfolioUpdateResponse(${toJson()})';
}

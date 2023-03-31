import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class PortfolioActionResponse {
  final Portfolio? portfolio;
  const PortfolioActionResponse({this.portfolio});
  PortfolioActionResponse copyWith({Portfolio? portfolio}) {
    return PortfolioActionResponse(
      portfolio: portfolio ?? this.portfolio,
    );
  }

  factory PortfolioActionResponse.fromJson(Map<String, dynamic> json) {
    return PortfolioActionResponse(
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
        (other is PortfolioActionResponse &&
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
  String toString() => 'PortfolioActionResponse(${toJson()})';
}

import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class PortfolioDeleteResponse {
  final Portfolio? portfolio;
  const PortfolioDeleteResponse({this.portfolio});
  PortfolioDeleteResponse copyWith({Portfolio? portfolio}) {
    return PortfolioDeleteResponse(
      portfolio: portfolio ?? this.portfolio,
    );
  }

  factory PortfolioDeleteResponse.fromJson(Map<String, dynamic> json) {
    return PortfolioDeleteResponse(
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
        (other is PortfolioDeleteResponse &&
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
  String toString() => 'PortfolioDeleteResponse(${toJson()})';
}

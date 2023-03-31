import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class PortfolioDisconnectResponse {
  final Portfolio? portfolio;
  const PortfolioDisconnectResponse({this.portfolio});
  PortfolioDisconnectResponse copyWith({Portfolio? portfolio}) {
    return PortfolioDisconnectResponse(
      portfolio: portfolio ?? this.portfolio,
    );
  }

  factory PortfolioDisconnectResponse.fromJson(Map<String, dynamic> json) {
    return PortfolioDisconnectResponse(
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
        (other is PortfolioDisconnectResponse &&
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
  String toString() => 'PortfolioDisconnectResponse(${toJson()})';
}

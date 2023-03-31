import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class PortfolioConnectRespondToChallengeResponse {
  final String? message;
  final Portfolio? portfolio;
  const PortfolioConnectRespondToChallengeResponse(
      {this.message, this.portfolio});
  PortfolioConnectRespondToChallengeResponse copyWith(
      {String? message, Portfolio? portfolio}) {
    return PortfolioConnectRespondToChallengeResponse(
      message: message ?? this.message,
      portfolio: portfolio ?? this.portfolio,
    );
  }

  factory PortfolioConnectRespondToChallengeResponse.fromJson(
      Map<String, dynamic> json) {
    return PortfolioConnectRespondToChallengeResponse(
      message: json['message'],
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['portfolio'] = portfolio?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioConnectRespondToChallengeResponse &&
            (identical(other.message, message) ||
                const DeepCollectionEquality()
                    .equals(other.message, message)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(message) ^
        const DeepCollectionEquality().hash(portfolio);
  }

  @override
  String toString() =>
      'PortfolioConnectRespondToChallengeResponse(${toJson()})';
}

import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/jedi_portfolio_screening_data.dart';
import 'package:collection/collection.dart';

class JediAutoPilotScreeningResponse {
  final User? user;
  final List<JediPortfolioScreeningData>? portfolioData;
  const JediAutoPilotScreeningResponse(
      {required this.user, this.portfolioData});
  JediAutoPilotScreeningResponse copyWith(
      {User? user, List<JediPortfolioScreeningData>? portfolioData}) {
    return JediAutoPilotScreeningResponse(
      user: user ?? this.user,
      portfolioData: portfolioData ?? this.portfolioData,
    );
  }

  factory JediAutoPilotScreeningResponse.fromJson(Map<String, dynamic> json) {
    return JediAutoPilotScreeningResponse(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      portfolioData: json['portfolioData']
          ?.map<JediPortfolioScreeningData>(
              (o) => JediPortfolioScreeningData.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['user'] = user?.toJson();
    data['portfolioData'] =
        portfolioData?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediAutoPilotScreeningResponse &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.portfolioData, portfolioData) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioData, portfolioData)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(portfolioData);
  }

  @override
  String toString() => 'JediAutoPilotScreeningResponse(${toJson()})';
}

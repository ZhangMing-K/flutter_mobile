import 'package:iris_common/data/models/output/auto_pilot_portfolio.dart';
import 'package:collection/collection.dart';

class AutoPilotFeaturedPortfoliosGetResponse {
  final List<AutoPilotPortfolio>? autoPilotFeaturedPortfolios;
  const AutoPilotFeaturedPortfoliosGetResponse(
      {required this.autoPilotFeaturedPortfolios});
  AutoPilotFeaturedPortfoliosGetResponse copyWith(
      {List<AutoPilotPortfolio>? autoPilotFeaturedPortfolios}) {
    return AutoPilotFeaturedPortfoliosGetResponse(
      autoPilotFeaturedPortfolios:
          autoPilotFeaturedPortfolios ?? this.autoPilotFeaturedPortfolios,
    );
  }

  factory AutoPilotFeaturedPortfoliosGetResponse.fromJson(
      Map<String, dynamic> json) {
    return AutoPilotFeaturedPortfoliosGetResponse(
      autoPilotFeaturedPortfolios: json['autoPilotFeaturedPortfolios']
          ?.map<AutoPilotPortfolio>((o) => AutoPilotPortfolio.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['autoPilotFeaturedPortfolios'] =
        autoPilotFeaturedPortfolios?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotFeaturedPortfoliosGetResponse &&
            (identical(other.autoPilotFeaturedPortfolios,
                    autoPilotFeaturedPortfolios) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotFeaturedPortfolios,
                    autoPilotFeaturedPortfolios)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(autoPilotFeaturedPortfolios);
  }

  @override
  String toString() => 'AutoPilotFeaturedPortfoliosGetResponse(${toJson()})';
}

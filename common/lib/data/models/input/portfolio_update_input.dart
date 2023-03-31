import 'package:iris_common/data/models/enums/portfolio_visibility_setting.dart';
import 'package:collection/collection.dart';

class PortfolioUpdateInput {
  final int? portfolioKey;
  final bool? public;
  final bool? hide;
  final bool? showPreview;
  final PORTFOLIO_VISIBILITY_SETTING? portfolioVisibilitySetting;
  final double? followingCost;
  final String? portfolioName;
  final String? description;
  const PortfolioUpdateInput(
      {required this.portfolioKey,
      this.public,
      this.hide,
      this.showPreview,
      this.portfolioVisibilitySetting,
      this.followingCost,
      this.portfolioName,
      this.description});
  PortfolioUpdateInput copyWith(
      {int? portfolioKey,
      bool? public,
      bool? hide,
      bool? showPreview,
      PORTFOLIO_VISIBILITY_SETTING? portfolioVisibilitySetting,
      double? followingCost,
      String? portfolioName,
      String? description}) {
    return PortfolioUpdateInput(
      portfolioKey: portfolioKey ?? this.portfolioKey,
      public: public ?? this.public,
      hide: hide ?? this.hide,
      showPreview: showPreview ?? this.showPreview,
      portfolioVisibilitySetting:
          portfolioVisibilitySetting ?? this.portfolioVisibilitySetting,
      followingCost: followingCost ?? this.followingCost,
      portfolioName: portfolioName ?? this.portfolioName,
      description: description ?? this.description,
    );
  }

  factory PortfolioUpdateInput.fromJson(Map<String, dynamic> json) {
    return PortfolioUpdateInput(
      portfolioKey: json['portfolioKey'],
      public: json['public'],
      hide: json['hide'],
      showPreview: json['showPreview'],
      portfolioVisibilitySetting: json['portfolioVisibilitySetting'] != null
          ? PORTFOLIO_VISIBILITY_SETTING.values
              .byName(json['portfolioVisibilitySetting'])
          : null,
      followingCost: json['followingCost']?.toDouble(),
      portfolioName: json['portfolioName'],
      description: json['description'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolioKey'] = portfolioKey;
    data['public'] = public;
    data['hide'] = hide;
    data['showPreview'] = showPreview;
    data['portfolioVisibilitySetting'] = portfolioVisibilitySetting?.name;
    data['followingCost'] = followingCost;
    data['portfolioName'] = portfolioName;
    data['description'] = description;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioUpdateInput &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.public, public) ||
                const DeepCollectionEquality().equals(other.public, public)) &&
            (identical(other.hide, hide) ||
                const DeepCollectionEquality().equals(other.hide, hide)) &&
            (identical(other.showPreview, showPreview) ||
                const DeepCollectionEquality()
                    .equals(other.showPreview, showPreview)) &&
            (identical(other.portfolioVisibilitySetting,
                    portfolioVisibilitySetting) ||
                const DeepCollectionEquality().equals(
                    other.portfolioVisibilitySetting,
                    portfolioVisibilitySetting)) &&
            (identical(other.followingCost, followingCost) ||
                const DeepCollectionEquality()
                    .equals(other.followingCost, followingCost)) &&
            (identical(other.portfolioName, portfolioName) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioName, portfolioName)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(public) ^
        const DeepCollectionEquality().hash(hide) ^
        const DeepCollectionEquality().hash(showPreview) ^
        const DeepCollectionEquality().hash(portfolioVisibilitySetting) ^
        const DeepCollectionEquality().hash(followingCost) ^
        const DeepCollectionEquality().hash(portfolioName) ^
        const DeepCollectionEquality().hash(description);
  }

  @override
  String toString() => 'PortfolioUpdateInput(${toJson()})';
}

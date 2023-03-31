import 'package:iris_common/data/models/enums/portfolio_order_by.dart';
import 'package:collection/collection.dart';

class PortfolioSearchInput {
  final bool? saved;
  final bool? following;
  final bool? featured;
  final List<int>? assetKeys;
  final List<int>? userKeys;
  final List<int>? portfolioKeys;
  final PORTFOLIO_ORDER_BY? orderBy;
  final int? limit;
  final int? offset;
  const PortfolioSearchInput(
      {this.saved,
      this.following,
      this.featured,
      this.assetKeys,
      this.userKeys,
      this.portfolioKeys,
      this.orderBy,
      required this.limit,
      required this.offset});
  PortfolioSearchInput copyWith(
      {bool? saved,
      bool? following,
      bool? featured,
      List<int>? assetKeys,
      List<int>? userKeys,
      List<int>? portfolioKeys,
      PORTFOLIO_ORDER_BY? orderBy,
      int? limit,
      int? offset}) {
    return PortfolioSearchInput(
      saved: saved ?? this.saved,
      following: following ?? this.following,
      featured: featured ?? this.featured,
      assetKeys: assetKeys ?? this.assetKeys,
      userKeys: userKeys ?? this.userKeys,
      portfolioKeys: portfolioKeys ?? this.portfolioKeys,
      orderBy: orderBy ?? this.orderBy,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory PortfolioSearchInput.fromJson(Map<String, dynamic> json) {
    return PortfolioSearchInput(
      saved: json['saved'],
      following: json['following'],
      featured: json['featured'],
      assetKeys: json['assetKeys']?.map<int>((o) => (o as int)).toList(),
      userKeys: json['userKeys']?.map<int>((o) => (o as int)).toList(),
      portfolioKeys:
          json['portfolioKeys']?.map<int>((o) => (o as int)).toList(),
      orderBy: json['orderBy'] != null
          ? PORTFOLIO_ORDER_BY.values.byName(json['orderBy'])
          : null,
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['saved'] = saved;
    data['following'] = following;
    data['featured'] = featured;
    data['assetKeys'] = assetKeys;
    data['userKeys'] = userKeys;
    data['portfolioKeys'] = portfolioKeys;
    data['orderBy'] = orderBy?.name;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioSearchInput &&
            (identical(other.saved, saved) ||
                const DeepCollectionEquality().equals(other.saved, saved)) &&
            (identical(other.following, following) ||
                const DeepCollectionEquality()
                    .equals(other.following, following)) &&
            (identical(other.featured, featured) ||
                const DeepCollectionEquality()
                    .equals(other.featured, featured)) &&
            (identical(other.assetKeys, assetKeys) ||
                const DeepCollectionEquality()
                    .equals(other.assetKeys, assetKeys)) &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)) &&
            (identical(other.portfolioKeys, portfolioKeys) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKeys, portfolioKeys)) &&
            (identical(other.orderBy, orderBy) ||
                const DeepCollectionEquality()
                    .equals(other.orderBy, orderBy)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(saved) ^
        const DeepCollectionEquality().hash(following) ^
        const DeepCollectionEquality().hash(featured) ^
        const DeepCollectionEquality().hash(assetKeys) ^
        const DeepCollectionEquality().hash(userKeys) ^
        const DeepCollectionEquality().hash(portfolioKeys) ^
        const DeepCollectionEquality().hash(orderBy) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'PortfolioSearchInput(${toJson()})';
}

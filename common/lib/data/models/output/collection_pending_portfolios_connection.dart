import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class CollectionPendingPortfoliosConnection {
  final List<Portfolio>? portfolio;
  final String? nextCursor;
  const CollectionPendingPortfoliosConnection(
      {this.portfolio, this.nextCursor});
  CollectionPendingPortfoliosConnection copyWith(
      {List<Portfolio>? portfolio, String? nextCursor}) {
    return CollectionPendingPortfoliosConnection(
      portfolio: portfolio ?? this.portfolio,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  factory CollectionPendingPortfoliosConnection.fromJson(
      Map<String, dynamic> json) {
    return CollectionPendingPortfoliosConnection(
      portfolio: json['portfolio']
          ?.map<Portfolio>((o) => Portfolio.fromJson(o))
          .toList(),
      nextCursor: json['nextCursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolio'] = portfolio?.map((item) => item.toJson()).toList();
    data['nextCursor'] = nextCursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionPendingPortfoliosConnection &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.nextCursor, nextCursor) ||
                const DeepCollectionEquality()
                    .equals(other.nextCursor, nextCursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(nextCursor);
  }

  @override
  String toString() => 'CollectionPendingPortfoliosConnection(${toJson()})';
}

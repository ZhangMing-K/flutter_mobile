import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class LinkAccountsResponse {
  final List<Portfolio>? portfolios;
  const LinkAccountsResponse({this.portfolios});
  LinkAccountsResponse copyWith({List<Portfolio>? portfolios}) {
    return LinkAccountsResponse(
      portfolios: portfolios ?? this.portfolios,
    );
  }

  factory LinkAccountsResponse.fromJson(Map<String, dynamic> json) {
    return LinkAccountsResponse(
      portfolios: json['portfolios']
          ?.map<Portfolio>((o) => Portfolio.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolios'] = portfolios?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LinkAccountsResponse &&
            (identical(other.portfolios, portfolios) ||
                const DeepCollectionEquality()
                    .equals(other.portfolios, portfolios)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolios);
  }

  @override
  String toString() => 'LinkAccountsResponse(${toJson()})';
}

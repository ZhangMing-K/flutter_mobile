import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:collection/collection.dart';

class SearchResponse {
  final String? name;
  final List<User>? users;
  final List<Portfolio>? portfolios;
  const SearchResponse({this.name, this.users, this.portfolios});
  SearchResponse copyWith(
      {String? name, List<User>? users, List<Portfolio>? portfolios}) {
    return SearchResponse(
      name: name ?? this.name,
      users: users ?? this.users,
      portfolios: portfolios ?? this.portfolios,
    );
  }

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      name: json['name'],
      users: json['users']?.map<User>((o) => User.fromJson(o)).toList(),
      portfolios: json['portfolios']
          ?.map<Portfolio>((o) => Portfolio.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['users'] = users?.map((item) => item.toJson()).toList();
    data['portfolios'] = portfolios?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SearchResponse &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)) &&
            (identical(other.portfolios, portfolios) ||
                const DeepCollectionEquality()
                    .equals(other.portfolios, portfolios)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(users) ^
        const DeepCollectionEquality().hash(portfolios);
  }

  @override
  String toString() => 'SearchResponse(${toJson()})';
}

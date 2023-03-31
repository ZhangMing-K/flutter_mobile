import 'package:collection/collection.dart';

class ConnectedPortfoliosInput {
  final int? limit;
  final int? offset;
  final bool? excludeAuthUser;
  const ConnectedPortfoliosInput(
      {this.limit, this.offset, this.excludeAuthUser});
  ConnectedPortfoliosInput copyWith(
      {int? limit, int? offset, bool? excludeAuthUser}) {
    return ConnectedPortfoliosInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      excludeAuthUser: excludeAuthUser ?? this.excludeAuthUser,
    );
  }

  factory ConnectedPortfoliosInput.fromJson(Map<String, dynamic> json) {
    return ConnectedPortfoliosInput(
      limit: json['limit'],
      offset: json['offset'],
      excludeAuthUser: json['excludeAuthUser'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['excludeAuthUser'] = excludeAuthUser;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ConnectedPortfoliosInput &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.excludeAuthUser, excludeAuthUser) ||
                const DeepCollectionEquality()
                    .equals(other.excludeAuthUser, excludeAuthUser)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(excludeAuthUser);
  }

  @override
  String toString() => 'ConnectedPortfoliosInput(${toJson()})';
}

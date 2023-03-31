import 'package:collection/collection.dart';

class AssetOrderInput {
  final bool? authUser;
  final bool? portfoliosFollowing;
  final List<int>? userKeys;
  final int? limit;
  final int? offset;
  const AssetOrderInput(
      {this.authUser,
      this.portfoliosFollowing,
      this.userKeys,
      this.limit,
      this.offset});
  AssetOrderInput copyWith(
      {bool? authUser,
      bool? portfoliosFollowing,
      List<int>? userKeys,
      int? limit,
      int? offset}) {
    return AssetOrderInput(
      authUser: authUser ?? this.authUser,
      portfoliosFollowing: portfoliosFollowing ?? this.portfoliosFollowing,
      userKeys: userKeys ?? this.userKeys,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory AssetOrderInput.fromJson(Map<String, dynamic> json) {
    return AssetOrderInput(
      authUser: json['authUser'],
      portfoliosFollowing: json['portfoliosFollowing'],
      userKeys: json['userKeys']?.map<int>((o) => (o as int)).toList(),
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['authUser'] = authUser;
    data['portfoliosFollowing'] = portfoliosFollowing;
    data['userKeys'] = userKeys;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssetOrderInput &&
            (identical(other.authUser, authUser) ||
                const DeepCollectionEquality()
                    .equals(other.authUser, authUser)) &&
            (identical(other.portfoliosFollowing, portfoliosFollowing) ||
                const DeepCollectionEquality()
                    .equals(other.portfoliosFollowing, portfoliosFollowing)) &&
            (identical(other.userKeys, userKeys) ||
                const DeepCollectionEquality()
                    .equals(other.userKeys, userKeys)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(authUser) ^
        const DeepCollectionEquality().hash(portfoliosFollowing) ^
        const DeepCollectionEquality().hash(userKeys) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'AssetOrderInput(${toJson()})';
}

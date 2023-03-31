import 'package:iris_common/data/models/input/user_search_options.dart';
import 'package:collection/collection.dart';

class UsersSearchInput {
  final String? name;
  final int? limit;
  final int? offset;
  final bool? excludeAuthUser;
  final UserSearchOptions? options;
  const UsersSearchInput(
      {this.name, this.limit, this.offset, this.excludeAuthUser, this.options});
  UsersSearchInput copyWith(
      {String? name,
      int? limit,
      int? offset,
      bool? excludeAuthUser,
      UserSearchOptions? options}) {
    return UsersSearchInput(
      name: name ?? this.name,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      excludeAuthUser: excludeAuthUser ?? this.excludeAuthUser,
      options: options ?? this.options,
    );
  }

  factory UsersSearchInput.fromJson(Map<String, dynamic> json) {
    return UsersSearchInput(
      name: json['name'],
      limit: json['limit'],
      offset: json['offset'],
      excludeAuthUser: json['excludeAuthUser'],
      options: json['options'] != null
          ? UserSearchOptions.fromJson(json['options'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['limit'] = limit;
    data['offset'] = offset;
    data['excludeAuthUser'] = excludeAuthUser;
    data['options'] = options?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UsersSearchInput &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.excludeAuthUser, excludeAuthUser) ||
                const DeepCollectionEquality()
                    .equals(other.excludeAuthUser, excludeAuthUser)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality().equals(other.options, options)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(excludeAuthUser) ^
        const DeepCollectionEquality().hash(options);
  }

  @override
  String toString() => 'UsersSearchInput(${toJson()})';
}

import 'package:iris_common/data/models/input/context.dart';
import 'package:collection/collection.dart';

class RelevantUsersSearchInput {
  final bool? excludeAuthUser;
  final String? searchText;
  final List<int>? excludeUserKeys;
  final Context? context;
  final int? limit;
  final int? offset;
  const RelevantUsersSearchInput(
      {this.excludeAuthUser,
      this.searchText,
      this.excludeUserKeys,
      this.context,
      this.limit,
      this.offset});
  RelevantUsersSearchInput copyWith(
      {bool? excludeAuthUser,
      String? searchText,
      List<int>? excludeUserKeys,
      Context? context,
      int? limit,
      int? offset}) {
    return RelevantUsersSearchInput(
      excludeAuthUser: excludeAuthUser ?? this.excludeAuthUser,
      searchText: searchText ?? this.searchText,
      excludeUserKeys: excludeUserKeys ?? this.excludeUserKeys,
      context: context ?? this.context,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory RelevantUsersSearchInput.fromJson(Map<String, dynamic> json) {
    return RelevantUsersSearchInput(
      excludeAuthUser: json['excludeAuthUser'],
      searchText: json['searchText'],
      excludeUserKeys:
          json['excludeUserKeys']?.map<int>((o) => (o as int)).toList(),
      context:
          json['context'] != null ? Context.fromJson(json['context']) : null,
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['excludeAuthUser'] = excludeAuthUser;
    data['searchText'] = searchText;
    data['excludeUserKeys'] = excludeUserKeys;
    data['context'] = context?.toJson();
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RelevantUsersSearchInput &&
            (identical(other.excludeAuthUser, excludeAuthUser) ||
                const DeepCollectionEquality()
                    .equals(other.excludeAuthUser, excludeAuthUser)) &&
            (identical(other.searchText, searchText) ||
                const DeepCollectionEquality()
                    .equals(other.searchText, searchText)) &&
            (identical(other.excludeUserKeys, excludeUserKeys) ||
                const DeepCollectionEquality()
                    .equals(other.excludeUserKeys, excludeUserKeys)) &&
            (identical(other.context, context) ||
                const DeepCollectionEquality()
                    .equals(other.context, context)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(excludeAuthUser) ^
        const DeepCollectionEquality().hash(searchText) ^
        const DeepCollectionEquality().hash(excludeUserKeys) ^
        const DeepCollectionEquality().hash(context) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'RelevantUsersSearchInput(${toJson()})';
}

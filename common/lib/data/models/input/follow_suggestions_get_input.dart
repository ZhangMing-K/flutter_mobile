import 'package:iris_common/data/models/enums/follow_suggestion_type.dart';
import 'package:collection/collection.dart';

class FollowSuggestionsGetInput {
  final FOLLOW_SUGGESTION_TYPE? followSuggestionType;
  final String? cursor;
  const FollowSuggestionsGetInput(
      {required this.followSuggestionType, this.cursor});
  FollowSuggestionsGetInput copyWith(
      {FOLLOW_SUGGESTION_TYPE? followSuggestionType, String? cursor}) {
    return FollowSuggestionsGetInput(
      followSuggestionType: followSuggestionType ?? this.followSuggestionType,
      cursor: cursor ?? this.cursor,
    );
  }

  factory FollowSuggestionsGetInput.fromJson(Map<String, dynamic> json) {
    return FollowSuggestionsGetInput(
      followSuggestionType: json['followSuggestionType'] != null
          ? FOLLOW_SUGGESTION_TYPE.values.byName(json['followSuggestionType'])
          : null,
      cursor: json['cursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['followSuggestionType'] = followSuggestionType?.name;
    data['cursor'] = cursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FollowSuggestionsGetInput &&
            (identical(other.followSuggestionType, followSuggestionType) ||
                const DeepCollectionEquality().equals(
                    other.followSuggestionType, followSuggestionType)) &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(followSuggestionType) ^
        const DeepCollectionEquality().hash(cursor);
  }

  @override
  String toString() => 'FollowSuggestionsGetInput(${toJson()})';
}

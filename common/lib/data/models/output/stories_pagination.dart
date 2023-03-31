import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class StoriesPagination {
  final List<TextModel>? stories;
  final String? nextCursor;
  final String? previousCursor;
  const StoriesPagination({this.stories, this.nextCursor, this.previousCursor});
  StoriesPagination copyWith(
      {List<TextModel>? stories, String? nextCursor, String? previousCursor}) {
    return StoriesPagination(
      stories: stories ?? this.stories,
      nextCursor: nextCursor ?? this.nextCursor,
      previousCursor: previousCursor ?? this.previousCursor,
    );
  }

  factory StoriesPagination.fromJson(Map<String, dynamic> json) {
    return StoriesPagination(
      stories: json['stories']
          ?.map<TextModel>((o) => TextModel.fromJson(o))
          .toList(),
      nextCursor: json['nextCursor'],
      previousCursor: json['previousCursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['stories'] = stories?.map((item) => item.toJson()).toList();
    data['nextCursor'] = nextCursor;
    data['previousCursor'] = previousCursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StoriesPagination &&
            (identical(other.stories, stories) ||
                const DeepCollectionEquality()
                    .equals(other.stories, stories)) &&
            (identical(other.nextCursor, nextCursor) ||
                const DeepCollectionEquality()
                    .equals(other.nextCursor, nextCursor)) &&
            (identical(other.previousCursor, previousCursor) ||
                const DeepCollectionEquality()
                    .equals(other.previousCursor, previousCursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(stories) ^
        const DeepCollectionEquality().hash(nextCursor) ^
        const DeepCollectionEquality().hash(previousCursor);
  }

  @override
  String toString() => 'StoriesPagination(${toJson()})';
}

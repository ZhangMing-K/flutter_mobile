import 'package:iris_common/data/models/output/tag.dart';
import 'package:collection/collection.dart';

class TagsGetResponse {
  final List<Tag>? tags;
  const TagsGetResponse({this.tags});
  TagsGetResponse copyWith({List<Tag>? tags}) {
    return TagsGetResponse(
      tags: tags ?? this.tags,
    );
  }

  factory TagsGetResponse.fromJson(Map<String, dynamic> json) {
    return TagsGetResponse(
      tags: json['tags']?.map<Tag>((o) => Tag.fromJson(o)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['tags'] = tags?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TagsGetResponse &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(tags);
  }

  @override
  String toString() => 'TagsGetResponse(${toJson()})';
}

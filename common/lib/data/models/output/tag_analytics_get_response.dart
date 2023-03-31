import 'package:iris_common/data/models/output/tag_analysis.dart';
import 'package:collection/collection.dart';

class TagAnalyticsGetResponse {
  final List<TagAnalysis>? tagAnalysis;
  const TagAnalyticsGetResponse({this.tagAnalysis});
  TagAnalyticsGetResponse copyWith({List<TagAnalysis>? tagAnalysis}) {
    return TagAnalyticsGetResponse(
      tagAnalysis: tagAnalysis ?? this.tagAnalysis,
    );
  }

  factory TagAnalyticsGetResponse.fromJson(Map<String, dynamic> json) {
    return TagAnalyticsGetResponse(
      tagAnalysis: json['tagAnalysis']
          ?.map<TagAnalysis>((o) => TagAnalysis.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['tagAnalysis'] = tagAnalysis?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TagAnalyticsGetResponse &&
            (identical(other.tagAnalysis, tagAnalysis) ||
                const DeepCollectionEquality()
                    .equals(other.tagAnalysis, tagAnalysis)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(tagAnalysis);
  }

  @override
  String toString() => 'TagAnalyticsGetResponse(${toJson()})';
}

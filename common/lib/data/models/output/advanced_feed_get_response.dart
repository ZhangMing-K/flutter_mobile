import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class AdvancedFeedGetResponse {
  final List<TextModel>? texts;
  final String? nextCursor;
  const AdvancedFeedGetResponse({this.texts, this.nextCursor});
  AdvancedFeedGetResponse copyWith(
      {List<TextModel>? texts, String? nextCursor}) {
    return AdvancedFeedGetResponse(
      texts: texts ?? this.texts,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  factory AdvancedFeedGetResponse.fromJson(Map<String, dynamic> json) {
    return AdvancedFeedGetResponse(
      texts:
          json['texts']?.map<TextModel>((o) => TextModel.fromJson(o)).toList(),
      nextCursor: json['nextCursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['texts'] = texts?.map((item) => item.toJson()).toList();
    data['nextCursor'] = nextCursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdvancedFeedGetResponse &&
            (identical(other.texts, texts) ||
                const DeepCollectionEquality().equals(other.texts, texts)) &&
            (identical(other.nextCursor, nextCursor) ||
                const DeepCollectionEquality()
                    .equals(other.nextCursor, nextCursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(texts) ^
        const DeepCollectionEquality().hash(nextCursor);
  }

  @override
  String toString() => 'AdvancedFeedGetResponse(${toJson()})';
}

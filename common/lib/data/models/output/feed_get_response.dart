import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class FeedGetResponse {
  final List<TextModel>? texts;
  const FeedGetResponse({this.texts});
  FeedGetResponse copyWith({List<TextModel>? texts}) {
    return FeedGetResponse(
      texts: texts ?? this.texts,
    );
  }

  factory FeedGetResponse.fromJson(Map<String, dynamic> json) {
    return FeedGetResponse(
      texts:
          json['texts']?.map<TextModel>((o) => TextModel.fromJson(o)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['texts'] = texts?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FeedGetResponse &&
            (identical(other.texts, texts) ||
                const DeepCollectionEquality().equals(other.texts, texts)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(texts);
  }

  @override
  String toString() => 'FeedGetResponse(${toJson()})';
}

import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class FeedReturn {
  final String? nextCursor;
  final List<TextModel>? texts;
  const FeedReturn({this.nextCursor, this.texts});
  FeedReturn copyWith({String? nextCursor, List<TextModel>? texts}) {
    return FeedReturn(
      nextCursor: nextCursor ?? this.nextCursor,
      texts: texts ?? this.texts,
    );
  }

  factory FeedReturn.fromJson(Map<String, dynamic> json) {
    return FeedReturn(
      nextCursor: json['nextCursor'],
      texts:
          json['texts']?.map<TextModel>((o) => TextModel.fromJson(o)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['nextCursor'] = nextCursor;
    data['texts'] = texts?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FeedReturn &&
            (identical(other.nextCursor, nextCursor) ||
                const DeepCollectionEquality()
                    .equals(other.nextCursor, nextCursor)) &&
            (identical(other.texts, texts) ||
                const DeepCollectionEquality().equals(other.texts, texts)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(nextCursor) ^
        const DeepCollectionEquality().hash(texts);
  }

  @override
  String toString() => 'FeedReturn(${toJson()})';
}

import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class CommentsGetResponse {
  final List<TextModel>? comments;
  const CommentsGetResponse({this.comments});
  CommentsGetResponse copyWith({List<TextModel>? comments}) {
    return CommentsGetResponse(
      comments: comments ?? this.comments,
    );
  }

  factory CommentsGetResponse.fromJson(Map<String, dynamic> json) {
    return CommentsGetResponse(
      comments: json['comments']
          ?.map<TextModel>((o) => TextModel.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['comments'] = comments?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CommentsGetResponse &&
            (identical(other.comments, comments) ||
                const DeepCollectionEquality()
                    .equals(other.comments, comments)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(comments);
  }

  @override
  String toString() => 'CommentsGetResponse(${toJson()})';
}

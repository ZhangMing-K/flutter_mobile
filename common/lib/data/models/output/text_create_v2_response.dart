import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class TextCreateV2Response {
  final TextModel? text;
  const TextCreateV2Response({this.text});
  TextCreateV2Response copyWith({TextModel? text}) {
    return TextCreateV2Response(
      text: text ?? this.text,
    );
  }

  factory TextCreateV2Response.fromJson(Map<String, dynamic> json) {
    return TextCreateV2Response(
      text: json['text'] != null ? TextModel.fromJson(json['text']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['text'] = text?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TextCreateV2Response &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(text);
  }

  @override
  String toString() => 'TextCreateV2Response(${toJson()})';
}

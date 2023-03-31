import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class TextDeleteResponse {
  final TextModel? text;
  const TextDeleteResponse({this.text});
  TextDeleteResponse copyWith({TextModel? text}) {
    return TextDeleteResponse(
      text: text ?? this.text,
    );
  }

  factory TextDeleteResponse.fromJson(Map<String, dynamic> json) {
    return TextDeleteResponse(
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
        (other is TextDeleteResponse &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(text);
  }

  @override
  String toString() => 'TextDeleteResponse(${toJson()})';
}

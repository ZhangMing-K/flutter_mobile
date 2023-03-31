import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class TextEditResponse {
  final TextModel? text;
  const TextEditResponse({this.text});
  TextEditResponse copyWith({TextModel? text}) {
    return TextEditResponse(
      text: text ?? this.text,
    );
  }

  factory TextEditResponse.fromJson(Map<String, dynamic> json) {
    return TextEditResponse(
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
        (other is TextEditResponse &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(text);
  }

  @override
  String toString() => 'TextEditResponse(${toJson()})';
}

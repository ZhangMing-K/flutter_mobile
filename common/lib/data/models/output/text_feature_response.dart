import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class TextFeatureResponse {
  final TextModel? text;
  const TextFeatureResponse({this.text});
  TextFeatureResponse copyWith({TextModel? text}) {
    return TextFeatureResponse(
      text: text ?? this.text,
    );
  }

  factory TextFeatureResponse.fromJson(Map<String, dynamic> json) {
    return TextFeatureResponse(
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
        (other is TextFeatureResponse &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(text);
  }

  @override
  String toString() => 'TextFeatureResponse(${toJson()})';
}

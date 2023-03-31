import 'package:iris_common/data/models/input/text_tag_remove_input.dart';
import 'package:iris_common/data/models/input/text_create_giff_input.dart';
import 'package:collection/collection.dart';

class TextEditInput {
  final int? textKey;
  final String? value;
  final List<TextTagRemoveInput>? removeTextTags;
  final TextCreateGiffInput? giffInfo;
  const TextEditInput(
      {required this.textKey,
      required this.value,
      this.removeTextTags,
      this.giffInfo});
  TextEditInput copyWith(
      {int? textKey,
      String? value,
      List<TextTagRemoveInput>? removeTextTags,
      TextCreateGiffInput? giffInfo}) {
    return TextEditInput(
      textKey: textKey ?? this.textKey,
      value: value ?? this.value,
      removeTextTags: removeTextTags ?? this.removeTextTags,
      giffInfo: giffInfo ?? this.giffInfo,
    );
  }

  factory TextEditInput.fromJson(Map<String, dynamic> json) {
    return TextEditInput(
      textKey: json['textKey'],
      value: json['value'],
      removeTextTags: json['removeTextTags']
          ?.map<TextTagRemoveInput>((o) => TextTagRemoveInput.fromJson(o))
          .toList(),
      giffInfo: json['giffInfo'] != null
          ? TextCreateGiffInput.fromJson(json['giffInfo'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['textKey'] = textKey;
    data['value'] = value;
    data['removeTextTags'] =
        removeTextTags?.map((item) => item.toJson()).toList();
    data['giffInfo'] = giffInfo?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TextEditInput &&
            (identical(other.textKey, textKey) ||
                const DeepCollectionEquality()
                    .equals(other.textKey, textKey)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.removeTextTags, removeTextTags) ||
                const DeepCollectionEquality()
                    .equals(other.removeTextTags, removeTextTags)) &&
            (identical(other.giffInfo, giffInfo) ||
                const DeepCollectionEquality()
                    .equals(other.giffInfo, giffInfo)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(textKey) ^
        const DeepCollectionEquality().hash(value) ^
        const DeepCollectionEquality().hash(removeTextTags) ^
        const DeepCollectionEquality().hash(giffInfo);
  }

  @override
  String toString() => 'TextEditInput(${toJson()})';
}

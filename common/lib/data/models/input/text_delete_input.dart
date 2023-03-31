import 'package:collection/collection.dart';

class TextDeleteInput {
  final int? textKey;
  const TextDeleteInput({required this.textKey});
  TextDeleteInput copyWith({int? textKey}) {
    return TextDeleteInput(
      textKey: textKey ?? this.textKey,
    );
  }

  factory TextDeleteInput.fromJson(Map<String, dynamic> json) {
    return TextDeleteInput(
      textKey: json['textKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['textKey'] = textKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TextDeleteInput &&
            (identical(other.textKey, textKey) ||
                const DeepCollectionEquality().equals(other.textKey, textKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(textKey);
  }

  @override
  String toString() => 'TextDeleteInput(${toJson()})';
}

import 'package:collection/collection.dart';

class TextFeatureInput {
  final int? textKey;
  final bool? feature;
  const TextFeatureInput({required this.textKey, required this.feature});
  TextFeatureInput copyWith({int? textKey, bool? feature}) {
    return TextFeatureInput(
      textKey: textKey ?? this.textKey,
      feature: feature ?? this.feature,
    );
  }

  factory TextFeatureInput.fromJson(Map<String, dynamic> json) {
    return TextFeatureInput(
      textKey: json['textKey'],
      feature: json['feature'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['textKey'] = textKey;
    data['feature'] = feature;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TextFeatureInput &&
            (identical(other.textKey, textKey) ||
                const DeepCollectionEquality()
                    .equals(other.textKey, textKey)) &&
            (identical(other.feature, feature) ||
                const DeepCollectionEquality().equals(other.feature, feature)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(textKey) ^
        const DeepCollectionEquality().hash(feature);
  }

  @override
  String toString() => 'TextFeatureInput(${toJson()})';
}

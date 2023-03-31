import 'package:iris_common/data/models/enums/text_type.dart';
import 'package:iris_common/data/models/input/text_create_giff_input.dart';
import 'package:collection/collection.dart';

class TextCreateV2Input {
  final TEXT_TYPE? textType;
  final String? value;
  final int? parentKey;
  final int? sharedTextKey;
  final int? collectionKey;
  final bool? isEncrypted;
  final TextCreateGiffInput? giffInfo;
  const TextCreateV2Input(
      {required this.textType,
      this.value,
      this.parentKey,
      this.sharedTextKey,
      this.collectionKey,
      this.isEncrypted,
      this.giffInfo});
  TextCreateV2Input copyWith(
      {TEXT_TYPE? textType,
      String? value,
      int? parentKey,
      int? sharedTextKey,
      int? collectionKey,
      bool? isEncrypted,
      TextCreateGiffInput? giffInfo}) {
    return TextCreateV2Input(
      textType: textType ?? this.textType,
      value: value ?? this.value,
      parentKey: parentKey ?? this.parentKey,
      sharedTextKey: sharedTextKey ?? this.sharedTextKey,
      collectionKey: collectionKey ?? this.collectionKey,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      giffInfo: giffInfo ?? this.giffInfo,
    );
  }

  factory TextCreateV2Input.fromJson(Map<String, dynamic> json) {
    return TextCreateV2Input(
      textType: json['textType'] != null
          ? TEXT_TYPE.values.byName(json['textType'])
          : null,
      value: json['value'],
      parentKey: json['parentKey'],
      sharedTextKey: json['sharedTextKey'],
      collectionKey: json['collectionKey'],
      isEncrypted: json['isEncrypted'],
      giffInfo: json['giffInfo'] != null
          ? TextCreateGiffInput.fromJson(json['giffInfo'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['textType'] = textType?.name;
    data['value'] = value;
    data['parentKey'] = parentKey;
    data['sharedTextKey'] = sharedTextKey;
    data['collectionKey'] = collectionKey;
    data['isEncrypted'] = isEncrypted;
    data['giffInfo'] = giffInfo?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TextCreateV2Input &&
            (identical(other.textType, textType) ||
                const DeepCollectionEquality()
                    .equals(other.textType, textType)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.parentKey, parentKey) ||
                const DeepCollectionEquality()
                    .equals(other.parentKey, parentKey)) &&
            (identical(other.sharedTextKey, sharedTextKey) ||
                const DeepCollectionEquality()
                    .equals(other.sharedTextKey, sharedTextKey)) &&
            (identical(other.collectionKey, collectionKey) ||
                const DeepCollectionEquality()
                    .equals(other.collectionKey, collectionKey)) &&
            (identical(other.isEncrypted, isEncrypted) ||
                const DeepCollectionEquality()
                    .equals(other.isEncrypted, isEncrypted)) &&
            (identical(other.giffInfo, giffInfo) ||
                const DeepCollectionEquality()
                    .equals(other.giffInfo, giffInfo)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(textType) ^
        const DeepCollectionEquality().hash(value) ^
        const DeepCollectionEquality().hash(parentKey) ^
        const DeepCollectionEquality().hash(sharedTextKey) ^
        const DeepCollectionEquality().hash(collectionKey) ^
        const DeepCollectionEquality().hash(isEncrypted) ^
        const DeepCollectionEquality().hash(giffInfo);
  }

  @override
  String toString() => 'TextCreateV2Input(${toJson()})';
}

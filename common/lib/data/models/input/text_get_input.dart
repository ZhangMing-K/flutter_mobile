import 'package:iris_common/data/models/enums/text_type.dart';
import 'package:collection/collection.dart';

class TextGetInput {
  final List<TEXT_TYPE>? textTypes;
  final int? accountUserKey;
  final int? portfolioKey;
  final int? assetKey;
  final int? textKey;
  final int? limit;
  final int? offset;
  const TextGetInput(
      {this.textTypes,
      this.accountUserKey,
      this.portfolioKey,
      this.assetKey,
      this.textKey,
      this.limit,
      this.offset});
  TextGetInput copyWith(
      {List<TEXT_TYPE>? textTypes,
      int? accountUserKey,
      int? portfolioKey,
      int? assetKey,
      int? textKey,
      int? limit,
      int? offset}) {
    return TextGetInput(
      textTypes: textTypes ?? this.textTypes,
      accountUserKey: accountUserKey ?? this.accountUserKey,
      portfolioKey: portfolioKey ?? this.portfolioKey,
      assetKey: assetKey ?? this.assetKey,
      textKey: textKey ?? this.textKey,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory TextGetInput.fromJson(Map<String, dynamic> json) {
    return TextGetInput(
      textTypes: json['textTypes']
          ?.map<TEXT_TYPE>((o) => TEXT_TYPE.values.byName(o))
          .toList(),
      accountUserKey: json['accountUserKey'],
      portfolioKey: json['portfolioKey'],
      assetKey: json['assetKey'],
      textKey: json['textKey'],
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['textTypes'] = textTypes?.map((item) => item.name).toList();
    data['accountUserKey'] = accountUserKey;
    data['portfolioKey'] = portfolioKey;
    data['assetKey'] = assetKey;
    data['textKey'] = textKey;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TextGetInput &&
            (identical(other.textTypes, textTypes) ||
                const DeepCollectionEquality()
                    .equals(other.textTypes, textTypes)) &&
            (identical(other.accountUserKey, accountUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.accountUserKey, accountUserKey)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.textKey, textKey) ||
                const DeepCollectionEquality()
                    .equals(other.textKey, textKey)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(textTypes) ^
        const DeepCollectionEquality().hash(accountUserKey) ^
        const DeepCollectionEquality().hash(portfolioKey) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(textKey) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'TextGetInput(${toJson()})';
}

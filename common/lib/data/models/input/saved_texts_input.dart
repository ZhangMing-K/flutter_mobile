import 'package:iris_common/data/models/enums/text_type.dart';
import 'package:collection/collection.dart';

class SavedTextsInput {
  final List<TEXT_TYPE>? textTypes;
  final int? limit;
  final int? offset;
  const SavedTextsInput({this.textTypes, this.limit, this.offset});
  SavedTextsInput copyWith(
      {List<TEXT_TYPE>? textTypes, int? limit, int? offset}) {
    return SavedTextsInput(
      textTypes: textTypes ?? this.textTypes,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory SavedTextsInput.fromJson(Map<String, dynamic> json) {
    return SavedTextsInput(
      textTypes: json['textTypes']
          ?.map<TEXT_TYPE>((o) => TEXT_TYPE.values.byName(o))
          .toList(),
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['textTypes'] = textTypes?.map((item) => item.name).toList();
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SavedTextsInput &&
            (identical(other.textTypes, textTypes) ||
                const DeepCollectionEquality()
                    .equals(other.textTypes, textTypes)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(textTypes) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'SavedTextsInput(${toJson()})';
}

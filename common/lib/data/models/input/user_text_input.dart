import 'package:iris_common/data/models/enums/text_type.dart';
import 'package:iris_common/data/models/input/user_due_diligence_text_options.dart';
import 'package:collection/collection.dart';

class UserTextInput {
  final List<TEXT_TYPE>? textTypes;
  final int? limit;
  final int? offset;
  final UserDueDiligenceTextOptions? dueDiligenceOptions;
  const UserTextInput(
      {this.textTypes, this.limit, this.offset, this.dueDiligenceOptions});
  UserTextInput copyWith(
      {List<TEXT_TYPE>? textTypes,
      int? limit,
      int? offset,
      UserDueDiligenceTextOptions? dueDiligenceOptions}) {
    return UserTextInput(
      textTypes: textTypes ?? this.textTypes,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      dueDiligenceOptions: dueDiligenceOptions ?? this.dueDiligenceOptions,
    );
  }

  factory UserTextInput.fromJson(Map<String, dynamic> json) {
    return UserTextInput(
      textTypes: json['textTypes']
          ?.map<TEXT_TYPE>((o) => TEXT_TYPE.values.byName(o))
          .toList(),
      limit: json['limit'],
      offset: json['offset'],
      dueDiligenceOptions: json['dueDiligenceOptions'] != null
          ? UserDueDiligenceTextOptions.fromJson(json['dueDiligenceOptions'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['textTypes'] = textTypes?.map((item) => item.name).toList();
    data['limit'] = limit;
    data['offset'] = offset;
    data['dueDiligenceOptions'] = dueDiligenceOptions?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserTextInput &&
            (identical(other.textTypes, textTypes) ||
                const DeepCollectionEquality()
                    .equals(other.textTypes, textTypes)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.dueDiligenceOptions, dueDiligenceOptions) ||
                const DeepCollectionEquality()
                    .equals(other.dueDiligenceOptions, dueDiligenceOptions)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(textTypes) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(dueDiligenceOptions);
  }

  @override
  String toString() => 'UserTextInput(${toJson()})';
}

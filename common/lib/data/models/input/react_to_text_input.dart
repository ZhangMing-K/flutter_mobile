import 'package:iris_common/data/models/enums/reaction_kind.dart';
import 'package:collection/collection.dart';

class ReactToTextInput {
  final REACTION_KIND? reactionKind;
  final int? textKey;
  const ReactToTextInput({required this.reactionKind, required this.textKey});
  ReactToTextInput copyWith({REACTION_KIND? reactionKind, int? textKey}) {
    return ReactToTextInput(
      reactionKind: reactionKind ?? this.reactionKind,
      textKey: textKey ?? this.textKey,
    );
  }

  factory ReactToTextInput.fromJson(Map<String, dynamic> json) {
    return ReactToTextInput(
      reactionKind: json['reactionKind'] != null
          ? REACTION_KIND.values.byName(json['reactionKind'])
          : null,
      textKey: json['textKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['reactionKind'] = reactionKind?.name;
    data['textKey'] = textKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ReactToTextInput &&
            (identical(other.reactionKind, reactionKind) ||
                const DeepCollectionEquality()
                    .equals(other.reactionKind, reactionKind)) &&
            (identical(other.textKey, textKey) ||
                const DeepCollectionEquality().equals(other.textKey, textKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(reactionKind) ^
        const DeepCollectionEquality().hash(textKey);
  }

  @override
  String toString() => 'ReactToTextInput(${toJson()})';
}

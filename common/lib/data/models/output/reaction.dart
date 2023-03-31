import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:iris_common/data/models/enums/reaction_kind.dart';
import 'package:collection/collection.dart';

class Reaction {
  final int? reactionKey;
  final int? userKey;
  final User? user;
  final int? textKey;
  final TextModel? text;
  final DateTime? createdAt;
  final REACTION_KIND? reactionKind;
  const Reaction(
      {this.reactionKey,
      this.userKey,
      this.user,
      this.textKey,
      this.text,
      this.createdAt,
      this.reactionKind});
  Reaction copyWith(
      {int? reactionKey,
      int? userKey,
      User? user,
      int? textKey,
      TextModel? text,
      DateTime? createdAt,
      REACTION_KIND? reactionKind}) {
    return Reaction(
      reactionKey: reactionKey ?? this.reactionKey,
      userKey: userKey ?? this.userKey,
      user: user ?? this.user,
      textKey: textKey ?? this.textKey,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      reactionKind: reactionKind ?? this.reactionKind,
    );
  }

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(
      reactionKey: json['reactionKey'],
      userKey: json['userKey'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      textKey: json['textKey'],
      text: json['text'] != null ? TextModel.fromJson(json['text']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      reactionKind: json['reactionKind'] != null
          ? REACTION_KIND.values.byName(json['reactionKind'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['reactionKey'] = reactionKey;
    data['userKey'] = userKey;
    data['user'] = user?.toJson();
    data['textKey'] = textKey;
    data['text'] = text?.toJson();
    data['createdAt'] = createdAt?.toString();
    data['reactionKind'] = reactionKind?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Reaction &&
            (identical(other.reactionKey, reactionKey) ||
                const DeepCollectionEquality()
                    .equals(other.reactionKey, reactionKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.textKey, textKey) ||
                const DeepCollectionEquality()
                    .equals(other.textKey, textKey)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.reactionKind, reactionKind) ||
                const DeepCollectionEquality()
                    .equals(other.reactionKind, reactionKind)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(reactionKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(textKey) ^
        const DeepCollectionEquality().hash(text) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(reactionKind);
  }

  @override
  String toString() => 'Reaction(${toJson()})';
}

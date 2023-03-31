import 'package:collection/collection.dart';

class JediChangeStoryIndex {
  final int? authUserKey;
  final int? profileUserKey;
  final int? index;
  const JediChangeStoryIndex(
      {required this.authUserKey,
      required this.profileUserKey,
      required this.index});
  JediChangeStoryIndex copyWith(
      {int? authUserKey, int? profileUserKey, int? index}) {
    return JediChangeStoryIndex(
      authUserKey: authUserKey ?? this.authUserKey,
      profileUserKey: profileUserKey ?? this.profileUserKey,
      index: index ?? this.index,
    );
  }

  factory JediChangeStoryIndex.fromJson(Map<String, dynamic> json) {
    return JediChangeStoryIndex(
      authUserKey: json['authUserKey'],
      profileUserKey: json['profileUserKey'],
      index: json['index'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['authUserKey'] = authUserKey;
    data['profileUserKey'] = profileUserKey;
    data['index'] = index;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediChangeStoryIndex &&
            (identical(other.authUserKey, authUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.authUserKey, authUserKey)) &&
            (identical(other.profileUserKey, profileUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.profileUserKey, profileUserKey)) &&
            (identical(other.index, index) ||
                const DeepCollectionEquality().equals(other.index, index)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(authUserKey) ^
        const DeepCollectionEquality().hash(profileUserKey) ^
        const DeepCollectionEquality().hash(index);
  }

  @override
  String toString() => 'JediChangeStoryIndex(${toJson()})';
}

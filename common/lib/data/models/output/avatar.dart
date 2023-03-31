import 'package:collection/collection.dart';

class Avatar {
  final int? avatarKey;
  final String? avatarName;
  final String? code;
  final String? url;
  const Avatar({this.avatarKey, this.avatarName, this.code, this.url});
  Avatar copyWith(
      {int? avatarKey, String? avatarName, String? code, String? url}) {
    return Avatar(
      avatarKey: avatarKey ?? this.avatarKey,
      avatarName: avatarName ?? this.avatarName,
      code: code ?? this.code,
      url: url ?? this.url,
    );
  }

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      avatarKey: json['avatarKey'],
      avatarName: json['avatarName'],
      code: json['code'],
      url: json['url'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['avatarKey'] = avatarKey;
    data['avatarName'] = avatarName;
    data['code'] = code;
    data['url'] = url;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Avatar &&
            (identical(other.avatarKey, avatarKey) ||
                const DeepCollectionEquality()
                    .equals(other.avatarKey, avatarKey)) &&
            (identical(other.avatarName, avatarName) ||
                const DeepCollectionEquality()
                    .equals(other.avatarName, avatarName)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(avatarKey) ^
        const DeepCollectionEquality().hash(avatarName) ^
        const DeepCollectionEquality().hash(code) ^
        const DeepCollectionEquality().hash(url);
  }

  @override
  String toString() => 'Avatar(${toJson()})';
}

import 'package:collection/collection.dart';

class Auth {
  final String? type;
  final String? token;
  const Auth({required this.type, required this.token});
  Auth copyWith({String? type, String? token}) {
    return Auth(
      type: type ?? this.type,
      token: token ?? this.token,
    );
  }

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      type: json['type'],
      token: json['token'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['token'] = token;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Auth &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(type) ^
        const DeepCollectionEquality().hash(token);
  }

  @override
  String toString() => 'Auth(${toJson()})';
}

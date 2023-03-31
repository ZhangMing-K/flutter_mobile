import 'package:collection/collection.dart';

class FollowInput {
  final int? userKey;
  final int? fromTextKey;
  const FollowInput({required this.userKey, this.fromTextKey});
  FollowInput copyWith({int? userKey, int? fromTextKey}) {
    return FollowInput(
      userKey: userKey ?? this.userKey,
      fromTextKey: fromTextKey ?? this.fromTextKey,
    );
  }

  factory FollowInput.fromJson(Map<String, dynamic> json) {
    return FollowInput(
      userKey: json['userKey'],
      fromTextKey: json['fromTextKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    data['fromTextKey'] = fromTextKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FollowInput &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.fromTextKey, fromTextKey) ||
                const DeepCollectionEquality()
                    .equals(other.fromTextKey, fromTextKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(fromTextKey);
  }

  @override
  String toString() => 'FollowInput(${toJson()})';
}

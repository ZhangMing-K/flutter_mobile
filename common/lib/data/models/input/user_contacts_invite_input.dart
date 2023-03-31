import 'package:collection/collection.dart';

class UserContactsInviteInput {
  final int? limit;
  final int? offset;
  final String? name;
  final bool? inviteAlreadySent;
  const UserContactsInviteInput(
      {required this.limit,
      required this.offset,
      this.name,
      this.inviteAlreadySent});
  UserContactsInviteInput copyWith(
      {int? limit, int? offset, String? name, bool? inviteAlreadySent}) {
    return UserContactsInviteInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      name: name ?? this.name,
      inviteAlreadySent: inviteAlreadySent ?? this.inviteAlreadySent,
    );
  }

  factory UserContactsInviteInput.fromJson(Map<String, dynamic> json) {
    return UserContactsInviteInput(
      limit: json['limit'],
      offset: json['offset'],
      name: json['name'],
      inviteAlreadySent: json['inviteAlreadySent'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['name'] = name;
    data['inviteAlreadySent'] = inviteAlreadySent;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserContactsInviteInput &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.inviteAlreadySent, inviteAlreadySent) ||
                const DeepCollectionEquality()
                    .equals(other.inviteAlreadySent, inviteAlreadySent)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(inviteAlreadySent);
  }

  @override
  String toString() => 'UserContactsInviteInput(${toJson()})';
}

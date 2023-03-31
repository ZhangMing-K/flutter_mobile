import 'package:collection/collection.dart';

class NbrUserContactsToInviteInput {
  final bool? inviteAlreadySent;
  const NbrUserContactsToInviteInput({this.inviteAlreadySent});
  NbrUserContactsToInviteInput copyWith({bool? inviteAlreadySent}) {
    return NbrUserContactsToInviteInput(
      inviteAlreadySent: inviteAlreadySent ?? this.inviteAlreadySent,
    );
  }

  factory NbrUserContactsToInviteInput.fromJson(Map<String, dynamic> json) {
    return NbrUserContactsToInviteInput(
      inviteAlreadySent: json['inviteAlreadySent'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['inviteAlreadySent'] = inviteAlreadySent;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NbrUserContactsToInviteInput &&
            (identical(other.inviteAlreadySent, inviteAlreadySent) ||
                const DeepCollectionEquality()
                    .equals(other.inviteAlreadySent, inviteAlreadySent)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(inviteAlreadySent);
  }

  @override
  String toString() => 'NbrUserContactsToInviteInput(${toJson()})';
}

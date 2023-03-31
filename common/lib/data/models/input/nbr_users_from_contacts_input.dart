import 'package:collection/collection.dart';

class NbrUsersFromContactsInput {
  final bool? recomended;
  const NbrUsersFromContactsInput({this.recomended});
  NbrUsersFromContactsInput copyWith({bool? recomended}) {
    return NbrUsersFromContactsInput(
      recomended: recomended ?? this.recomended,
    );
  }

  factory NbrUsersFromContactsInput.fromJson(Map<String, dynamic> json) {
    return NbrUsersFromContactsInput(
      recomended: json['recomended'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['recomended'] = recomended;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NbrUsersFromContactsInput &&
            (identical(other.recomended, recomended) ||
                const DeepCollectionEquality()
                    .equals(other.recomended, recomended)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(recomended);
  }

  @override
  String toString() => 'NbrUsersFromContactsInput(${toJson()})';
}

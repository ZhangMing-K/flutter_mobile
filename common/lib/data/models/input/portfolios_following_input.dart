import 'package:collection/collection.dart';

class PortfoliosFollowingInput {
  final bool? watching;
  final bool? includeUsers;
  const PortfoliosFollowingInput({this.watching, this.includeUsers});
  PortfoliosFollowingInput copyWith({bool? watching, bool? includeUsers}) {
    return PortfoliosFollowingInput(
      watching: watching ?? this.watching,
      includeUsers: includeUsers ?? this.includeUsers,
    );
  }

  factory PortfoliosFollowingInput.fromJson(Map<String, dynamic> json) {
    return PortfoliosFollowingInput(
      watching: json['watching'],
      includeUsers: json['includeUsers'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['watching'] = watching;
    data['includeUsers'] = includeUsers;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfoliosFollowingInput &&
            (identical(other.watching, watching) ||
                const DeepCollectionEquality()
                    .equals(other.watching, watching)) &&
            (identical(other.includeUsers, includeUsers) ||
                const DeepCollectionEquality()
                    .equals(other.includeUsers, includeUsers)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(watching) ^
        const DeepCollectionEquality().hash(includeUsers);
  }

  @override
  String toString() => 'PortfoliosFollowingInput(${toJson()})';
}

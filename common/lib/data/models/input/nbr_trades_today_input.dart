import 'package:collection/collection.dart';

class NbrTradesTodayInput {
  final bool? excludeAuthUser;
  const NbrTradesTodayInput({this.excludeAuthUser});
  NbrTradesTodayInput copyWith({bool? excludeAuthUser}) {
    return NbrTradesTodayInput(
      excludeAuthUser: excludeAuthUser ?? this.excludeAuthUser,
    );
  }

  factory NbrTradesTodayInput.fromJson(Map<String, dynamic> json) {
    return NbrTradesTodayInput(
      excludeAuthUser: json['excludeAuthUser'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['excludeAuthUser'] = excludeAuthUser;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NbrTradesTodayInput &&
            (identical(other.excludeAuthUser, excludeAuthUser) ||
                const DeepCollectionEquality()
                    .equals(other.excludeAuthUser, excludeAuthUser)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(excludeAuthUser);
  }

  @override
  String toString() => 'NbrTradesTodayInput(${toJson()})';
}

import 'package:collection/collection.dart';

class FlagsGetInput {
  final List<int>? flagKeys;
  const FlagsGetInput({this.flagKeys});
  FlagsGetInput copyWith({List<int>? flagKeys}) {
    return FlagsGetInput(
      flagKeys: flagKeys ?? this.flagKeys,
    );
  }

  factory FlagsGetInput.fromJson(Map<String, dynamic> json) {
    return FlagsGetInput(
      flagKeys: json['flagKeys']?.map<int>((o) => (o as int)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['flagKeys'] = flagKeys;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FlagsGetInput &&
            (identical(other.flagKeys, flagKeys) ||
                const DeepCollectionEquality()
                    .equals(other.flagKeys, flagKeys)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(flagKeys);
  }

  @override
  String toString() => 'FlagsGetInput(${toJson()})';
}

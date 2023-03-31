import 'package:collection/collection.dart';

class UserTopAssetInput {
  final int? limit;
  final int? offset;
  final bool? useMaster;
  const UserTopAssetInput({this.limit, this.offset, this.useMaster});
  UserTopAssetInput copyWith({int? limit, int? offset, bool? useMaster}) {
    return UserTopAssetInput(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      useMaster: useMaster ?? this.useMaster,
    );
  }

  factory UserTopAssetInput.fromJson(Map<String, dynamic> json) {
    return UserTopAssetInput(
      limit: json['limit'],
      offset: json['offset'],
      useMaster: json['useMaster'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['useMaster'] = useMaster;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserTopAssetInput &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.useMaster, useMaster) ||
                const DeepCollectionEquality()
                    .equals(other.useMaster, useMaster)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(useMaster);
  }

  @override
  String toString() => 'UserTopAssetInput(${toJson()})';
}

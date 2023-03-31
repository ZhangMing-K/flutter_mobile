import 'package:collection/collection.dart';

class MutualFollowedByInput {
  final int? limit;
  const MutualFollowedByInput({this.limit});
  MutualFollowedByInput copyWith({int? limit}) {
    return MutualFollowedByInput(
      limit: limit ?? this.limit,
    );
  }

  factory MutualFollowedByInput.fromJson(Map<String, dynamic> json) {
    return MutualFollowedByInput(
      limit: json['limit'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MutualFollowedByInput &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(limit);
  }

  @override
  String toString() => 'MutualFollowedByInput(${toJson()})';
}

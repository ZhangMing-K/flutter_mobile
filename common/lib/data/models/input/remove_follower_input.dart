import 'package:collection/collection.dart';

class RemoveFollowerInput {
  final int? userKey;
  final int? portfolioKey;
  const RemoveFollowerInput({required this.userKey, this.portfolioKey});
  RemoveFollowerInput copyWith({int? userKey, int? portfolioKey}) {
    return RemoveFollowerInput(
      userKey: userKey ?? this.userKey,
      portfolioKey: portfolioKey ?? this.portfolioKey,
    );
  }

  factory RemoveFollowerInput.fromJson(Map<String, dynamic> json) {
    return RemoveFollowerInput(
      userKey: json['userKey'],
      portfolioKey: json['portfolioKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    data['portfolioKey'] = portfolioKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RemoveFollowerInput &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(portfolioKey);
  }

  @override
  String toString() => 'RemoveFollowerInput(${toJson()})';
}

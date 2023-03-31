import 'package:collection/collection.dart';

class AssetSimilarityPercentInput {
  final int? userKey;
  const AssetSimilarityPercentInput({required this.userKey});
  AssetSimilarityPercentInput copyWith({int? userKey}) {
    return AssetSimilarityPercentInput(
      userKey: userKey ?? this.userKey,
    );
  }

  factory AssetSimilarityPercentInput.fromJson(Map<String, dynamic> json) {
    return AssetSimilarityPercentInput(
      userKey: json['userKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssetSimilarityPercentInput &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality().equals(other.userKey, userKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(userKey);
  }

  @override
  String toString() => 'AssetSimilarityPercentInput(${toJson()})';
}

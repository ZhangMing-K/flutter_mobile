import 'package:iris_common/data/models/output/asset.dart';
import 'package:collection/collection.dart';

class AssetsGetResponse {
  final List<Asset>? assets;
  const AssetsGetResponse({this.assets});
  AssetsGetResponse copyWith({List<Asset>? assets}) {
    return AssetsGetResponse(
      assets: assets ?? this.assets,
    );
  }

  factory AssetsGetResponse.fromJson(Map<String, dynamic> json) {
    return AssetsGetResponse(
      assets: json['assets']?.map<Asset>((o) => Asset.fromJson(o)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['assets'] = assets?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssetsGetResponse &&
            (identical(other.assets, assets) ||
                const DeepCollectionEquality().equals(other.assets, assets)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(assets);
  }

  @override
  String toString() => 'AssetsGetResponse(${toJson()})';
}

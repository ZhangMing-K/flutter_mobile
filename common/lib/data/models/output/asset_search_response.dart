import 'package:iris_common/data/models/output/asset.dart';
import 'package:collection/collection.dart';

class AssetSearchResponse {
  final List<Asset>? assets;
  const AssetSearchResponse({this.assets});
  AssetSearchResponse copyWith({List<Asset>? assets}) {
    return AssetSearchResponse(
      assets: assets ?? this.assets,
    );
  }

  factory AssetSearchResponse.fromJson(Map<String, dynamic> json) {
    return AssetSearchResponse(
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
        (other is AssetSearchResponse &&
            (identical(other.assets, assets) ||
                const DeepCollectionEquality().equals(other.assets, assets)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(assets);
  }

  @override
  String toString() => 'AssetSearchResponse(${toJson()})';
}

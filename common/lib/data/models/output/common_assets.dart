import 'package:iris_common/data/models/output/asset.dart';
import 'package:collection/collection.dart';

class CommonAssets {
  final Asset? asset;
  final int? nbrUsers;
  final int? nbrOrders;
  const CommonAssets({this.asset, this.nbrUsers, this.nbrOrders});
  CommonAssets copyWith({Asset? asset, int? nbrUsers, int? nbrOrders}) {
    return CommonAssets(
      asset: asset ?? this.asset,
      nbrUsers: nbrUsers ?? this.nbrUsers,
      nbrOrders: nbrOrders ?? this.nbrOrders,
    );
  }

  factory CommonAssets.fromJson(Map<String, dynamic> json) {
    return CommonAssets(
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      nbrUsers: json['nbrUsers'],
      nbrOrders: json['nbrOrders'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['asset'] = asset?.toJson();
    data['nbrUsers'] = nbrUsers;
    data['nbrOrders'] = nbrOrders;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CommonAssets &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.nbrUsers, nbrUsers) ||
                const DeepCollectionEquality()
                    .equals(other.nbrUsers, nbrUsers)) &&
            (identical(other.nbrOrders, nbrOrders) ||
                const DeepCollectionEquality()
                    .equals(other.nbrOrders, nbrOrders)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(nbrUsers) ^
        const DeepCollectionEquality().hash(nbrOrders);
  }

  @override
  String toString() => 'CommonAssets(${toJson()})';
}

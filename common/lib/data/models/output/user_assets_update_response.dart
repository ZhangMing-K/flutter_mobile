import 'package:iris_common/data/models/output/user_asset.dart';
import 'package:collection/collection.dart';

class UserAssetsUpdateResponse {
  final List<UserAsset>? userAssets;
  const UserAssetsUpdateResponse({this.userAssets});
  UserAssetsUpdateResponse copyWith({List<UserAsset>? userAssets}) {
    return UserAssetsUpdateResponse(
      userAssets: userAssets ?? this.userAssets,
    );
  }

  factory UserAssetsUpdateResponse.fromJson(Map<String, dynamic> json) {
    return UserAssetsUpdateResponse(
      userAssets: json['userAssets']
          ?.map<UserAsset>((o) => UserAsset.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userAssets'] = userAssets?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserAssetsUpdateResponse &&
            (identical(other.userAssets, userAssets) ||
                const DeepCollectionEquality()
                    .equals(other.userAssets, userAssets)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userAssets);
  }

  @override
  String toString() => 'UserAssetsUpdateResponse(${toJson()})';
}

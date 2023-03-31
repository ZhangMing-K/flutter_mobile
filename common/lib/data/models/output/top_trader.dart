import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/enums/segment_type.dart';
import 'package:iris_common/data/models/output/asset.dart';
import 'package:iris_common/data/models/output/percentile_connection.dart';
import 'package:collection/collection.dart';

class TopTrader {
  final User? user;
  final SEGMENT_TYPE? segmentType;
  final Asset? asset;
  final PercentileConnection? percentileConnection;
  const TopTrader(
      {this.user, this.segmentType, this.asset, this.percentileConnection});
  TopTrader copyWith(
      {User? user,
      SEGMENT_TYPE? segmentType,
      Asset? asset,
      PercentileConnection? percentileConnection}) {
    return TopTrader(
      user: user ?? this.user,
      segmentType: segmentType ?? this.segmentType,
      asset: asset ?? this.asset,
      percentileConnection: percentileConnection ?? this.percentileConnection,
    );
  }

  factory TopTrader.fromJson(Map<String, dynamic> json) {
    return TopTrader(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      segmentType: json['segmentType'] != null
          ? SEGMENT_TYPE.values.byName(json['segmentType'])
          : null,
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      percentileConnection: json['percentileConnection'] != null
          ? PercentileConnection.fromJson(json['percentileConnection'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['user'] = user?.toJson();
    data['segmentType'] = segmentType?.name;
    data['asset'] = asset?.toJson();
    data['percentileConnection'] = percentileConnection?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TopTrader &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.segmentType, segmentType) ||
                const DeepCollectionEquality()
                    .equals(other.segmentType, segmentType)) &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.percentileConnection, percentileConnection) ||
                const DeepCollectionEquality()
                    .equals(other.percentileConnection, percentileConnection)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(segmentType) ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(percentileConnection);
  }

  @override
  String toString() => 'TopTrader(${toJson()})';
}

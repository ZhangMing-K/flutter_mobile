import 'package:iris_common/data/models/enums/outlook.dart';
import 'package:iris_common/data/models/enums/order_by.dart';
import 'package:collection/collection.dart';

class AssetAnalysisOrderBy {
  final OUTLOOK? outlook;
  final ORDER_BY? orderBy;
  const AssetAnalysisOrderBy({this.outlook, required this.orderBy});
  AssetAnalysisOrderBy copyWith({OUTLOOK? outlook, ORDER_BY? orderBy}) {
    return AssetAnalysisOrderBy(
      outlook: outlook ?? this.outlook,
      orderBy: orderBy ?? this.orderBy,
    );
  }

  factory AssetAnalysisOrderBy.fromJson(Map<String, dynamic> json) {
    return AssetAnalysisOrderBy(
      outlook: json['outlook'] != null
          ? OUTLOOK.values.byName(json['outlook'])
          : null,
      orderBy: json['orderBy'] != null
          ? ORDER_BY.values.byName(json['orderBy'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['outlook'] = outlook?.name;
    data['orderBy'] = orderBy?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssetAnalysisOrderBy &&
            (identical(other.outlook, outlook) ||
                const DeepCollectionEquality()
                    .equals(other.outlook, outlook)) &&
            (identical(other.orderBy, orderBy) ||
                const DeepCollectionEquality().equals(other.orderBy, orderBy)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(outlook) ^
        const DeepCollectionEquality().hash(orderBy);
  }

  @override
  String toString() => 'AssetAnalysisOrderBy(${toJson()})';
}

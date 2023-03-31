import 'package:iris_common/data/models/enums/position_type.dart';
import 'package:iris_common/data/models/enums/option_type.dart';
import 'package:iris_common/data/models/enums/order_group_by.dart';
import 'package:iris_common/data/models/enums/deciding_unit.dart';
import 'package:iris_common/data/models/enums/position_status.dart';
import 'package:iris_common/data/models/input/between_input.dart';
import 'package:collection/collection.dart';

class PortfolioTradeAnalysisInput {
  final List<POSITION_TYPE>? positionTypes;
  final List<OPTION_TYPE>? optionTypes;
  final ORDER_GROUP_BY? groupBy;
  final DECIDING_UNIT? unit;
  final POSITION_STATUS? positionStatus;
  final BetweenInput? between;
  final int? limit;
  final int? offset;
  const PortfolioTradeAnalysisInput(
      {this.positionTypes,
      this.optionTypes,
      required this.groupBy,
      required this.unit,
      this.positionStatus,
      this.between,
      this.limit,
      this.offset});
  PortfolioTradeAnalysisInput copyWith(
      {List<POSITION_TYPE>? positionTypes,
      List<OPTION_TYPE>? optionTypes,
      ORDER_GROUP_BY? groupBy,
      DECIDING_UNIT? unit,
      POSITION_STATUS? positionStatus,
      BetweenInput? between,
      int? limit,
      int? offset}) {
    return PortfolioTradeAnalysisInput(
      positionTypes: positionTypes ?? this.positionTypes,
      optionTypes: optionTypes ?? this.optionTypes,
      groupBy: groupBy ?? this.groupBy,
      unit: unit ?? this.unit,
      positionStatus: positionStatus ?? this.positionStatus,
      between: between ?? this.between,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory PortfolioTradeAnalysisInput.fromJson(Map<String, dynamic> json) {
    return PortfolioTradeAnalysisInput(
      positionTypes: json['positionTypes']
          ?.map<POSITION_TYPE>((o) => POSITION_TYPE.values.byName(o))
          .toList(),
      optionTypes: json['optionTypes']
          ?.map<OPTION_TYPE>((o) => OPTION_TYPE.values.byName(o))
          .toList(),
      groupBy: json['groupBy'] != null
          ? ORDER_GROUP_BY.values.byName(json['groupBy'])
          : null,
      unit: json['unit'] != null
          ? DECIDING_UNIT.values.byName(json['unit'])
          : null,
      positionStatus: json['positionStatus'] != null
          ? POSITION_STATUS.values.byName(json['positionStatus'])
          : null,
      between: json['between'] != null
          ? BetweenInput.fromJson(json['between'])
          : null,
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['positionTypes'] = positionTypes?.map((item) => item.name).toList();
    data['optionTypes'] = optionTypes?.map((item) => item.name).toList();
    data['groupBy'] = groupBy?.name;
    data['unit'] = unit?.name;
    data['positionStatus'] = positionStatus?.name;
    data['between'] = between?.toJson();
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioTradeAnalysisInput &&
            (identical(other.positionTypes, positionTypes) ||
                const DeepCollectionEquality()
                    .equals(other.positionTypes, positionTypes)) &&
            (identical(other.optionTypes, optionTypes) ||
                const DeepCollectionEquality()
                    .equals(other.optionTypes, optionTypes)) &&
            (identical(other.groupBy, groupBy) ||
                const DeepCollectionEquality()
                    .equals(other.groupBy, groupBy)) &&
            (identical(other.unit, unit) ||
                const DeepCollectionEquality().equals(other.unit, unit)) &&
            (identical(other.positionStatus, positionStatus) ||
                const DeepCollectionEquality()
                    .equals(other.positionStatus, positionStatus)) &&
            (identical(other.between, between) ||
                const DeepCollectionEquality()
                    .equals(other.between, between)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(positionTypes) ^
        const DeepCollectionEquality().hash(optionTypes) ^
        const DeepCollectionEquality().hash(groupBy) ^
        const DeepCollectionEquality().hash(unit) ^
        const DeepCollectionEquality().hash(positionStatus) ^
        const DeepCollectionEquality().hash(between) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'PortfolioTradeAnalysisInput(${toJson()})';
}

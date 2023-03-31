import 'package:iris_common/data/models/enums/position_type.dart';
import 'package:iris_common/data/models/enums/option_type.dart';
import 'package:iris_common/data/models/enums/open_position_order_by.dart';
import 'package:iris_common/data/models/enums/position_outlook.dart';
import 'package:collection/collection.dart';

class PortfolioPositionAnalysisInput {
  final List<POSITION_TYPE>? positionTypes;
  final List<OPTION_TYPE>? optionTypes;
  final OPEN_POSITION_ORDER_BY? orderBy;
  final POSITION_OUTLOOK? outlook;
  final DateTime? selectedDate;
  final int? limit;
  final int? offset;
  const PortfolioPositionAnalysisInput(
      {this.positionTypes,
      this.optionTypes,
      this.orderBy,
      this.outlook,
      this.selectedDate,
      this.limit,
      this.offset});
  PortfolioPositionAnalysisInput copyWith(
      {List<POSITION_TYPE>? positionTypes,
      List<OPTION_TYPE>? optionTypes,
      OPEN_POSITION_ORDER_BY? orderBy,
      POSITION_OUTLOOK? outlook,
      DateTime? selectedDate,
      int? limit,
      int? offset}) {
    return PortfolioPositionAnalysisInput(
      positionTypes: positionTypes ?? this.positionTypes,
      optionTypes: optionTypes ?? this.optionTypes,
      orderBy: orderBy ?? this.orderBy,
      outlook: outlook ?? this.outlook,
      selectedDate: selectedDate ?? this.selectedDate,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory PortfolioPositionAnalysisInput.fromJson(Map<String, dynamic> json) {
    return PortfolioPositionAnalysisInput(
      positionTypes: json['positionTypes']
          ?.map<POSITION_TYPE>((o) => POSITION_TYPE.values.byName(o))
          .toList(),
      optionTypes: json['optionTypes']
          ?.map<OPTION_TYPE>((o) => OPTION_TYPE.values.byName(o))
          .toList(),
      orderBy: json['orderBy'] != null
          ? OPEN_POSITION_ORDER_BY.values.byName(json['orderBy'])
          : null,
      outlook: json['outlook'] != null
          ? POSITION_OUTLOOK.values.byName(json['outlook'])
          : null,
      selectedDate: json['selectedDate'] != null
          ? DateTime.parse(json['selectedDate'])
          : null,
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['positionTypes'] = positionTypes?.map((item) => item.name).toList();
    data['optionTypes'] = optionTypes?.map((item) => item.name).toList();
    data['orderBy'] = orderBy?.name;
    data['outlook'] = outlook?.name;
    data['selectedDate'] = selectedDate?.toString();
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioPositionAnalysisInput &&
            (identical(other.positionTypes, positionTypes) ||
                const DeepCollectionEquality()
                    .equals(other.positionTypes, positionTypes)) &&
            (identical(other.optionTypes, optionTypes) ||
                const DeepCollectionEquality()
                    .equals(other.optionTypes, optionTypes)) &&
            (identical(other.orderBy, orderBy) ||
                const DeepCollectionEquality()
                    .equals(other.orderBy, orderBy)) &&
            (identical(other.outlook, outlook) ||
                const DeepCollectionEquality()
                    .equals(other.outlook, outlook)) &&
            (identical(other.selectedDate, selectedDate) ||
                const DeepCollectionEquality()
                    .equals(other.selectedDate, selectedDate)) &&
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
        const DeepCollectionEquality().hash(orderBy) ^
        const DeepCollectionEquality().hash(outlook) ^
        const DeepCollectionEquality().hash(selectedDate) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'PortfolioPositionAnalysisInput(${toJson()})';
}

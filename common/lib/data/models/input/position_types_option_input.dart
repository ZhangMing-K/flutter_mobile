import 'package:iris_common/data/models/enums/position_type.dart';
import 'package:collection/collection.dart';

class PositionTypesOptionInput {
  final List<POSITION_TYPE>? positionTypesToTrade;
  final bool? addToList;
  final bool? setToDefault;
  const PositionTypesOptionInput(
      {this.positionTypesToTrade, this.addToList, this.setToDefault});
  PositionTypesOptionInput copyWith(
      {List<POSITION_TYPE>? positionTypesToTrade,
      bool? addToList,
      bool? setToDefault}) {
    return PositionTypesOptionInput(
      positionTypesToTrade: positionTypesToTrade ?? this.positionTypesToTrade,
      addToList: addToList ?? this.addToList,
      setToDefault: setToDefault ?? this.setToDefault,
    );
  }

  factory PositionTypesOptionInput.fromJson(Map<String, dynamic> json) {
    return PositionTypesOptionInput(
      positionTypesToTrade: json['positionTypesToTrade']
          ?.map<POSITION_TYPE>((o) => POSITION_TYPE.values.byName(o))
          .toList(),
      addToList: json['addToList'],
      setToDefault: json['setToDefault'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['positionTypesToTrade'] =
        positionTypesToTrade?.map((item) => item.name).toList();
    data['addToList'] = addToList;
    data['setToDefault'] = setToDefault;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionTypesOptionInput &&
            (identical(other.positionTypesToTrade, positionTypesToTrade) ||
                const DeepCollectionEquality().equals(
                    other.positionTypesToTrade, positionTypesToTrade)) &&
            (identical(other.addToList, addToList) ||
                const DeepCollectionEquality()
                    .equals(other.addToList, addToList)) &&
            (identical(other.setToDefault, setToDefault) ||
                const DeepCollectionEquality()
                    .equals(other.setToDefault, setToDefault)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(positionTypesToTrade) ^
        const DeepCollectionEquality().hash(addToList) ^
        const DeepCollectionEquality().hash(setToDefault);
  }

  @override
  String toString() => 'PositionTypesOptionInput(${toJson()})';
}

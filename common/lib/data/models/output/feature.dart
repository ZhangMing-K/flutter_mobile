import 'package:iris_common/data/models/enums/cost_type.dart';
import 'package:collection/collection.dart';

class Feature {
  final int? featureKey;
  final String? name;
  final String? description;
  final String? pictureUrl;
  final COST_TYPE? costType;
  final double? cost;
  final DateTime? fullActiveAt;
  final DateTime? betaAt;
  final DateTime? createdAt;
  const Feature(
      {this.featureKey,
      this.name,
      this.description,
      this.pictureUrl,
      this.costType,
      this.cost,
      this.fullActiveAt,
      this.betaAt,
      this.createdAt});
  Feature copyWith(
      {int? featureKey,
      String? name,
      String? description,
      String? pictureUrl,
      COST_TYPE? costType,
      double? cost,
      DateTime? fullActiveAt,
      DateTime? betaAt,
      DateTime? createdAt}) {
    return Feature(
      featureKey: featureKey ?? this.featureKey,
      name: name ?? this.name,
      description: description ?? this.description,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      costType: costType ?? this.costType,
      cost: cost ?? this.cost,
      fullActiveAt: fullActiveAt ?? this.fullActiveAt,
      betaAt: betaAt ?? this.betaAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      featureKey: json['featureKey'],
      name: json['name'],
      description: json['description'],
      pictureUrl: json['pictureUrl'],
      costType: json['costType'] != null
          ? COST_TYPE.values.byName(json['costType'])
          : null,
      cost: json['cost']?.toDouble(),
      fullActiveAt: json['fullActiveAt'] != null
          ? DateTime.parse(json['fullActiveAt'])
          : null,
      betaAt: json['betaAt'] != null ? DateTime.parse(json['betaAt']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['featureKey'] = featureKey;
    data['name'] = name;
    data['description'] = description;
    data['pictureUrl'] = pictureUrl;
    data['costType'] = costType?.name;
    data['cost'] = cost;
    data['fullActiveAt'] = fullActiveAt?.toString();
    data['betaAt'] = betaAt?.toString();
    data['createdAt'] = createdAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Feature &&
            (identical(other.featureKey, featureKey) ||
                const DeepCollectionEquality()
                    .equals(other.featureKey, featureKey)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.pictureUrl, pictureUrl) ||
                const DeepCollectionEquality()
                    .equals(other.pictureUrl, pictureUrl)) &&
            (identical(other.costType, costType) ||
                const DeepCollectionEquality()
                    .equals(other.costType, costType)) &&
            (identical(other.cost, cost) ||
                const DeepCollectionEquality().equals(other.cost, cost)) &&
            (identical(other.fullActiveAt, fullActiveAt) ||
                const DeepCollectionEquality()
                    .equals(other.fullActiveAt, fullActiveAt)) &&
            (identical(other.betaAt, betaAt) ||
                const DeepCollectionEquality().equals(other.betaAt, betaAt)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(featureKey) ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(description) ^
        const DeepCollectionEquality().hash(pictureUrl) ^
        const DeepCollectionEquality().hash(costType) ^
        const DeepCollectionEquality().hash(cost) ^
        const DeepCollectionEquality().hash(fullActiveAt) ^
        const DeepCollectionEquality().hash(betaAt) ^
        const DeepCollectionEquality().hash(createdAt);
  }

  @override
  String toString() => 'Feature(${toJson()})';
}

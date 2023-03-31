import 'package:iris_common/data/models/enums/privacy_type.dart';
import 'package:iris_common/data/models/enums/approval_type.dart';
import 'package:iris_common/data/models/enums/approval_by_type.dart';
import 'package:collection/collection.dart';

class CollectionUpdateInput {
  final int? collectionKey;
  final String? name;
  final String? description;
  final PRIVACY_TYPE? privacyType;
  final APPROVAL_TYPE? approvalType;
  final APPROVAL_BY_TYPE? approvalByType;
  final String? pictureUrl;
  const CollectionUpdateInput(
      {required this.collectionKey,
      this.name,
      this.description,
      this.privacyType,
      this.approvalType,
      this.approvalByType,
      this.pictureUrl});
  CollectionUpdateInput copyWith(
      {int? collectionKey,
      String? name,
      String? description,
      PRIVACY_TYPE? privacyType,
      APPROVAL_TYPE? approvalType,
      APPROVAL_BY_TYPE? approvalByType,
      String? pictureUrl}) {
    return CollectionUpdateInput(
      collectionKey: collectionKey ?? this.collectionKey,
      name: name ?? this.name,
      description: description ?? this.description,
      privacyType: privacyType ?? this.privacyType,
      approvalType: approvalType ?? this.approvalType,
      approvalByType: approvalByType ?? this.approvalByType,
      pictureUrl: pictureUrl ?? this.pictureUrl,
    );
  }

  factory CollectionUpdateInput.fromJson(Map<String, dynamic> json) {
    return CollectionUpdateInput(
      collectionKey: json['collectionKey'],
      name: json['name'],
      description: json['description'],
      privacyType: json['privacyType'] != null
          ? PRIVACY_TYPE.values.byName(json['privacyType'])
          : null,
      approvalType: json['approvalType'] != null
          ? APPROVAL_TYPE.values.byName(json['approvalType'])
          : null,
      approvalByType: json['approvalByType'] != null
          ? APPROVAL_BY_TYPE.values.byName(json['approvalByType'])
          : null,
      pictureUrl: json['pictureUrl'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['collectionKey'] = collectionKey;
    data['name'] = name;
    data['description'] = description;
    data['privacyType'] = privacyType?.name;
    data['approvalType'] = approvalType?.name;
    data['approvalByType'] = approvalByType?.name;
    data['pictureUrl'] = pictureUrl;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionUpdateInput &&
            (identical(other.collectionKey, collectionKey) ||
                const DeepCollectionEquality()
                    .equals(other.collectionKey, collectionKey)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.privacyType, privacyType) ||
                const DeepCollectionEquality()
                    .equals(other.privacyType, privacyType)) &&
            (identical(other.approvalType, approvalType) ||
                const DeepCollectionEquality()
                    .equals(other.approvalType, approvalType)) &&
            (identical(other.approvalByType, approvalByType) ||
                const DeepCollectionEquality()
                    .equals(other.approvalByType, approvalByType)) &&
            (identical(other.pictureUrl, pictureUrl) ||
                const DeepCollectionEquality()
                    .equals(other.pictureUrl, pictureUrl)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(collectionKey) ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(description) ^
        const DeepCollectionEquality().hash(privacyType) ^
        const DeepCollectionEquality().hash(approvalType) ^
        const DeepCollectionEquality().hash(approvalByType) ^
        const DeepCollectionEquality().hash(pictureUrl);
  }

  @override
  String toString() => 'CollectionUpdateInput(${toJson()})';
}

import 'package:iris_common/data/models/enums/collection_type.dart';
import 'package:iris_common/data/models/enums/privacy_type.dart';
import 'package:iris_common/data/models/enums/approval_type.dart';
import 'package:collection/collection.dart';

class CollectionCreateInput {
  final String? name;
  final COLLECTION_TYPE? collectionType;
  final PRIVACY_TYPE? privacyType;
  final APPROVAL_TYPE? approvalType;
  final String? description;
  final List<int>? addedUserKeys;
  final String? pictureUrl;
  const CollectionCreateInput(
      {this.name,
      required this.collectionType,
      this.privacyType,
      this.approvalType,
      this.description,
      this.addedUserKeys,
      this.pictureUrl});
  CollectionCreateInput copyWith(
      {String? name,
      COLLECTION_TYPE? collectionType,
      PRIVACY_TYPE? privacyType,
      APPROVAL_TYPE? approvalType,
      String? description,
      List<int>? addedUserKeys,
      String? pictureUrl}) {
    return CollectionCreateInput(
      name: name ?? this.name,
      collectionType: collectionType ?? this.collectionType,
      privacyType: privacyType ?? this.privacyType,
      approvalType: approvalType ?? this.approvalType,
      description: description ?? this.description,
      addedUserKeys: addedUserKeys ?? this.addedUserKeys,
      pictureUrl: pictureUrl ?? this.pictureUrl,
    );
  }

  factory CollectionCreateInput.fromJson(Map<String, dynamic> json) {
    return CollectionCreateInput(
      name: json['name'],
      collectionType: json['collectionType'] != null
          ? COLLECTION_TYPE.values.byName(json['collectionType'])
          : null,
      privacyType: json['privacyType'] != null
          ? PRIVACY_TYPE.values.byName(json['privacyType'])
          : null,
      approvalType: json['approvalType'] != null
          ? APPROVAL_TYPE.values.byName(json['approvalType'])
          : null,
      description: json['description'],
      addedUserKeys:
          json['addedUserKeys']?.map<int>((o) => (o as int)).toList(),
      pictureUrl: json['pictureUrl'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['collectionType'] = collectionType?.name;
    data['privacyType'] = privacyType?.name;
    data['approvalType'] = approvalType?.name;
    data['description'] = description;
    data['addedUserKeys'] = addedUserKeys;
    data['pictureUrl'] = pictureUrl;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionCreateInput &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.collectionType, collectionType) ||
                const DeepCollectionEquality()
                    .equals(other.collectionType, collectionType)) &&
            (identical(other.privacyType, privacyType) ||
                const DeepCollectionEquality()
                    .equals(other.privacyType, privacyType)) &&
            (identical(other.approvalType, approvalType) ||
                const DeepCollectionEquality()
                    .equals(other.approvalType, approvalType)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.addedUserKeys, addedUserKeys) ||
                const DeepCollectionEquality()
                    .equals(other.addedUserKeys, addedUserKeys)) &&
            (identical(other.pictureUrl, pictureUrl) ||
                const DeepCollectionEquality()
                    .equals(other.pictureUrl, pictureUrl)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(collectionType) ^
        const DeepCollectionEquality().hash(privacyType) ^
        const DeepCollectionEquality().hash(approvalType) ^
        const DeepCollectionEquality().hash(description) ^
        const DeepCollectionEquality().hash(addedUserKeys) ^
        const DeepCollectionEquality().hash(pictureUrl);
  }

  @override
  String toString() => 'CollectionCreateInput(${toJson()})';
}

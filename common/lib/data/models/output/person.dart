import 'package:collection/collection.dart';

class Person {
  final int? personKey;
  final String? description;
  final String? remoteId;
  final String? displayName;
  final String? indexName;
  final String? personPictureUrl;
  const Person(
      {this.personKey,
      this.description,
      this.remoteId,
      this.displayName,
      this.indexName,
      this.personPictureUrl});
  Person copyWith(
      {int? personKey,
      String? description,
      String? remoteId,
      String? displayName,
      String? indexName,
      String? personPictureUrl}) {
    return Person(
      personKey: personKey ?? this.personKey,
      description: description ?? this.description,
      remoteId: remoteId ?? this.remoteId,
      displayName: displayName ?? this.displayName,
      indexName: indexName ?? this.indexName,
      personPictureUrl: personPictureUrl ?? this.personPictureUrl,
    );
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      personKey: json['personKey'],
      description: json['description'],
      remoteId: json['remoteId'],
      displayName: json['displayName'],
      indexName: json['indexName'],
      personPictureUrl: json['personPictureUrl'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['personKey'] = personKey;
    data['description'] = description;
    data['remoteId'] = remoteId;
    data['displayName'] = displayName;
    data['indexName'] = indexName;
    data['personPictureUrl'] = personPictureUrl;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Person &&
            (identical(other.personKey, personKey) ||
                const DeepCollectionEquality()
                    .equals(other.personKey, personKey)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality()
                    .equals(other.displayName, displayName)) &&
            (identical(other.indexName, indexName) ||
                const DeepCollectionEquality()
                    .equals(other.indexName, indexName)) &&
            (identical(other.personPictureUrl, personPictureUrl) ||
                const DeepCollectionEquality()
                    .equals(other.personPictureUrl, personPictureUrl)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(personKey) ^
        const DeepCollectionEquality().hash(description) ^
        const DeepCollectionEquality().hash(remoteId) ^
        const DeepCollectionEquality().hash(displayName) ^
        const DeepCollectionEquality().hash(indexName) ^
        const DeepCollectionEquality().hash(personPictureUrl);
  }

  @override
  String toString() => 'Person(${toJson()})';
}

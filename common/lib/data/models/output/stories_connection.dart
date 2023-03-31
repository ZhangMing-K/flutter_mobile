import 'package:iris_common/data/models/output/stories_pagination.dart';
import 'package:iris_common/data/models/output/stories_meta_data.dart';
import 'package:collection/collection.dart';

class StoriesConnection {
  final StoriesPagination? storiesPagination;
  final int? nbrOfActiveStories;
  final StoriesMetaData? metaData;
  const StoriesConnection(
      {this.storiesPagination, this.nbrOfActiveStories, this.metaData});
  StoriesConnection copyWith(
      {StoriesPagination? storiesPagination,
      int? nbrOfActiveStories,
      StoriesMetaData? metaData}) {
    return StoriesConnection(
      storiesPagination: storiesPagination ?? this.storiesPagination,
      nbrOfActiveStories: nbrOfActiveStories ?? this.nbrOfActiveStories,
      metaData: metaData ?? this.metaData,
    );
  }

  factory StoriesConnection.fromJson(Map<String, dynamic> json) {
    return StoriesConnection(
      storiesPagination: json['storiesPagination'] != null
          ? StoriesPagination.fromJson(json['storiesPagination'])
          : null,
      nbrOfActiveStories: json['nbrOfActiveStories'],
      metaData: json['metaData'] != null
          ? StoriesMetaData.fromJson(json['metaData'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['storiesPagination'] = storiesPagination?.toJson();
    data['nbrOfActiveStories'] = nbrOfActiveStories;
    data['metaData'] = metaData?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StoriesConnection &&
            (identical(other.storiesPagination, storiesPagination) ||
                const DeepCollectionEquality()
                    .equals(other.storiesPagination, storiesPagination)) &&
            (identical(other.nbrOfActiveStories, nbrOfActiveStories) ||
                const DeepCollectionEquality()
                    .equals(other.nbrOfActiveStories, nbrOfActiveStories)) &&
            (identical(other.metaData, metaData) ||
                const DeepCollectionEquality()
                    .equals(other.metaData, metaData)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(storiesPagination) ^
        const DeepCollectionEquality().hash(nbrOfActiveStories) ^
        const DeepCollectionEquality().hash(metaData);
  }

  @override
  String toString() => 'StoriesConnection(${toJson()})';
}

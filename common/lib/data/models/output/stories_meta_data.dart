import 'package:collection/collection.dart';

class StoriesMetaData {
  final int? currentIndex;
  final int? nbrStories;
  final bool? areUnseenStories;
  final bool? areStories;
  const StoriesMetaData(
      {this.currentIndex,
      this.nbrStories,
      this.areUnseenStories,
      this.areStories});
  StoriesMetaData copyWith(
      {int? currentIndex,
      int? nbrStories,
      bool? areUnseenStories,
      bool? areStories}) {
    return StoriesMetaData(
      currentIndex: currentIndex ?? this.currentIndex,
      nbrStories: nbrStories ?? this.nbrStories,
      areUnseenStories: areUnseenStories ?? this.areUnseenStories,
      areStories: areStories ?? this.areStories,
    );
  }

  factory StoriesMetaData.fromJson(Map<String, dynamic> json) {
    return StoriesMetaData(
      currentIndex: json['currentIndex'],
      nbrStories: json['nbrStories'],
      areUnseenStories: json['areUnseenStories'],
      areStories: json['areStories'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['currentIndex'] = currentIndex;
    data['nbrStories'] = nbrStories;
    data['areUnseenStories'] = areUnseenStories;
    data['areStories'] = areStories;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StoriesMetaData &&
            (identical(other.currentIndex, currentIndex) ||
                const DeepCollectionEquality()
                    .equals(other.currentIndex, currentIndex)) &&
            (identical(other.nbrStories, nbrStories) ||
                const DeepCollectionEquality()
                    .equals(other.nbrStories, nbrStories)) &&
            (identical(other.areUnseenStories, areUnseenStories) ||
                const DeepCollectionEquality()
                    .equals(other.areUnseenStories, areUnseenStories)) &&
            (identical(other.areStories, areStories) ||
                const DeepCollectionEquality()
                    .equals(other.areStories, areStories)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(currentIndex) ^
        const DeepCollectionEquality().hash(nbrStories) ^
        const DeepCollectionEquality().hash(areUnseenStories) ^
        const DeepCollectionEquality().hash(areStories);
  }

  @override
  String toString() => 'StoriesMetaData(${toJson()})';
}

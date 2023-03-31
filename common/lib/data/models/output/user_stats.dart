import 'package:collection/collection.dart';

class UserStats {
  final int? nbrViews;
  final int? nbrDViews;
  final int? nbrReactions;
  final double? reactionsToView;
  const UserStats(
      {this.nbrViews, this.nbrDViews, this.nbrReactions, this.reactionsToView});
  UserStats copyWith(
      {int? nbrViews,
      int? nbrDViews,
      int? nbrReactions,
      double? reactionsToView}) {
    return UserStats(
      nbrViews: nbrViews ?? this.nbrViews,
      nbrDViews: nbrDViews ?? this.nbrDViews,
      nbrReactions: nbrReactions ?? this.nbrReactions,
      reactionsToView: reactionsToView ?? this.reactionsToView,
    );
  }

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      nbrViews: json['nbrViews'],
      nbrDViews: json['nbrDViews'],
      nbrReactions: json['nbrReactions'],
      reactionsToView: json['reactionsToView']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['nbrViews'] = nbrViews;
    data['nbrDViews'] = nbrDViews;
    data['nbrReactions'] = nbrReactions;
    data['reactionsToView'] = reactionsToView;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserStats &&
            (identical(other.nbrViews, nbrViews) ||
                const DeepCollectionEquality()
                    .equals(other.nbrViews, nbrViews)) &&
            (identical(other.nbrDViews, nbrDViews) ||
                const DeepCollectionEquality()
                    .equals(other.nbrDViews, nbrDViews)) &&
            (identical(other.nbrReactions, nbrReactions) ||
                const DeepCollectionEquality()
                    .equals(other.nbrReactions, nbrReactions)) &&
            (identical(other.reactionsToView, reactionsToView) ||
                const DeepCollectionEquality()
                    .equals(other.reactionsToView, reactionsToView)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(nbrViews) ^
        const DeepCollectionEquality().hash(nbrDViews) ^
        const DeepCollectionEquality().hash(nbrReactions) ^
        const DeepCollectionEquality().hash(reactionsToView);
  }

  @override
  String toString() => 'UserStats(${toJson()})';
}

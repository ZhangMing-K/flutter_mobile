import 'package:collection/collection.dart';

class TextStat {
  final int? textKey;
  final int? nbrReactions;
  final int? nbrComments;
  final int? nbrDComments;
  final int? nbrMessageShares;
  final int? nbrDMessageShares;
  final int? nbrSaves;
  final int? nbrViews;
  final int? nbrDViews;
  final int? reach;
  const TextStat(
      {this.textKey,
      this.nbrReactions,
      this.nbrComments,
      this.nbrDComments,
      this.nbrMessageShares,
      this.nbrDMessageShares,
      this.nbrSaves,
      this.nbrViews,
      this.nbrDViews,
      this.reach});
  TextStat copyWith(
      {int? textKey,
      int? nbrReactions,
      int? nbrComments,
      int? nbrDComments,
      int? nbrMessageShares,
      int? nbrDMessageShares,
      int? nbrSaves,
      int? nbrViews,
      int? nbrDViews,
      int? reach}) {
    return TextStat(
      textKey: textKey ?? this.textKey,
      nbrReactions: nbrReactions ?? this.nbrReactions,
      nbrComments: nbrComments ?? this.nbrComments,
      nbrDComments: nbrDComments ?? this.nbrDComments,
      nbrMessageShares: nbrMessageShares ?? this.nbrMessageShares,
      nbrDMessageShares: nbrDMessageShares ?? this.nbrDMessageShares,
      nbrSaves: nbrSaves ?? this.nbrSaves,
      nbrViews: nbrViews ?? this.nbrViews,
      nbrDViews: nbrDViews ?? this.nbrDViews,
      reach: reach ?? this.reach,
    );
  }

  factory TextStat.fromJson(Map<String, dynamic> json) {
    return TextStat(
      textKey: json['textKey'],
      nbrReactions: json['nbrReactions'],
      nbrComments: json['nbrComments'],
      nbrDComments: json['nbrDComments'],
      nbrMessageShares: json['nbrMessageShares'],
      nbrDMessageShares: json['nbrDMessageShares'],
      nbrSaves: json['nbrSaves'],
      nbrViews: json['nbrViews'],
      nbrDViews: json['nbrDViews'],
      reach: json['reach'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['textKey'] = textKey;
    data['nbrReactions'] = nbrReactions;
    data['nbrComments'] = nbrComments;
    data['nbrDComments'] = nbrDComments;
    data['nbrMessageShares'] = nbrMessageShares;
    data['nbrDMessageShares'] = nbrDMessageShares;
    data['nbrSaves'] = nbrSaves;
    data['nbrViews'] = nbrViews;
    data['nbrDViews'] = nbrDViews;
    data['reach'] = reach;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TextStat &&
            (identical(other.textKey, textKey) ||
                const DeepCollectionEquality()
                    .equals(other.textKey, textKey)) &&
            (identical(other.nbrReactions, nbrReactions) ||
                const DeepCollectionEquality()
                    .equals(other.nbrReactions, nbrReactions)) &&
            (identical(other.nbrComments, nbrComments) ||
                const DeepCollectionEquality()
                    .equals(other.nbrComments, nbrComments)) &&
            (identical(other.nbrDComments, nbrDComments) ||
                const DeepCollectionEquality()
                    .equals(other.nbrDComments, nbrDComments)) &&
            (identical(other.nbrMessageShares, nbrMessageShares) ||
                const DeepCollectionEquality()
                    .equals(other.nbrMessageShares, nbrMessageShares)) &&
            (identical(other.nbrDMessageShares, nbrDMessageShares) ||
                const DeepCollectionEquality()
                    .equals(other.nbrDMessageShares, nbrDMessageShares)) &&
            (identical(other.nbrSaves, nbrSaves) ||
                const DeepCollectionEquality()
                    .equals(other.nbrSaves, nbrSaves)) &&
            (identical(other.nbrViews, nbrViews) ||
                const DeepCollectionEquality()
                    .equals(other.nbrViews, nbrViews)) &&
            (identical(other.nbrDViews, nbrDViews) ||
                const DeepCollectionEquality()
                    .equals(other.nbrDViews, nbrDViews)) &&
            (identical(other.reach, reach) ||
                const DeepCollectionEquality().equals(other.reach, reach)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(textKey) ^
        const DeepCollectionEquality().hash(nbrReactions) ^
        const DeepCollectionEquality().hash(nbrComments) ^
        const DeepCollectionEquality().hash(nbrDComments) ^
        const DeepCollectionEquality().hash(nbrMessageShares) ^
        const DeepCollectionEquality().hash(nbrDMessageShares) ^
        const DeepCollectionEquality().hash(nbrSaves) ^
        const DeepCollectionEquality().hash(nbrViews) ^
        const DeepCollectionEquality().hash(nbrDViews) ^
        const DeepCollectionEquality().hash(reach);
  }

  @override
  String toString() => 'TextStat(${toJson()})';
}

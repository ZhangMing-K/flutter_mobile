import 'package:iris_common/data/models/enums/text_type.dart';
import 'package:collection/collection.dart';

class FeedGetInput {
  final List<TEXT_TYPE>? textTypes;
  final bool? featured;
  final bool? following;
  final int? limit;
  final int? offset;
  const FeedGetInput(
      {this.textTypes, this.featured, this.following, this.limit, this.offset});
  FeedGetInput copyWith(
      {List<TEXT_TYPE>? textTypes,
      bool? featured,
      bool? following,
      int? limit,
      int? offset}) {
    return FeedGetInput(
      textTypes: textTypes ?? this.textTypes,
      featured: featured ?? this.featured,
      following: following ?? this.following,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory FeedGetInput.fromJson(Map<String, dynamic> json) {
    return FeedGetInput(
      textTypes: json['textTypes']
          ?.map<TEXT_TYPE>((o) => TEXT_TYPE.values.byName(o))
          .toList(),
      featured: json['featured'],
      following: json['following'],
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['textTypes'] = textTypes?.map((item) => item.name).toList();
    data['featured'] = featured;
    data['following'] = following;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FeedGetInput &&
            (identical(other.textTypes, textTypes) ||
                const DeepCollectionEquality()
                    .equals(other.textTypes, textTypes)) &&
            (identical(other.featured, featured) ||
                const DeepCollectionEquality()
                    .equals(other.featured, featured)) &&
            (identical(other.following, following) ||
                const DeepCollectionEquality()
                    .equals(other.following, following)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(textTypes) ^
        const DeepCollectionEquality().hash(featured) ^
        const DeepCollectionEquality().hash(following) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'FeedGetInput(${toJson()})';
}

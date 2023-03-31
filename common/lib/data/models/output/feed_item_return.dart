import 'package:iris_common/data/models/output/feed_item.dart';
import 'package:collection/collection.dart';

class FeedItemReturn {
  final List<FeedItem>? items;
  final String? nextCursor;
  const FeedItemReturn({required this.items, this.nextCursor});
  FeedItemReturn copyWith({List<FeedItem>? items, String? nextCursor}) {
    return FeedItemReturn(
      items: items ?? this.items,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  factory FeedItemReturn.fromJson(Map<String, dynamic> json) {
    return FeedItemReturn(
      items: json['items']?.map<FeedItem>((o) => FeedItem.fromJson(o)).toList(),
      nextCursor: json['nextCursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['items'] = items?.map((item) => item.toJson()).toList();
    data['nextCursor'] = nextCursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FeedItemReturn &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)) &&
            (identical(other.nextCursor, nextCursor) ||
                const DeepCollectionEquality()
                    .equals(other.nextCursor, nextCursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(items) ^
        const DeepCollectionEquality().hash(nextCursor);
  }

  @override
  String toString() => 'FeedItemReturn(${toJson()})';
}

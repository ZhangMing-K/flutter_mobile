import 'package:iris_common/data/models/output/discover_page_item.dart';
import 'package:collection/collection.dart';

class DiscoverPageGetResponse {
  final List<DiscoverPageItem>? items;
  final String? nextCursor;
  const DiscoverPageGetResponse({this.items, this.nextCursor});
  DiscoverPageGetResponse copyWith(
      {List<DiscoverPageItem>? items, String? nextCursor}) {
    return DiscoverPageGetResponse(
      items: items ?? this.items,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  factory DiscoverPageGetResponse.fromJson(Map<String, dynamic> json) {
    return DiscoverPageGetResponse(
      items: json['items']
          ?.map<DiscoverPageItem>((o) => DiscoverPageItem.fromJson(o))
          .toList(),
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
        (other is DiscoverPageGetResponse &&
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
  String toString() => 'DiscoverPageGetResponse(${toJson()})';
}

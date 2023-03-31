import 'package:iris_common/data/models/enums/share_type.dart';
import 'package:collection/collection.dart';

class SharesInput {
  final List<SHARE_TYPE>? shareTypes;
  final int? limit;
  final int? offset;
  const SharesInput({this.shareTypes, this.limit, this.offset});
  SharesInput copyWith(
      {List<SHARE_TYPE>? shareTypes, int? limit, int? offset}) {
    return SharesInput(
      shareTypes: shareTypes ?? this.shareTypes,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory SharesInput.fromJson(Map<String, dynamic> json) {
    return SharesInput(
      shareTypes: json['shareTypes']
          ?.map<SHARE_TYPE>((o) => SHARE_TYPE.values.byName(o))
          .toList(),
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['shareTypes'] = shareTypes?.map((item) => item.name).toList();
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SharesInput &&
            (identical(other.shareTypes, shareTypes) ||
                const DeepCollectionEquality()
                    .equals(other.shareTypes, shareTypes)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(shareTypes) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset);
  }

  @override
  String toString() => 'SharesInput(${toJson()})';
}

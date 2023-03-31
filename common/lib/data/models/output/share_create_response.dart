import 'package:iris_common/data/models/output/share.dart';
import 'package:collection/collection.dart';

class ShareCreateResponse {
  final Share? share;
  const ShareCreateResponse({this.share});
  ShareCreateResponse copyWith({Share? share}) {
    return ShareCreateResponse(
      share: share ?? this.share,
    );
  }

  factory ShareCreateResponse.fromJson(Map<String, dynamic> json) {
    return ShareCreateResponse(
      share: json['share'] != null ? Share.fromJson(json['share']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['share'] = share?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ShareCreateResponse &&
            (identical(other.share, share) ||
                const DeepCollectionEquality().equals(other.share, share)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(share);
  }

  @override
  String toString() => 'ShareCreateResponse(${toJson()})';
}

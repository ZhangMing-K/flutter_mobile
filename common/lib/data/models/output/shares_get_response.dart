import 'package:iris_common/data/models/output/share.dart';
import 'package:collection/collection.dart';

class SharesGetResponse {
  final List<Share>? shares;
  const SharesGetResponse({this.shares});
  SharesGetResponse copyWith({List<Share>? shares}) {
    return SharesGetResponse(
      shares: shares ?? this.shares,
    );
  }

  factory SharesGetResponse.fromJson(Map<String, dynamic> json) {
    return SharesGetResponse(
      shares: json['shares']?.map<Share>((o) => Share.fromJson(o)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['shares'] = shares?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SharesGetResponse &&
            (identical(other.shares, shares) ||
                const DeepCollectionEquality().equals(other.shares, shares)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(shares);
  }

  @override
  String toString() => 'SharesGetResponse(${toJson()})';
}

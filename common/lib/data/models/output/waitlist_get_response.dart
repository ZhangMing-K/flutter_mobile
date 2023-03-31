import 'package:iris_common/data/models/output/waitlist.dart';
import 'package:collection/collection.dart';

class WaitlistGetResponse {
  final List<Waitlist>? waitlist;
  const WaitlistGetResponse({this.waitlist});
  WaitlistGetResponse copyWith({List<Waitlist>? waitlist}) {
    return WaitlistGetResponse(
      waitlist: waitlist ?? this.waitlist,
    );
  }

  factory WaitlistGetResponse.fromJson(Map<String, dynamic> json) {
    return WaitlistGetResponse(
      waitlist:
          json['waitlist']?.map<Waitlist>((o) => Waitlist.fromJson(o)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['waitlist'] = waitlist?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WaitlistGetResponse &&
            (identical(other.waitlist, waitlist) ||
                const DeepCollectionEquality()
                    .equals(other.waitlist, waitlist)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(waitlist);
  }

  @override
  String toString() => 'WaitlistGetResponse(${toJson()})';
}

import 'package:iris_common/data/models/output/waitlist.dart';
import 'package:collection/collection.dart';

class WaitlistUserAddResponse {
  final Waitlist? waitlist;
  final bool? newlyCreated;
  const WaitlistUserAddResponse({this.waitlist, this.newlyCreated});
  WaitlistUserAddResponse copyWith({Waitlist? waitlist, bool? newlyCreated}) {
    return WaitlistUserAddResponse(
      waitlist: waitlist ?? this.waitlist,
      newlyCreated: newlyCreated ?? this.newlyCreated,
    );
  }

  factory WaitlistUserAddResponse.fromJson(Map<String, dynamic> json) {
    return WaitlistUserAddResponse(
      waitlist:
          json['waitlist'] != null ? Waitlist.fromJson(json['waitlist']) : null,
      newlyCreated: json['newlyCreated'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['waitlist'] = waitlist?.toJson();
    data['newlyCreated'] = newlyCreated;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WaitlistUserAddResponse &&
            (identical(other.waitlist, waitlist) ||
                const DeepCollectionEquality()
                    .equals(other.waitlist, waitlist)) &&
            (identical(other.newlyCreated, newlyCreated) ||
                const DeepCollectionEquality()
                    .equals(other.newlyCreated, newlyCreated)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(waitlist) ^
        const DeepCollectionEquality().hash(newlyCreated);
  }

  @override
  String toString() => 'WaitlistUserAddResponse(${toJson()})';
}

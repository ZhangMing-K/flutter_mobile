import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/enums/segment_type.dart';
import 'package:collection/collection.dart';

class TopTradersResponse {
  final List<User>? users;
  final SEGMENT_TYPE? segmentType;
  const TopTradersResponse({this.users, this.segmentType});
  TopTradersResponse copyWith({List<User>? users, SEGMENT_TYPE? segmentType}) {
    return TopTradersResponse(
      users: users ?? this.users,
      segmentType: segmentType ?? this.segmentType,
    );
  }

  factory TopTradersResponse.fromJson(Map<String, dynamic> json) {
    return TopTradersResponse(
      users: json['users']?.map<User>((o) => User.fromJson(o)).toList(),
      segmentType: json['segmentType'] != null
          ? SEGMENT_TYPE.values.byName(json['segmentType'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['users'] = users?.map((item) => item.toJson()).toList();
    data['segmentType'] = segmentType?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TopTradersResponse &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)) &&
            (identical(other.segmentType, segmentType) ||
                const DeepCollectionEquality()
                    .equals(other.segmentType, segmentType)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(users) ^
        const DeepCollectionEquality().hash(segmentType);
  }

  @override
  String toString() => 'TopTradersResponse(${toJson()})';
}

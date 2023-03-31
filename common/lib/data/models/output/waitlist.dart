import 'package:iris_common/data/models/enums/waitlist_feature_type.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class Waitlist {
  final int? waitlistKey;
  final int? userKey;
  final int? masterUserKey;
  final WAITLIST_FEATURE_TYPE? featureType;
  final User? user;
  final User? masterUser;
  final DateTime? createdAt;
  final int? position;
  const Waitlist(
      {this.waitlistKey,
      this.userKey,
      this.masterUserKey,
      this.featureType,
      this.user,
      this.masterUser,
      this.createdAt,
      this.position});
  Waitlist copyWith(
      {int? waitlistKey,
      int? userKey,
      int? masterUserKey,
      WAITLIST_FEATURE_TYPE? featureType,
      User? user,
      User? masterUser,
      DateTime? createdAt,
      int? position}) {
    return Waitlist(
      waitlistKey: waitlistKey ?? this.waitlistKey,
      userKey: userKey ?? this.userKey,
      masterUserKey: masterUserKey ?? this.masterUserKey,
      featureType: featureType ?? this.featureType,
      user: user ?? this.user,
      masterUser: masterUser ?? this.masterUser,
      createdAt: createdAt ?? this.createdAt,
      position: position ?? this.position,
    );
  }

  factory Waitlist.fromJson(Map<String, dynamic> json) {
    return Waitlist(
      waitlistKey: json['waitlistKey'],
      userKey: json['userKey'],
      masterUserKey: json['masterUserKey'],
      featureType: json['featureType'] != null
          ? WAITLIST_FEATURE_TYPE.values.byName(json['featureType'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      masterUser:
          json['masterUser'] != null ? User.fromJson(json['masterUser']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      position: json['position'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['waitlistKey'] = waitlistKey;
    data['userKey'] = userKey;
    data['masterUserKey'] = masterUserKey;
    data['featureType'] = featureType?.name;
    data['user'] = user?.toJson();
    data['masterUser'] = masterUser?.toJson();
    data['createdAt'] = createdAt?.toString();
    data['position'] = position;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Waitlist &&
            (identical(other.waitlistKey, waitlistKey) ||
                const DeepCollectionEquality()
                    .equals(other.waitlistKey, waitlistKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.masterUserKey, masterUserKey) ||
                const DeepCollectionEquality()
                    .equals(other.masterUserKey, masterUserKey)) &&
            (identical(other.featureType, featureType) ||
                const DeepCollectionEquality()
                    .equals(other.featureType, featureType)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.masterUser, masterUser) ||
                const DeepCollectionEquality()
                    .equals(other.masterUser, masterUser)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(waitlistKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(masterUserKey) ^
        const DeepCollectionEquality().hash(featureType) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(masterUser) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(position);
  }

  @override
  String toString() => 'Waitlist(${toJson()})';
}

import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class Device {
  final int? deviceKey;
  final int? userKey;
  final User? user;
  final String? deviceToken;
  final DateTime? createdAt;
  const Device(
      {this.deviceKey,
      this.userKey,
      this.user,
      this.deviceToken,
      this.createdAt});
  Device copyWith(
      {int? deviceKey,
      int? userKey,
      User? user,
      String? deviceToken,
      DateTime? createdAt}) {
    return Device(
      deviceKey: deviceKey ?? this.deviceKey,
      userKey: userKey ?? this.userKey,
      user: user ?? this.user,
      deviceToken: deviceToken ?? this.deviceToken,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      deviceKey: json['deviceKey'],
      userKey: json['userKey'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      deviceToken: json['deviceToken'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['deviceKey'] = deviceKey;
    data['userKey'] = userKey;
    data['user'] = user?.toJson();
    data['deviceToken'] = deviceToken;
    data['createdAt'] = createdAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Device &&
            (identical(other.deviceKey, deviceKey) ||
                const DeepCollectionEquality()
                    .equals(other.deviceKey, deviceKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.deviceToken, deviceToken) ||
                const DeepCollectionEquality()
                    .equals(other.deviceToken, deviceToken)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(deviceKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(deviceToken) ^
        const DeepCollectionEquality().hash(createdAt);
  }

  @override
  String toString() => 'Device(${toJson()})';
}

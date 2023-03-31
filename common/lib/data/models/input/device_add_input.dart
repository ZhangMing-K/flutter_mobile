import 'package:iris_common/data/models/enums/device_platform.dart';
import 'package:iris_common/data/models/enums/app_client_type.dart';
import 'package:collection/collection.dart';

class DeviceAddInput {
  final String? deviceToken;
  final DEVICE_PLATFORM? devicePlatform;
  final APP_CLIENT_TYPE? appClientType;
  const DeviceAddInput(
      {required this.deviceToken,
      required this.devicePlatform,
      this.appClientType});
  DeviceAddInput copyWith(
      {String? deviceToken,
      DEVICE_PLATFORM? devicePlatform,
      APP_CLIENT_TYPE? appClientType}) {
    return DeviceAddInput(
      deviceToken: deviceToken ?? this.deviceToken,
      devicePlatform: devicePlatform ?? this.devicePlatform,
      appClientType: appClientType ?? this.appClientType,
    );
  }

  factory DeviceAddInput.fromJson(Map<String, dynamic> json) {
    return DeviceAddInput(
      deviceToken: json['deviceToken'],
      devicePlatform: json['devicePlatform'] != null
          ? DEVICE_PLATFORM.values.byName(json['devicePlatform'])
          : null,
      appClientType: json['appClientType'] != null
          ? APP_CLIENT_TYPE.values.byName(json['appClientType'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['deviceToken'] = deviceToken;
    data['devicePlatform'] = devicePlatform?.name;
    data['appClientType'] = appClientType?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeviceAddInput &&
            (identical(other.deviceToken, deviceToken) ||
                const DeepCollectionEquality()
                    .equals(other.deviceToken, deviceToken)) &&
            (identical(other.devicePlatform, devicePlatform) ||
                const DeepCollectionEquality()
                    .equals(other.devicePlatform, devicePlatform)) &&
            (identical(other.appClientType, appClientType) ||
                const DeepCollectionEquality()
                    .equals(other.appClientType, appClientType)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(deviceToken) ^
        const DeepCollectionEquality().hash(devicePlatform) ^
        const DeepCollectionEquality().hash(appClientType);
  }

  @override
  String toString() => 'DeviceAddInput(${toJson()})';
}

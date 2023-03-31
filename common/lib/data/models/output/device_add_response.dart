import 'package:iris_common/data/models/output/device.dart';
import 'package:collection/collection.dart';

class DeviceAddResponse {
  final Device? device;
  const DeviceAddResponse({this.device});
  DeviceAddResponse copyWith({Device? device}) {
    return DeviceAddResponse(
      device: device ?? this.device,
    );
  }

  factory DeviceAddResponse.fromJson(Map<String, dynamic> json) {
    return DeviceAddResponse(
      device: json['device'] != null ? Device.fromJson(json['device']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['device'] = device?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeviceAddResponse &&
            (identical(other.device, device) ||
                const DeepCollectionEquality().equals(other.device, device)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(device);
  }

  @override
  String toString() => 'DeviceAddResponse(${toJson()})';
}

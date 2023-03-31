import 'package:iris_common/data/models/output/user_settings.dart';
import 'package:collection/collection.dart';

class UserSettingsUpdateResponse {
  final UserSettings? userSettings;
  const UserSettingsUpdateResponse({this.userSettings});
  UserSettingsUpdateResponse copyWith({UserSettings? userSettings}) {
    return UserSettingsUpdateResponse(
      userSettings: userSettings ?? this.userSettings,
    );
  }

  factory UserSettingsUpdateResponse.fromJson(Map<String, dynamic> json) {
    return UserSettingsUpdateResponse(
      userSettings: json['userSettings'] != null
          ? UserSettings.fromJson(json['userSettings'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userSettings'] = userSettings?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserSettingsUpdateResponse &&
            (identical(other.userSettings, userSettings) ||
                const DeepCollectionEquality()
                    .equals(other.userSettings, userSettings)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userSettings);
  }

  @override
  String toString() => 'UserSettingsUpdateResponse(${toJson()})';
}

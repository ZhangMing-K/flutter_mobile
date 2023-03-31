import '../../iris_common.dart';

extension IntegrationExt on Integration {
  String get displayName {
    String displayUsername = '';

    if (username != null && username!.isNotEmpty) {
      displayUsername = '@' + username!;
    }
    return displayUsername;
  }
}

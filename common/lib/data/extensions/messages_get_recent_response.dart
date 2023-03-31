import 'package:iris_common/iris_common.dart';

extension ContainsExt on MessagesGetRecentResponse {
  bool contains(TextModel message) {
    return messages?.any((element) => message.textKey == element.textKey) ??
        false;
  }
}

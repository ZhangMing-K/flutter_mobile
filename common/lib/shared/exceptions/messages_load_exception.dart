import 'iris_exception.dart';

class MessagesLoadException implements IrisException {
  @override
  String message = "Can't load messages";
  @override
  String toString() {
    return message;
  }
}

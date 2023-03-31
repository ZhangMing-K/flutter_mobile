import 'iris_exception.dart';

class InboxLoadDataException implements IrisException {
  @override
  String message = "Can't load inbox data";
  @override
  String toString() {
    return message;
  }
}

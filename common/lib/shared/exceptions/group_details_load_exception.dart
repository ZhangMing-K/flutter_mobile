import 'iris_exception.dart';

class GroupDetailsLoadException implements IrisException {
  @override
  String message = "Can't load group details";
  @override
  String toString() {
    return message;
  }
}

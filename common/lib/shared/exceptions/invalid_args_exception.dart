import 'iris_exception.dart';

class InvalidArgsException implements IrisException {
  @override
  String message = 'Invalid argument';
  @override
  String toString() {
    return message;
  }
}

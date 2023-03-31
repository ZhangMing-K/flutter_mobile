import 'iris_exception.dart';

class PoorConnectionException implements IrisException {
  @override
  final String message = 'Slow or non-existent connection.';
  @override
  String toString() {
    return message;
  }
}

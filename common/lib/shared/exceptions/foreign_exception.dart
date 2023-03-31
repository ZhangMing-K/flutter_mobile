import 'iris_exception.dart';

class ForeignException implements IrisException {
  final Object error;
  final StackTrace stack;
  @override
  final String message;

  ForeignException(this.error, this.stack)
      : message = 'ForeignException exception: ERROR: $error, MESSAGE: $stack';

  @override
  String toString() {
    return message;
  }
}

import 'iris_exception.dart';

class TokenExpiredException implements IrisException {
  @override
  String message = 'Token expired';
  @override
  String toString() {
    return message;
  }
}

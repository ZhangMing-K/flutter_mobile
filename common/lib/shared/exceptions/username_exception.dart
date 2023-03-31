import 'iris_exception.dart';

class UsernameException extends IrisException {
  UsernameException(this.message);

  @override
  final String message;
}

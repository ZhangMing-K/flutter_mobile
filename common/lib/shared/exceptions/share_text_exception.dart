import 'iris_exception.dart';

class ShareTextException implements IrisException {
  @override
  String message = 'Unable to share';
  @override
  String toString() {
    return message;
  }
}

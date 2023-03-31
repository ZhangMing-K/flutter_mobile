import 'iris_exception.dart';

class ProfilePostsLoadException implements IrisException {
  @override
  String message = "Can't load profile posts";
  @override
  String toString() {
    return message;
  }
}

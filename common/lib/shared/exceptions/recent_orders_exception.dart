import 'iris_exception.dart';

class RecentOrdersException implements IrisException {
  @override
  String message = "Can't load recent orders";
  @override
  String toString() {
    return message;
  }
}

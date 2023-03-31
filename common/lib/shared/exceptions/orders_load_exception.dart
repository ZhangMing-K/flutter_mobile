import 'iris_exception.dart';

class OrdersLoadException implements IrisException {
  @override
  String message = "Can't load inbox data, orders";
  @override
  String toString() {
    return message;
  }
}

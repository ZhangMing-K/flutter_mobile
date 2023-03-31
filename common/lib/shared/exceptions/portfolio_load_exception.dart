import 'iris_exception.dart';

class PortfolioLoadException implements IrisException {
  @override
  String message = "Can't load inbox data, portfolio";
  @override
  String toString() {
    return message;
  }
}

import 'iris_exception.dart';

class ProfilePortfolioException implements IrisException {
  @override
  String message = "Can't load portfolio data";
  @override
  String toString() {
    return message;
  }
}

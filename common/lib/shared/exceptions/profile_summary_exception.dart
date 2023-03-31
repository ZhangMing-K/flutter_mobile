import 'iris_exception.dart';

class ProfileSummaryException implements IrisException {
  @override
  String message = "Can't load profile summary";
  @override
  String toString() {
    return message;
  }
}

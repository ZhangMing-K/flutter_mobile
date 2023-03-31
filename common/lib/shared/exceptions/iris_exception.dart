abstract class IrisException implements Exception {
  String get message;

  @override
  String toString() {
    return 'Iris Exception[$runtimeType]: $message';
  }
}

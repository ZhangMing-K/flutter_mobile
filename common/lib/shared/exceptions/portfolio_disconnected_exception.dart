class PortfolioDisconnectedException implements Exception {
  late String _message;

  PortfolioDisconnectedException(
      [String message = 'Portfolio is disconneted']) {
    _message = message;
  }

  @override
  String toString() {
    return _message;
  }
}

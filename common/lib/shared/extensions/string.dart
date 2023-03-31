extension StringExtension on String {
  String capitalizeFirstApp() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  bool parseBool() {
    return toLowerCase() == 'true';
  }

  shortenLong({int max = 20, bool trailingDots = false}) {
    if (length >= max) {
      String str = substring(0, max);
      if (trailingDots) {
        str += '...';
      }
      return str;
    }
    return this;
  }
}

import 'package:collection/collection.dart' show IterableExtension;

T? enumFromString<T>(List<T> values, String? value) {
  return values.firstWhereOrNull((v) => v.toString().split('.')[1] == value);
}

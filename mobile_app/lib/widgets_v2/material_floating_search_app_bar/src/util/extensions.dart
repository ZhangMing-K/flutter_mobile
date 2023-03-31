import 'dart:math' as math;

extension NumExtension on num {
  double get radians => this * (math.pi / 180.0);

  double get degrees => this * (180.0 / math.pi);
}

import 'package:flutter/material.dart';

class IrisColors {
  final Color green;
  final Color red;
  final Color black;
  final Color white;

  IrisColors({
    required this.green,
    required this.red,
    required this.black,
    required this.white,
  });

  factory IrisColors.lightMode() => IrisColors(
        green: const Color(0xFF50840B),
        red: const Color(0xFFD11C25),
        black: const Color(0xFF222222),
        white: const Color(0xFFFFFFFF),
      );

  factory IrisColors.darkMode() => IrisColors(
        green: const Color(0xFF8DCB2C),
        red: const Color(0xFFFF5018),
        black: const Color(0xFF000000),
        white: const Color(0xFFF5F6FA),
      );
}

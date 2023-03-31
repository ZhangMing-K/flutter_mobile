import 'package:flutter/material.dart';

class Decorations {
  static var boxShadow = [
    BoxShadow(
        blurRadius: 60.0, // has the effect of softening the shadow
        spreadRadius: 0.0,
        color: const Color(0xFFB6C1CF).withOpacity(0.70),
        offset: const Offset(
          6,
          0,
        ))
  ];

  static var boxShadowButtons = [
    BoxShadow(
        blurRadius: 24.0, // has the effect of softening the shadow
        spreadRadius: 0.0,
        color: const Color(0xFFB6C1CF).withOpacity(0.34),
        offset: const Offset(
          0,
          6,
        ))
  ];

  static var boxShadowDialog = [
    BoxShadow(
        blurRadius: 34.0,
        spreadRadius: 0.0,
        color: const Color(0xFFB6C1CF).withOpacity(0.21),
        offset: const Offset(
          10,
          10,
        ))
  ];

  static var boxShadowBottom = [
    BoxShadow(
        blurRadius: 34.0, // has the effect of softening the shadow
        spreadRadius: 0.0,
        color: const Color(0xFFB6C1CF).withOpacity(0.21),
        offset: const Offset(
          0.0,
          0.21,
        ))
  ];

  static var linearGradient = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF21CE99), Color(0xFF98F3D7)]));

  Decorations._();
}

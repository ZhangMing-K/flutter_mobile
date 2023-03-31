import 'package:flutter/material.dart';

class TabItem<T> {
  TabItem(
      {required this.name,
      required this.id,
      required this.child,
      this.upperText,
      this.reverse = false});
  String name;
  String? upperText;
  T id;
  Widget child;
  bool reverse;
}

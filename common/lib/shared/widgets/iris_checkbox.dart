import 'package:flutter/material.dart';

/// returns a styled checkbox specific to the Iris app
/// if the function is not provided, then the checkbox will not show up
class IrisCheckbox extends StatelessWidget {
  const IrisCheckbox({Key? key, required this.selected, this.onChanged})
      : super(key: key);

  final bool selected;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: selected,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}

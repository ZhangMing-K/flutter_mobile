import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../themes/colors.dart';

class IrisRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Widget? title;
  final ValueChanged<T?> onChanged;
  final bool isGoldCheck;
  final bool showLeading;

  const IrisRadioListTile({
    Key? key,
    required this.value,
    required this.groupValue,
    this.isGoldCheck = false,
    this.title,
    required this.onChanged,
    this.showLeading = true,
  }) : super(key: key);

  List<Color> get getGradient {
    if (!isSelected) {
      return [Colors.transparent, Colors.transparent];
    } else if (isGoldCheck) {
      return IrisColor.goldGradient.colors;
    } else {
      return [IrisColor.primaryColor, IrisColor.primaryColor];
    }
  }

  bool get isSelected => value == groupValue;

  Color get tickColor {
    if (!isSelected) return Colors.transparent;
    return isGoldCheck ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            if (showLeading) ...[
              _customRadioButton(),
              const SizedBox(width: 12),
            ],
            if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget _customRadioButton() {
    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.all(1.7),
        child: Icon(
          UniconsLine.check,
          color: tickColor,
        ),
        decoration: BoxDecoration(
          // color: isSelected ? IrisColor.primaryColor : null,
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
            colors: getGradient,
          ),
          border: Border.all(
            color: isSelected
                ? isGoldCheck
                    ? IrisColor.gold
                    : IrisColor.primaryColor
                : context.theme.colorScheme.secondary.withOpacity(.4),
            width: 1,
          ),
        ),
      );
    });
  }
}

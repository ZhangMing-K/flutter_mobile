import 'package:flutter/material.dart';
import '../../shared/themes/colors.dart';

import 'iris_radio_listile.dart';

class IrisOptionSelection<T> extends StatelessWidget {
  final T planType;
  final T selectedType;
  final String title;
  final String subtitle;
  final ValueChanged<T?> onSelected;
  final String price;
  final String? discount;
  final bool isGold;
  final bool showLeading;
  final Widget? trailingWidget;
  const IrisOptionSelection({
    Key? key,
    required this.planType,
    required this.selectedType,
    required this.title,
    required this.subtitle,
    required this.onSelected,
    required this.price,
    required this.discount,
    this.showLeading = true,
    this.isGold = true,
    this.trailingWidget,
  }) : super(key: key);

  List<Color> get colors {
    if (!isSelected) {
      return <Color>[Colors.grey, Colors.grey];
    }
    if (isGold) {
      return IrisColor.goldGradient.colors;
    } else {
      return [IrisColor.irisBlue, IrisColor.irisBlue];
    }
  }

  bool get isSelected => selectedType == planType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(1.5),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: colors,
        ),
        // border: Border.all(
        //   width: 1.0,
        //   color: isSelected ? IrisColor.gold : Colors.grey,
        // ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(7.8),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            IrisRadioListTile<T>(
              showLeading: showLeading,
              isGoldCheck: isGold,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              value: selectedType,
              groupValue: planType,
              onChanged: onSelected,
            ),
            if (trailingWidget != null)
              Positioned(right: 0, child: Center(child: trailingWidget!))
            else
              Positioned(
                right: 15,
                top: 10,
                // alignment: Alignment.topRight,
                child: Row(
                  children: [
                    if (discount != null)
                      Text(
                        discount!,
                        style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.red,
                        ),
                      ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

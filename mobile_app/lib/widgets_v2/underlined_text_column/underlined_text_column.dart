import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeyValues {
  Widget? key;
  Widget? value;
  KeyValues({this.key, this.value});
}

class UnderlinedTextColumn extends StatelessWidget {
  final List<KeyValues> keyValues;
  final Widget? title;
  const UnderlinedTextColumn({Key? key, required this.keyValues, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: grid());
  }

  List<Widget> buildKeyValues(List<KeyValues> keyValuesSet) {
    final List<Widget> list = [];
    for (final kv in keyValuesSet) {
      list.add(underlinedKeyValue(kv.key, kv.value));
    }
    return list;
  }

  Widget grid() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Container(child: title), ...buildKeyValues(keyValues)]);
  }

  Widget underlinedKeyValue(Widget? key, Widget? value) {
    return Padding(
        padding: const EdgeInsets.all(3),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [key!, value!]),
            const Padding(
              padding: EdgeInsets.all(3),
            ),
            Builder(
              builder: (context) => Divider(
                color: context.theme.colorScheme.secondary.withOpacity(0.15),
                height: 0.1,
              ),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoItem {
  InfoItem({required this.title, this.value, this.valueWidget});
  String title;
  String? value;
  Widget? valueWidget;
}

class InfoColumn {
  InfoColumn({required this.items});
  List<InfoItem> items;
}

class HorizontalInfo extends StatelessWidget {
  const HorizontalInfo(
      {Key? key,
      this.height = 80,
      required this.columns,
      this.backgroundColor = Colors.white})
      : super(key: key);
  final double height;
  final List<InfoColumn> columns;
  final Color backgroundColor;

  List<Widget> getColumns() {
    final List<Widget> list = [];
    for (var i = 0; i < columns.length; i++) {
      final column = columns[i];
      list.add(makeColumn(infoColumn: column));
      if (columns.length - 1 != i) {
        list.add(Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: const VerticalDivider(
            width: 1,
            indent: 5,
            endIndent: 5,
          ),
        ));
      }
    }

    return list;
  }

  Widget makeColumn({required InfoColumn infoColumn}) {
    final List<Widget> rows = [];
    for (var element in infoColumn.items) {
      rows.add(SizedBox(
        width: 170,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              element.title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            if (element.value != null)
              Text(
                element.value!,
                style: const TextStyle(fontSize: 14),
              ),
            if (element.valueWidget != null) element.valueWidget!,
          ],
        ),
      ));
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rows,
      ),
    );
  }

  @override
  build(BuildContext context) {
    return Container(
      height: height,
      color: context.theme.backgroundColor,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [...getColumns()],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollableTable extends StatelessWidget {
  const ScrollableTable(
      {Key? key, required this.fixedColumn, required this.scrollableColumn})
      : super(key: key);
  final List<Widget> fixedColumn;
  final List<Widget> scrollableColumn;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: fixedColumn,
          ),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: scrollableColumn,
              ),
            ),
          )
        ],
      ),
    );
  }
}

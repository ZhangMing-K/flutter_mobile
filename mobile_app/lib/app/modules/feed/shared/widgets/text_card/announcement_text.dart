import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class AnnouncementText extends StatelessWidget {
  final TextModel? text;

  const AnnouncementText({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [firstRow(), secondRow()],
      ),
    );
  }

  firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            image(),
            const Text(
              'Announcement',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            Text(
              text!.dateFrom,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        )
      ],
    );
  }

  Widget image() {
    return Image.asset(
      Images.logo,
      height: 50,
    );
  }

  secondRow() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Flexible(
            child: Text(
              text!.value!,
            ),
          )
        ],
      ),
    );
  }
}

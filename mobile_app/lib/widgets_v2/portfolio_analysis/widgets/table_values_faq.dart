import 'package:flutter/material.dart';

class TableValuesFAQ extends StatelessWidget {
  const TableValuesFAQ({Key? key, required this.faqItems, this.panelTitle})
      : super(key: key);
  final String? panelTitle;
  final List<FAQItem> faqItems;

  Widget faqItem(String? title, String answer) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title is String)
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 10),
          Text(
            answer,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 20),
          Divider(
            color: Colors.black.withOpacity(0.2),
            height: 0.3,
          )
        ],
      ),
    );
  }

  List<Widget> getItems() {
    final List<Widget> items = [];
    for (FAQItem faq in faqItems) {
      items.add(faqItem(faq.title, faq.answer));
    }
    return items;
  }

  Widget main() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...getItems(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (panelTitle is String)
            Text(
              panelTitle!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          main(),
        ]);
  }
}

class FAQItem {
  FAQItem({
    required this.title,
    required this.answer,
  });
  String? title;
  String answer;
}

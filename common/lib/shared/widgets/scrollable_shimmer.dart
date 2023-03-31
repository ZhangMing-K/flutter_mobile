import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'text_card_shimmer.dart';

class ShimmerScroll extends StatelessWidget {
  const ShimmerScroll({
    this.useSpinner = false,
    Key? key,
  }) : super(key: key);

  final bool useSpinner;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return TextCardShimmer(
              margin: const EdgeInsets.only(top: 8), useSpinner: useSpinner);
        });
  }
}

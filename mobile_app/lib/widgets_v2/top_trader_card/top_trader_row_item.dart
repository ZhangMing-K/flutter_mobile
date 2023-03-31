import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../app/modules/explorer/modules/who_to_follow/widgets/explorer_header.dart';
import 'top_trader_card.dart';

class TopTraderRow extends StatelessWidget {
  const TopTraderRow(
      {Key? key,
      required this.headerText,
      required this.topInvestors,
      this.saveToRecent,
      this.afterStories})
      : super(key: key);
  final String headerText;
  final List<User> topInvestors;
  final Function? saveToRecent;
  final Function? afterStories;

  @override
  Widget build(BuildContext context) {
    final scaleFactor = context.textScaleFactor;
    return Obx(() {
      return topInvestors.isNotEmpty
          ? SizedBox(
              height: 400 * scaleFactor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExplorerHeader(text: headerText),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      addAutomaticKeepAlives: false,
                      primary: false,
                      itemCount: topInvestors.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        // if (topInvestors[index] == null) {
                        //   return Container();
                        // }
                        return TopInvestorCard(
                          user: topInvestors[index],
                          marginLeft: index == 0 ? 16 : 6,
                          saveToRecent: saveToRecent,
                          afterStories: afterStories,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : Container();
    });
  }
}

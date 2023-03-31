import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class FollowingOptions extends StatelessWidget {
  final User? user;
  final FollowActionFunction refreshParent;
  final int? portfolioKey;
  const FollowingOptions({
    Key? key,
    this.user,
    required this.refreshParent,
    this.portfolioKey,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => {
        FollowerView.openPannel(
            portfolioKey: portfolioKey,
            userKey: user!.userKey,
            context: context,
            pannelActions: [PANNEL_ITEMS.STOP_FOLLOWING],
            refreshParent: refreshParent)
      },
      child: SizedBox(
          height: 30,
          width: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.more_horiz,
                color: Colors.grey,
              ),
            ],
          )),
    );
  }
}

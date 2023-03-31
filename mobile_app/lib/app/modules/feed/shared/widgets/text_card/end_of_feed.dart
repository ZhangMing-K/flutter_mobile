import 'package:flutter/material.dart';
import 'package:iris_mobile/app/routes/pages.dart';

class EndOfFeed extends StatelessWidget {
  const EndOfFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 56.0, horizontal: 19),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "You're all caught up!",
            style: Theme.of(context).textTheme.headline4,
          ),
          //todo replace with GIF
          Image.asset(Images.blueCheckGif),
          Text(
            "Keep scrolling to see more posts and people you might like.",
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

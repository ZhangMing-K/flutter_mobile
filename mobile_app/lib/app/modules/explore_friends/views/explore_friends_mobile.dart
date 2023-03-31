import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class ExploreFriendsMobile extends StatelessWidget {
  const ExploreFriendsMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Friends'),
      ),
      body: InviteFriends(),
    );
  }
}

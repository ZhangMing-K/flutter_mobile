import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/onboarding/modules/invited_by/controllers/invited_by_controller.dart';

class EmptyUserStoriesHeader extends StatelessWidget {
  const EmptyUserStoriesHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SizedBox(width: 16),
        _ConnectContacts(),
      ],
    );
  }
}

class _ConnectContacts extends GetView<InvitedByController> {
  const _ConnectContacts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.shareInviteLink();
        // controller.syncContacts();
        // controller.goToBuildYourCommunity();
      },
      child: Column(
        children: [
          const CircleAvatar(
            radius: 32.0,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.people,
              size: 32,
              color: Colors.white,
            ),
          ),
          Text('Invite',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w300)),
          Text('Friends',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}

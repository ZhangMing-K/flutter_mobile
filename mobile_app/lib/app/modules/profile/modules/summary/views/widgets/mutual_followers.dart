import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class MutualFollowers extends StatelessWidget {
  const MutualFollowers({
    required this.mutual,
    Key? key,
  }) : super(key: key);

  final MutualFollowedBy mutual;

  @override
  Widget build(BuildContext context) {
    final users = mutual.users ?? <User>[];
    if (users.isEmpty) return Container();
    return _FollowersRow(
      users: users,
    );
  }
}

class _FollowersRow extends StatelessWidget {
  const _FollowersRow({
    Key? key,
    required this.users,
  }) : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          _StackedProfileImages(users: users),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              'Followed by ${users[0].fullName}${users.length > 1 ? ', ${users[1].fullName}${users.length > 2 ? ' and ${users.length - 2} other${users.length > 3 ? 's' : ''}' : ''}' : ''}',
              softWrap: true,
              style: context.textTheme.bodyText2
                  ?.copyWith(color: context.theme.custom.colorScheme.grayText),
            ),
          ),
        ],
      ),
    );
  }
}

class _StackedProfileImages extends StatelessWidget {
  const _StackedProfileImages({
    Key? key,
    required this.users,
  }) : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    users.asMap().forEach((key, value) {
      User user = users[key];
      double offset = (key * 12).toDouble();
      children.add(Padding(
        padding: EdgeInsets.only(right: offset),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          child: ProfileImage(
            url: user.profilePictureUrl,
            uuid: uuid.v4(),
            radius: 15,
          ),
        ),
      ));
    });
    return Stack(
      alignment: Alignment.centerRight,
      children: children,
    );
  }
}

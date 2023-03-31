import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class AutoCompleteUserRow extends StatelessWidget {
  final User user;

  final Function(User, String)? onTap;
  const AutoCompleteUserRow({Key? key, required this.user, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: ListTile(
        onTap: () {
          if (onTap != null) {
            onTap!(user, getText());
          }
        },
        leading: ProfileImage(
          url: user.profilePictureUrl,
          uuid: uuid.v4(),
        ),
        title: UserName(
          user: user,
          fontSize: 16,
          route: false,
        ),
        subtitle: (user.username == null) ? null : Text(user.username!),
      ),
    );
  }

  getText() {
    final Map<String, dynamic> userJson = {
      'type': 'user',
      'value': '@${user.firstName}',
      'userKey': user.userKey,
    };
    final String userJsonStr = jsonEncode(userJson);
    final String userString = '<C $userJsonStr>@${user.fullName}</C>';

    return userString;
  }
}

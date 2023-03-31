import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iris_common/iris_common.dart';
import 'package:unicons/unicons.dart';

class BioFooter extends StatelessWidget {
  const BioFooter({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.5, top: 16),
      child: Row(
        children: [
          // TODO LINKS
          // const Spacer(),
          Row(
            children: [
              const Icon(
                UniconsLine.calendar_alt,
                color: Color(0xff9e9e9e),
              ),
              Text(
                ' Joined ${DateFormat.yMMMM().format(user.createdAt ?? DateTime.now())}',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: Theme.of(context).custom.colorScheme.grayText),
              )
            ],
          )
        ],
      ),
    );
  }
}

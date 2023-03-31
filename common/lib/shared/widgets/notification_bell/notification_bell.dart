import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class NotificationBell extends StatelessWidget {
  const NotificationBell({
    Key? key,
    required this.nbrUnseenNotifications,
    required this.isActive,
  }) : super(key: key);
  final int? nbrUnseenNotifications;

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: SizedBox(
                height: 29,
                width: 29,
                child: SvgPicture.asset(
                  isActive ? Images.activeBell : Images.bell,
                  color: context.theme.colorScheme.secondary,
                  height: 29,
                ),
              ),
            ),
          ],
        ),
        if (nbrUnseenNotifications != null && nbrUnseenNotifications! > 0)
          RedDot(nbr: nbrUnseenNotifications!)
      ],
    );
  }
}

class RedDot extends StatelessWidget {
  const RedDot({Key? key, this.nbr}) : super(key: key);
  final int? nbr;

  @override
  Widget build(BuildContext context) {
    String displayNbr = nbr.toString();
    double fontSize = 11;
    if (nbr != null && nbr! > 2) {
      displayNbr = '3+';
      fontSize = 9;
    }
    return Positioned(
      right: 0,
      left: 13,
      top: 7,
      child: Container(
        height: 17,
        child: nbr != null
            ? Center(
                child: Text(
                  displayNbr,
                  style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              )
            : null,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

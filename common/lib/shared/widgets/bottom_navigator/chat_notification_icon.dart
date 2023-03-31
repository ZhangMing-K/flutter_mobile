import 'package:flutter/material.dart';

class ChatNotificationIcon extends StatelessWidget {
  final Widget icon;

  final int? nbr;
  const ChatNotificationIcon({Key? key, required this.icon, this.nbr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String displayNbr = nbr.toString();
    const double fontSize = 11;

    const Color color = Color.fromRGBO(233, 73, 81, 1);
    BoxDecoration decoration =
        const BoxDecoration(shape: BoxShape.circle, color: color);
    if (nbr != null) {
      if (nbr! > 10) {
        displayNbr = '10+';

        decoration = BoxDecoration(
            shape: BoxShape.rectangle,
            color: color,
            borderRadius: BorderRadius.circular(10));
      }
    }

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(child: icon),
          ],
        ),
        if (nbr != null && nbr! > 0)
          Positioned(
            top: -1,
            right: -3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: decoration,
              alignment: Alignment.center,
              child: Text(displayNbr,
                  style:
                      const TextStyle(color: Colors.white, fontSize: fontSize)),
            ),
          )
      ],
    );
  }
}

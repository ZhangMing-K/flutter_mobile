import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBar extends StatelessWidget {
  final Widget profile;
  final String name;
  final Widget status;
  final double height;
  final Gradient? gradient;
  final Color? color;
  final List<Widget> actions;
  final int actionspacer;
  final TextStyle? usernamestyle;
  final TextStyle? statusstyle;
  final Function()? onAppBarTap;
  final bool hasSubtitle;

  const ChatBar(
      {Key? key,
      this.onAppBarTap,
      this.gradient,
      this.color,
      this.usernamestyle,
      this.statusstyle,
      this.actionspacer = 1,
      this.height = 70,
      this.hasSubtitle = true,
      required this.name,
      required this.actions,
      required this.profile,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: SafeArea(
        // value: overlayStyle,
        child: Container(
          decoration: BoxDecoration(color: color, gradient: gradient),
          //TODO: When the back button is pressed, a noticable difference in positioning of the back buttons can be seen
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const BackButton(),
              Flexible(
                child: GestureDetector(
                  onTap: onAppBarTap,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      profile,
                      const SizedBox(
                        width: 6.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Flexible(
                              child: AutoSizeText(
                                // GetUtils.capitalize(name)!,
                                name, // Show the same as in the profile page.
                                style: usernamestyle ??
                                    TextStyle(
                                        fontSize: ScreenUtil().setSp(17),
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                            if (hasSubtitle) status,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //push actions to end of row
              //  Expanded(
              Container(),

              ...actions.map((item) {
                return item;
              }).toList(),
            ],
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(5),
        ),
      ),
    );
  }
}

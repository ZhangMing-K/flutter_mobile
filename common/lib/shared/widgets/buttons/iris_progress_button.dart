import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IrisProgressButton extends StatefulWidget {
  ///main button was tapped
  final VoidCallback onTap;

  ///x was tapped or the animation completed
  final VoidCallback onCancel;
  final Widget leading;
  final String title;
  final Color color;

  ///whether or not the progress animation should start
  final bool? countDown;

  const IrisProgressButton({
    Key? key,
    required this.onTap,
    required this.onCancel,
    required this.leading,
    required this.title,
    required this.color,
    required this.countDown,
  }) : super(key: key);

  @override
  _IrisProgressButtonState createState() => _IrisProgressButtonState();
}

class _IrisProgressButtonState extends State<IrisProgressButton>
    with SingleTickerProviderStateMixin {
  ///shared containerHeight for background container and progress
  double containerHeight = 40;

  ///the width of the container that shows the progress
  double progressContainerWidth = 0;

  //used to start the animtion to hide the button
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: visible ? 8.0 : 0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: containerHeight,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: widget.leading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(13),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 14,
                    ),
                    onPressed: hide,
                  )
                ],
              ),
            ),
            //progress container
            AnimatedContainer(
              duration: Duration(milliseconds: visible ? 10000 : 200),
              onEnd: hide,
              color: Colors.white24,
              height: containerHeight,
              width: widget.countDown! ? MediaQuery.of(context).size.width : 0,
            ),
          ],
        ),
      ),
    );
  }

  ///timer has expired or cancel pressed
  hide() {
    ///workaround to avoid onCancel being called twice
    ///calls on cancel after the closing animation has finished
    if (!visible) {
      widget.onCancel();
    } else {
      setState(() {
        visible = false;
        containerHeight = 0;
      });
    }
  }
}

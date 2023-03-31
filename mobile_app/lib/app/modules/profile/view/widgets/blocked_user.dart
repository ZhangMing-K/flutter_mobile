import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class BlockedUser extends StatelessWidget {
  const BlockedUser(
      {Key? key,
      this.message = "You have blocked this user",
      required this.onPressed})
      : super(key: key);

  final String message;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: context.height / 5,
              ),
              Column(
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24.0,
                      // color: Colors.black54,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: context.height / 50,
                  ),
                  Icon(
                    Icons.block,
                    size: context.width / 2,
                    color: Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 10, width: 20),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        context.theme.custom.colorScheme.primaryBlue),
                    enableFeedback: true,
                  ),
                  onPressed: onPressed,
                  child: Text(
                    'Unblock',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: IrisScreenUtil.dFontSize(14)),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

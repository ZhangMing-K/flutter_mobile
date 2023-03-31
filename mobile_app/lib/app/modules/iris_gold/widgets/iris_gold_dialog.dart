import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class IrisGoldDialog extends StatelessWidget {
  const IrisGoldDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      insetPadding: const EdgeInsets.only(
        top: 10.0,
        right: 10,
        left: 10,
        bottom: 40,
      ),
      title: const Center(
        child: Text(
          'Welcome to Iris Gold!',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Builder(builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/balloon.png',
              width: context.width / 2,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'See what the top 10% are trading, use filters, see all of today’s streaks and more!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Your settings can be managed from your profile page.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 43,
              child: OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.grey[850]),
                  side: MaterialStateProperty.all(const BorderSide(
                    color: IrisColor.gold,
                  )),
                ),
                child: const Text(
                  "Explore Gold",
                  style: TextStyle(
                    color: IrisColor.gold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/consts/images.dart';
import '../../shared/themes/colors.dart';

class FullScreenVersion extends StatelessWidget {
  final VoidCallback onSkip;

  final VoidCallback onUpdate;
  final String changelog;
  const FullScreenVersion({
    Key? key,
    required this.onSkip,
    required this.onUpdate,
    required this.changelog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Container(
          color: context.theme.scaffoldBackgroundColor,
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            height: 45,
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                IrisColor.irisBlue,
              )),
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: onUpdate,
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: onSkip,
              child: const Text('Skip'),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.height / 10,
                ),
                Image.asset(
                  Images.irisWhiteLogo,
                  color: context.theme.colorScheme.secondary,
                  width: context.width / 3.7,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Update available',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: context.width / 6.5,
                    top: 5.0,
                    left: context.width / 14,
                    right: context.width / 14,
                  ),
                  child: const Text(
                    'A new version of the Iris App has been released.\n We recommend you update now.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                if (changelog.isNotEmpty)
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: context.width / 14,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'What\'s new:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            changelog,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // Container(height: 400, color: Colors.red),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

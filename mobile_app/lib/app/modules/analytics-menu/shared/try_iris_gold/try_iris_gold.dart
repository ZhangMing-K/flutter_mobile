import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class IrisGoldWidget extends StatelessWidget {
  final String title;
  const IrisGoldWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(title,
                  style: const TextStyle(
                      color: IrisColor.gold,
                      fontSize: 20,
                      fontWeight: FontWeight.w700))),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: context.theme.backgroundColor),
            child: Column(
              children: [
                const Text('Want to buy like the best?',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color.fromRGBO(212, 190, 95, 1),
                        Color.fromRGBO(255, 239, 168, 1),
                        Color.fromRGBO(212, 190, 95, 1),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        Image.asset(
                          Images.analyticBlack,
                          width: 30,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text(
                          'Try Iris Gold',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

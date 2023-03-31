import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class NoOrdersView extends StatelessWidget {
  @override
  const NoOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                Images.noItemsInFeed,
                height: 150,
              ),
              const Text(
                'No orders',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        )
      ],
    );
  }
}

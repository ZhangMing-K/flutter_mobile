import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class StreakShimmer extends StatelessWidget {
  const StreakShimmer({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return fullPage();
  }

  Widget fullPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [...getTableShimmers()],
    );
  }

  List<Widget> getTableShimmers() {
    final List<Widget> shimList = [];
    for (int i = 0; i < 3; i++) {
      shimList.add(Container(
          margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.all(16),
          height: 82,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const ShimmerRow(
                    height: 50,
                    width: 50,
                    borderRadius: 10,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      ShimmerRow(
                        height: 15,
                        width: 60,
                        borderRadius: 5,
                      ),
                      SizedBox(height: 4),
                      ShimmerRow(
                        height: 15,
                        width: 60,
                        borderRadius: 5,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      ShimmerRow(
                        height: 15,
                        width: 60,
                        borderRadius: 5,
                      ),
                      SizedBox(height: 4),
                      ShimmerRow(
                        height: 15,
                        width: 60,
                        borderRadius: 5,
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      ShimmerRow(
                        height: 15,
                        width: 93,
                        borderRadius: 5,
                      ),
                      SizedBox(height: 4),
                      ShimmerRow(
                        height: 15,
                        width: 93,
                        borderRadius: 5,
                      ),
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ShimmerRow(
                    height: 15,
                    width: 40,
                    borderRadius: 5,
                  ),
                  SizedBox(height: 4),
                  ShimmerRow(
                    height: 15,
                    width: 60,
                    borderRadius: 5,
                  ),
                ],
              ),
            ],
          )));
    }
    return shimList;
  }
}

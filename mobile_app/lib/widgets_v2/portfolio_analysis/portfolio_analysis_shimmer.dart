import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class PortfolioAnalysisShimmer extends StatelessWidget {
  const PortfolioAnalysisShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * .75,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            firstRow(),
            const SizedBox(
              height: 20,
            ),
            SizedBox(child: secondRow(), height: 75),
            const SizedBox(
              height: 30,
            ),
            lastRow(),
            const SizedBox(
              height: 30,
            ),
            ...getTableShimmers(),
          ],
        ),
      ),
    );
  }

  firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        ShimmerRow(
          height: 30,
          width: 100,
          borderRadius: 5,
        ),
        SizedBox(width: 20),
        ShimmerRow(
          height: 30,
          width: 120,
          borderRadius: 5,
        ),
      ],
    );
  }

  List<Widget> getTableShimmers() {
    final List<Widget> shimList = [];
    for (int i = 0; i < 10; i++) {
      shimList.add(Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              ShimmerRow(
                height: 40,
                width: 40,
                borderRadius: 10,
              ),
              ShimmerRow(
                height: 15,
                width: 35,
                borderRadius: 5,
              ),
              ShimmerRow(
                height: 15,
                width: 50,
                borderRadius: 5,
              ),
              ShimmerRow(
                height: 15,
                width: 50,
                borderRadius: 5,
              ),
              ShimmerRow(
                height: 15,
                width: 50,
                borderRadius: 5,
              ),
            ],
          )));
    }
    return shimList;
  }

  lastRow() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            ShimmerRow(
              height: 30,
              width: 70,
              borderRadius: 5,
            ),
            ShimmerRow(
              height: 30,
              width: 70,
              borderRadius: 5,
            ),
            ShimmerRow(
              height: 30,
              width: 70,
              borderRadius: 5,
            ),
          ],
        ));
  }

  secondRow() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              ShimmerRow(
                height: 16,
                width: 50,
                borderRadius: 5,
              ),
              ShimmerRow(
                height: 16,
                width: 50,
                borderRadius: 5,
              ),
              ShimmerRow(
                height: 16,
                width: 50,
                borderRadius: 5,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              ShimmerRow(
                height: 16,
                width: 80,
              ),
              ShimmerRow(
                height: 16,
                width: 60,
              ),
              ShimmerRow(
                height: 16,
                width: 120,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              ShimmerRow(
                height: 16,
                width: 40,
                borderRadius: 5,
              ),
              ShimmerRow(
                height: 16,
                width: 40,
                borderRadius: 5,
              ),
              ShimmerRow(
                height: 16,
                width: 40,
                borderRadius: 5,
              ),
            ],
          ),
        ]);
  }
}

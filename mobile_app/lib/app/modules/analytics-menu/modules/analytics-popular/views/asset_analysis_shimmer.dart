import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class AnalyticsShimmer extends StatelessWidget {
  final bool? tableDataLoading;
  const AnalyticsShimmer({Key? key, this.tableDataLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            tableShimmerRowItem(),
            tableShimmerRowItem(),
            tableShimmerRowItem(),
            tableShimmerRowItem(),
            tableShimmerRowItem(),
          ],
        ));
  }

  Widget firstRow() {
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

  Widget fullPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 10),
        firstRow(),
        const SizedBox(
          height: 20,
        ),
        // Container(child: secondRow(), height: 75),
        const SizedBox(
          height: 20,
        ),
        lastRow(),
        const SizedBox(
          height: 20,
        ),
        ...getTableShimmers()
      ],
    );
  }

  List<Widget> getTableShimmers() {
    final List<Widget> shimList = [];
    for (int i = 0; i < 5; i++) {
      shimList.add(Container(
          padding: const EdgeInsets.only(top: 0, bottom: 5, left: 0, right: 10),
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              ShimmerRow(
                height: 45,
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
                width: 40,
                borderRadius: 5,
              ),
              ShimmerRow(
                height: 15,
                width: 40,
                borderRadius: 5,
              ),
              ShimmerRow(
                height: 15,
                width: 40,
                borderRadius: 5,
              ),
              ShimmerRow(
                height: 15,
                width: 40,
                borderRadius: 5,
              ),
            ],
          )));
    }
    return shimList;
  }

  Widget lastRow() {
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

  Widget secondRow() {
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

  Widget tableShimmerRowItem() {
    return Container(
        padding: const EdgeInsets.only(top: 0, bottom: 5, left: 10, right: 10),
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            ShimmerRow(
              height: 45,
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
              width: 40,
              borderRadius: 5,
            ),
            ShimmerRow(
              height: 15,
              width: 40,
              borderRadius: 5,
            ),
            ShimmerRow(
              height: 15,
              width: 40,
              borderRadius: 5,
            ),
            ShimmerRow(
              height: 15,
              width: 40,
              borderRadius: 5,
            ),
          ],
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:iris_common/iris_common.dart';

class DiagonalLine extends StatelessWidget {
  const DiagonalLine({Key? key, required this.direction}) : super(key: key);
  final String direction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(16, 16),
        painter: MyPainter(direction: direction),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter({required this.direction});

  final String direction;

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = direction == 'left' ? const Offset(0, 0) : const Offset(12, 0);
    final p2 = direction == 'left' ? const Offset(12, 12) : const Offset(0, 12);

    final paint = Paint()
      ..color = IrisColor.irisGrey
      ..strokeWidth = 2;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

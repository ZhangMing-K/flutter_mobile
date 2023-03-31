// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iris_mobile/app/shared/utils/color/color_util.dart';
// import 'package:wave/config.dart';
// import 'package:wave/wave.dart';

// ///Bottom animation used in onboarding and login with phone screen
// class IrisWaveAnimation extends StatelessWidget {
//   //reduce height
//   final bool reduce;

//   const IrisWaveAnimation({Key? key, this.reduce = false}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: AnimatedContainer(
//         height: reduce ? 35 : 150,
//         duration: Duration(milliseconds: 500),
//         child: WaveWidget(
//           config: CustomConfig(
//             // gradients: [
//             //   [Colors.red, Color(0xEEF44336)],
//             //   [Colors.red[800], Color(0x77E57373)],
//             //   [Colors.orange, Color(0x66FF9800)],
//             //   [Colors.yellow, Color(0x55FFEB3B)]
//             // ],
//             durations: [
//               10000,
//               7500,
//               // 10800,
//               // 6000,
//             ],
//             heightPercentages: [
//               0.40,
//               0.20,
//               // 0.25,
//               // 0.30,
//             ],
//             blur: MaskFilter.blur(BlurStyle.solid, 10),
//             // gradientBegin: Alignment.bottomLeft,
//             // gradientEnd: Alignment.topRight,
//             colors: [
//               context.theme.primaryColor,
//               lightenColor(context.theme.primaryColor)
//               // Color(0x9921ce9a),
//             ],
//           ),
//           waveAmplitude: 10,
//           size: Size(
//             double.infinity,
//             double.infinity,
//           ),
//         ),
//       ),
//     );
//   }
// }

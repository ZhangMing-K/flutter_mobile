// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iris_common/iris_common.dart';

// import '../controllers/who_to_follow_controller.dart';
// import 'explorer_header.dart';

// class IrisTopPerformerCard extends GetView<WhoToFollowController> {
//   final User user;
//   final double weekPercent;
//   final double width;
//   final double height;
//   final double percentHeight;
//   final Color backgroundColor;
//   const IrisTopPerformerCard(
//       {Key? key,
//       required this.user,
//       required this.weekPercent,
//       required this.width,
//       required this.backgroundColor,
//       required this.height,
//       required this.percentHeight})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         GestureDetector(
//           onTap: () {
//             user.routeToProfile();
//             controller.saveUserToRecent(user);
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 0),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: kBorderRadius,
//                 color: context.theme.backgroundColor,
//                 image: DecorationImage(
//                   image: CachedNetworkImageProvider(user.profilePictureUrl!,
//                       cacheManager: Get.find<IrisImageCacheManager>()),
//                   fit: BoxFit.cover,
//                 ),
//                 gradient: const LinearGradient(colors: [
//                   Colors.black,
//                   Colors.transparent,
//                 ]),
//               ),
//               height: height,
//               width: width - 10,
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: const BoxDecoration(
//                   borderRadius: kBorderRadius,
//                   gradient: LinearGradient(
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                     colors: [
//                       // Colors.black,
//                       Colors.black54,
//                       Colors.transparent,
//                     ],
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       user.fullName,
//                       style: const TextStyle(
//                         fontSize: 15,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 15),
//         Container(
//           width: width,
//           height: percentHeight,
//           decoration: BoxDecoration(
//             color: backgroundColor,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const SizedBox(height: 5),
//               DisplayPercent(
//                 percent: weekPercent,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 roundedNumber: 0.01,
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }

// class TopPerformers extends GetView<WhoToFollowController> {
//   const TopPerformers({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const ExplorerHeader(
//           text: 'Weekly top performers',
//         ),
//         Obx(() => Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: controller.topPerformersList.map((element) {
//                 final index = controller.topPerformersList.indexOf(element);
//                 return IrisTopPerformerCard(
//                     user: element.portfolio!.user!,
//                     weekPercent: element.snapshot!.weekPercent!,
//                     width: double.parse(controller.topPerfomersParam[index]
//                             ['width']!
//                         .toString()),
//                     backgroundColor:
//                         index == 0 ? Colors.grey[800]! : Colors.grey[900]!,
//                     height: double.parse(controller.topPerfomersParam[index]
//                             ['height']!
//                         .toString()),
//                     percentHeight: double.parse(controller
//                         .topPerfomersParam[index]['percentHeight']!
//                         .toString()));
//               }).toList(),
//             )),
//       ],
//     );
//   }
// }

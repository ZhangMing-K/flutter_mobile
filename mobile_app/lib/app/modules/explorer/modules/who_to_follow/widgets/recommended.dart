// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iris_common/iris_common.dart';
// import 'package:iris_common/shared/widgets/iris_buttons.dart';

// import '../controllers/who_to_follow_controller.dart';

// class Recommended extends GetView<WhoToFollowController> {
//   const Recommended({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final reference = context.width;
//     return Obx(
//       () => Visibility(
//         visible: controller.recommendedList.isNotEmpty,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//                 padding: const EdgeInsets.only(left: 16, top: 30, bottom: 10),
//                 child: const Text(
//                   'Featured Users',
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )),
//             SizedBox(
//               height: reference / 1.55,
//               child: ListView.builder(
//                 primary: false,
//                 addAutomaticKeepAlives: false,
//                 itemCount: controller.recommendedList.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   final user = controller.recommendedList[index];
//                   return RecommendedCard(
//                     user: user,
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RecommendedCard extends GetView<WhoToFollowController> {
//   final User user;
//   const RecommendedCard({
//     Key? key,
//     required this.user,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         user.routeToProfile();
//         controller.saveUserToRecent(user);
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 18),
//         child: Row(
//           children: [
//             AspectRatio(
//               aspectRatio: 3 / 4.3,
//               child: ClipRRect(
//                 borderRadius: kBorderRadius,
//                 child: CachedNetworkImage(
//                     imageUrl: user.profilePictureUrl ?? '',
//                     fit: BoxFit.cover,
//                     cacheManager: Get.find<IrisImageCacheManager>()),
//               ),
//             ),
//             AspectRatio(
//               aspectRatio: 3 / 4.3,
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     top: 2.0, bottom: 2.0, left: 6.0, right: 0.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: UserName(
//                           user: user,
//                           fontSize: 20,
//                         )),
//                     Text(
//                       user.getShortenedDescription(200),
//                       maxLines: 8,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: context.theme.colorScheme.secondary
//                             .withOpacity(0.7),
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(),
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                             child: IrisFollowButton(
//                           user$: Rx(user),
//                           followingAction: FOLLOWING_ACTION.VIEW_PROFILE,
//                           customAction: () {
//                             controller.saveUserToRecent(user);
//                           },
//                         )),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

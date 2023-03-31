// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iris_common/iris_common.dart';
// import 'package:iris_common/shared/widgets/iris_buttons.dart';
// import '../controllers/who_to_follow_controller.dart';
// import 'explorer_header.dart';

// class IrisPopularCard extends GetView<WhoToFollowController> {
//   final User user;
//   const IrisPopularCard({Key? key, required this.user}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         user.routeToProfile();
//         controller.saveUserToRecent(user);
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 6),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: kBorderRadius,
//             color: context.theme.backgroundColor,
//             image: DecorationImage(
//               image: CachedNetworkImageProvider(user.profilePictureUrl!,
//                   cacheManager: Get.find<IrisImageCacheManager>()),
//               fit: BoxFit.cover,
//             ),
//             gradient: const LinearGradient(colors: [
//               Colors.black,
//               Colors.transparent,
//             ]),
//           ),
//           height: 168,
//           width: 192,
//           child: Container(
//             padding: const EdgeInsets.all(10),
//             decoration: const BoxDecoration(
//               borderRadius: kBorderRadius,
//               gradient: LinearGradient(
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 colors: [
//                   Colors.black,
//                   Colors.black54,
//                   Colors.transparent,
//                 ],
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 4,
//                 ),
//                 Text(
//                   user.displayName,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 3,
//                 ),
//                 Text(
//                   '${user.followStats?.numberOfFollowers.compactNumber()} followers',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 6,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                         child: IrisFollowButton(
//                       user$: user.obs,
//                       followingAction: FOLLOWING_ACTION.VIEW_PROFILE,
//                       customAction: () {
//                         controller.saveUserToRecent(user);
//                       },
//                     )),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PopularOnIris extends GetView<WhoToFollowController> {
//   const PopularOnIris({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 330,
//       child: Column(
//         children: [
//           const ExplorerHeader(text: 'Popular on Iris'),
//           Expanded(
//             child: Obx(() {
//               return ListView.builder(
//                 shrinkWrap: true,
//                 addAutomaticKeepAlives: false,
//                 primary: false,
//                 itemCount: controller.popularOnIrisList.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   return IrisPopularCard(
//                     user: controller.popularOnIrisList[index],
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

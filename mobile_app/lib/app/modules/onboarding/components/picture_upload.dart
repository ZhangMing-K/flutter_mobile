// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:iris_mobile/app/shared/uuid/uuid.dart';

// import '../../../../screens/edit_profile/edit_profile_controller.dart';
// import '../../../../widgets_v2/profile_image/profile_image.dart';
// import '../../../shared/themes/colors.dart';
// import '../controllers/onboarding_controller.dart';

// class PictureUpload extends StatelessWidget {
//   final EditProfileV2Controller controller = EditProfileV2Controller();

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       width: 200,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Obx(
//             () => ProfileImage(
//               onTap: () async => await controller.uploadFile(),
//               url: controller.authUserStore.loggedUser?.profilePictureUrl,
//               radius: 100,
//               uuid: uuid.v4(),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(
//               16.0,
//             ),
//             child: Align(
//               alignment: Alignment.bottomRight,
//               child: FloatingActionButton(
//                 backgroundColor: IrisColor.primaryColor,
//                 onPressed: () {
//                   controller.uploadFile();
//                 },
//                 child: Icon(
//                   Icons.add,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

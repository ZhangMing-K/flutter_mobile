// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:iris_common/iris_common.dart';
// import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/text_card.dart';
// import 'package:unicons/unicons.dart';

// import '../controllers/orders_controller.dart';

// class OrdersView extends GetView<OrdersController> {
//   const OrdersView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return controller.obx(
//       (state) {
//         return PrimaryScrollController(
//           controller: controller.scrollController,
//           child: Stack(
//             alignment: Alignment.topCenter,
//             children: [
//               IrisListView(
//                 header: const SelectorBar(),
//                 key: controller.listviewController,
//                 onRefresh: controller.pullRefresh,
//                 itemCount: state!.length,
//                 widgetLoader: const ShimmerScroll(),
//                 loadMore: controller.loadMore,
//                 builder: (BuildContext context, int index) {
//                   return TextCard(
//                     text: state[index],
//                     margin: const EdgeInsets.only(top: 8),
//                   );
//                 },
//               ),
//               // Obx(() => OverlayButton(
//               //       onTap: controller.showNewPosts,
//               //       isVisible: controller.isOverlayButtonVisible,
//               //       avatars: controller.avatars,
//               //     )),
//             ],
//           ),
//         );
//       },
//       onLoading: const ShimmerScroll(),
//     );
//   }
// }

// class SelectorBar extends GetView<OrdersController> {
//   const SelectorBar({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 10.0),
//       child: Column(
//         children: [
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               header(context),
//               StatefulBuilder(builder: (_, update) {
//                 return IrisBounceButton(
//                   duration: const Duration(milliseconds: 100),
//                   onPressed: () {
//                     HapticFeedback.lightImpact();
//                     controller.toggleSaved();
//                     update(() {});
//                   },
//                   child: Builder(builder: (context) {
//                     if (controller.saved) {
//                       return SvgPicture.asset(
//                         IconPath.bookmark_solid,
//                         color: IrisColor.primaryColor,
//                         height: 24,
//                       );
//                     }

//                     return Icon(
//                       UniconsLine.bookmark,
//                       color: context.theme.colorScheme.secondary,
//                     );
//                   }),
//                 );
//               }),
//             ],
//           ),
//           const IrisChipChoice(),
//         ],
//       ),
//     );
//   }

//   header(BuildContext context) {
//     return Row(
//       children: [
//         ...List.generate(controller.feedSelection.length, (index) {
//           return Row(
//             children: [
//               const SizedBox(
//                 width: 10,
//               ),
//               ChoiceChip(
//                   label: Text(controller
//                       .feedSelectionToString(controller.feedSelection[index])),
//                   selected: controller.getCurrentCategoryIndex() == index,
//                   selectedColor: context.theme.primaryColor,
//                   labelStyle: const TextStyle(color: Colors.white),
//                   onSelected: (bool selected) {
//                     HapticFeedback.lightImpact();
//                     controller.changeCategory(controller.feedSelectionToString(
//                         controller.feedSelection[index]));
//                   }),
//             ],
//           );
//         }),
//       ],
//     );
//   }
// }

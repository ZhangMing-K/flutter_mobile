// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:unicons/unicons.dart';

// import '../../../iris_common.dart';

// class AssetWatchlistItem extends StatelessWidget {
//   final Asset asset;
//   final bool isRow;
//   final Function? onRemove;
//   final Function onTapTrailing;
//   final RxBool showPercentage;
//   const AssetWatchlistItem({
//     Key? key,
//     required this.asset,
//     this.isRow = false,
//     // this.showDivider = true,
//     this.onRemove,
//     required this.onTapTrailing,
//     required this.showPercentage,
//   }) : super(key: key);

//   Widget assetName() {
//     return Builder(builder: (context) {
//       return GestureDetector(
//         onTap: () {
//           Get.toNamed(
//             Paths.Asset,
//             parameters: {'assetKey': asset.assetKey!.toString()},
//           );
//         },
//         child: Row(children: [
//           AppAssetImage(
//             asset: asset,
//             height: 45,
//             shouldResize: false,
//             shouldAnimate: false,
//           ),
//           const SizedBox(width: 8),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text(asset.symbol!,
//                       style: const TextStyle(
//                           fontSize: 17, fontWeight: FontWeight.w700)),
//                 ],
//               ),
//               SizedBox(
//                 width: 160,
//                 child: Text(asset.name ?? '',
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                         color: context.theme.colorScheme.secondary
//                             .withOpacity(0.6),
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500)),
//               )
//             ],
//           )
//         ]),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: isRow ? mainRow(context) : mainColumn(context),
//       onTap: () {
//         Get.toNamed(
//           Paths.Asset,
//           parameters: {'assetKey': asset.assetKey!.toString()},
//         );
//       },
//     );
//   }

//   Widget featured() {
//     return Row(
//       children: const [
//         Icon(
//           Icons.star,
//           size: 15,
//           color: IrisColor.primaryColor,
//         ),
//         SizedBox(
//           width: 3,
//         ),
//       ],
//     );
//   }

//   Widget mainColumn(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         assetName(),
//         trailing(),
//       ],
//     );
//   }

//   Widget mainRow(BuildContext context) {
//     if (asset.authUserIsWatching == null ||
//         !asset.authUserIsWatching! ||
//         onRemove == null) {
//       return rowWidget(context);
//     }

//     return Slidable(
//       endActionPane: ActionPane(
//         motion: const ScrollMotion(),
//         extentRatio: 0.25,
//         children: [
//           SlidableAction(
//             backgroundColor: Colors.red,
//             icon: UniconsLine.minus_circle,
//             // color: Colors.white,

//             onPressed: (_) {
//               onRemove!(asset);
//             },
//           ),
//         ],
//       ),
//       child: rowWidget(context),
//     );
//   }

//   Widget rowWidget(BuildContext context) {
//     return Container(
//         color: context.theme.scaffoldBackgroundColor,
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 assetName(),
//                 const SizedBox(width: 20),
//                 // totalChart(context),
//                 // SizedBox(width: 20),
//                 trailing(),
//               ],
//             ),
//           ],
//         ));
//   }

//   Widget shimmerChart() {
//     return const SizedBox(
//         height: 250,
//         child: Center(
//           child: ShimmerCircleLoader(),
//         ));
//   }

//   Widget trailing() {
//     return Builder(builder: (context) {
//       if (asset.quote == null) {
//         return Container();
//       }

//       final String? changeToShow = showPercentage.value == true
//           ? asset.quote!.changePercentDifferential
//           : asset.quote!.changeDifferential;
//       num? changeToEvaluate = showPercentage.value == true
//           ? asset.quote!.changePercent
//           : asset.quote!.change;
//       changeToEvaluate = changeToEvaluate ?? 0;
//       final double latestprice = asset.quote!.latestPrice ?? 0;
//       final double currentPrice = asset.currentPrice ?? 0;
//       final double price =
//           (asset.quote!.latestPrice != null) ? latestprice : currentPrice;
//       final Color priceChangeColor = changeToEvaluate >= 0
//           ? IrisColor.positiveChange
//           : IrisColor.lighterNegativeChange;

//       return Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Column(
//             crossAxisAlignment:
//                 !isRow ? CrossAxisAlignment.start : CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 price.formatCurrency(),
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//                 textAlign: isRow ? TextAlign.right : TextAlign.left,
//               ),
//               const SizedBox(height: 4),
//               GestureDetector(
//                 onTap: () {
//                   HapticFeedback.mediumImpact();
//                   onTapTrailing();
//                 },
//                 child: Container(
//                     // decoration: BoxDecoration(
//                     //     color: changeToEvaluate >= 0
//                     //         ? IrisColor.lighterPositiveChange
//                     //         : IrisColor.lighterNegativeChange,
//                     //     borderRadius: BorderRadius.circular(4)),
//                     padding: const EdgeInsets.all(2),
//                     width: 70 * context.textScaleFactor,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                             changeToEvaluate == 0
//                                 ? ''
//                                 : changeToEvaluate > 0
//                                     ? '+'
//                                     : '-',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 color: priceChangeColor,
//                                 fontWeight: FontWeight.w500)),
//                         Text(changeToShow ?? '--',
//                             style: TextStyle(
//                                 color: priceChangeColor,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500)),
//                       ],
//                     )),
//               )
//             ],
//           ),
//         ],
//       );
//     });
//   }
// }

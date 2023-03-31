// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iris_common/iris_common.dart';
// import 'package:iris_mobile/app/modules/feed/modules/assets_stories/controllers/assets_stories_asset_controller.dart';
// import 'package:iris_mobile/app/modules/feed/modules/user_stories/views/daily_percent_gain_view.dart';
// import 'package:unicons/unicons.dart';

// class AssetsStoriesAssetView extends GetView<AssetStoriesAssetController> {
//   const AssetsStoriesAssetView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final scaleFactor = context.textScaleFactor;
//     return controller.obx(
//       (state) {
//         int itemLen = controller.state.length + 1;
//         if (!controller.hasConnectedPortfolio) {
//           itemLen += 1;
//         }
//         return SizedBox(
//             height: 115 * scaleFactor,
//             child: ListView.builder(
//               shrinkWrap: true,
//               primary: false,
//               addAutomaticKeepAlives: false,
//               itemCount: itemLen,
//               scrollDirection: Axis.horizontal,
//               controller: controller.scrollController,
//               itemBuilder: (context, index) {
//                 bool isAsset = index > 0;
//                 if (!controller.hasConnectedPortfolio) {
//                   isAsset = isAsset && index < itemLen - 1;
//                 }
//                 final Asset asset =
//                     isAsset ? state![index - 1].value : const Asset();
//                 return Row(
//                   children: [
//                     const SizedBox(
//                       width: 12,
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         if (isAsset)
//                           SizedBox(
//                               height: 70 * scaleFactor,
//                               child: Padding(
//                                   padding: EdgeInsets.all(2 * scaleFactor),
//                                   child: AppAssetImage(
//                                     asset: asset,
//                                     height: 60,
//                                     onTap: () {
//                                       controller.goToAssetStory(
//                                           index - 1, asset.assetKey!);
//                                     },
//                                   )))
//                         else if (index == 0)
//                           GestureDetector(
//                             onTap: controller.toWatchList,
//                             child: SizedBox(
//                                 height: 70 * scaleFactor,
//                                 width: 70 * scaleFactor,
//                                 child: Center(
//                                     child: Container(
//                                   height: 66 * scaleFactor,
//                                   width: 66 * scaleFactor,
//                                   decoration: BoxDecoration(
//                                       color: context.theme.backgroundColor,
//                                       borderRadius:
//                                           BorderRadius.circular(10.0)),
//                                   child: Icon(
//                                     UniconsLine.list_ul,
//                                     size: 40 * scaleFactor,
//                                     color: context.theme.colorScheme.secondary
//                                         .withOpacity(.8),
//                                   ),
//                                 ))),
//                           )
//                         else
//                           Obx(() {
//                             return GestureDetector(
//                               onTap: () {
//                                 if (controller.hasFetchedAuthInfo) {
//                                   Get.toNamed(Paths.InstitutionConnectLanding);
//                                 }
//                               },
//                               child: SizedBox(
//                                   height: 70 * scaleFactor,
//                                   width: 70 * scaleFactor,
//                                   child: Center(
//                                       child: controller.hasFetchedAuthInfo
//                                           ? Container(
//                                               height: 66 * scaleFactor,
//                                               width: 66 * scaleFactor,
//                                               decoration: BoxDecoration(
//                                                   color: IrisColor.primaryColor,
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           10.0)),
//                                               child: Icon(
//                                                 UniconsLine.plus,
//                                                 size: 40 * scaleFactor,
//                                                 color: Colors.white,
//                                               ),
//                                             )
//                                           : const CupertinoActivityIndicator(
//                                               radius: 20))),
//                             );
//                           }),
//                         SizedBox(
//                             height: 20 * scaleFactor,
//                             child: isAsset
//                                 ? GestureDetector(
//                                     onTap: () {
//                                       asset.routeToFromAssetImage(false, null);
//                                     },
//                                     child: RichText(
//                                       textScaleFactor: scaleFactor,
//                                       text: TextSpan(
//                                         children: <InlineSpan>[
//                                           TextSpan(
//                                             text: asset.symbol!,
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.normal,
//                                                 fontSize:
//                                                     IrisScreenUtil.dFontSize(
//                                                         12),
//                                                 color: context.theme.colorScheme
//                                                     .secondary),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 : index == 0
//                                     ? GestureDetector(
//                                         child: SizedBox(
//                                           height: 20 * scaleFactor,
//                                           child: RichText(
//                                             textScaleFactor: scaleFactor,
//                                             text: TextSpan(
//                                               children: <InlineSpan>[
//                                                 TextSpan(
//                                                   text: 'View',
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.normal,
//                                                       fontSize: IrisScreenUtil
//                                                           .dFontSize(12),
//                                                       color: context
//                                                           .theme
//                                                           .colorScheme
//                                                           .secondary),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         onTap: controller.toWatchList,
//                                       )
//                                     : Obx(() {
//                                         return controller.hasFetchedAuthInfo
//                                             ? GestureDetector(
//                                                 child: RichText(
//                                                   textScaleFactor: scaleFactor,
//                                                   text: TextSpan(
//                                                     children: <InlineSpan>[
//                                                       TextSpan(
//                                                         text: 'Connect',
//                                                         style: TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .normal,
//                                                             fontSize:
//                                                                 IrisScreenUtil
//                                                                     .dFontSize(
//                                                                         12),
//                                                             color: context
//                                                                 .theme
//                                                                 .colorScheme
//                                                                 .secondary),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 onTap: () {
//                                                   Get.toNamed(Paths
//                                                       .InstitutionConnectLanding);
//                                                 },
//                                               )
//                                             : Container();
//                                       })),
//                         if (isAsset)
//                           GestureDetector(
//                               onTap: () {
//                                 asset.routeToFromAssetImage(false, null);
//                               },
//                               child: DailyPercentGainView(
//                                   percentGain: asset.quote!.changePercent))
//                         else if (index == 0)
//                           GestureDetector(
//                             onTap: controller.toWatchList,
//                             child: RichText(
//                               textScaleFactor: scaleFactor,
//                               text: TextSpan(
//                                 children: <InlineSpan>[
//                                   TextSpan(
//                                     text: 'Watchlist',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.normal,
//                                         fontSize: IrisScreenUtil.dFontSize(12),
//                                         color: context
//                                             .theme.colorScheme.secondary),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         else
//                           Obx(() {
//                             return controller.hasFetchedAuthInfo
//                                 ? GestureDetector(
//                                     onTap: () {
//                                       Get.toNamed(
//                                           Paths.InstitutionConnectLanding);
//                                     },
//                                     child: RichText(
//                                       textScaleFactor: scaleFactor,
//                                       text: TextSpan(
//                                         children: <InlineSpan>[
//                                           TextSpan(
//                                             text: 'Portfolio',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.normal,
//                                                 fontSize:
//                                                     IrisScreenUtil.dFontSize(
//                                                         12),
//                                                 color: context.theme.colorScheme
//                                                     .secondary),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 : Container();
//                           })
//                       ],
//                     ),
//                     SizedBox(
//                       width: 3 * scaleFactor,
//                     ),
//                   ],
//                 );
//               },
//             ));
//       },
//       onEmpty: Container(),
//       onLoading: const ShimmerScroll(),
//     );
//   }
// }

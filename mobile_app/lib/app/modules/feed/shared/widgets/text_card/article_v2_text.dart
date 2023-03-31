// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:get/get.dart';
// import 'package:html/parser.dart' as htmlparser;
// import 'package:iris_common/iris_common.dart';
// import 'package:iris_common/shared/widgets/preloading_image_builder.dart';

// import 'text_card.dart';

// class ArticleV2Text extends StatelessWidget {
//   ArticleV2Text({
//     Key? key,
//     this.text,
//     required this.onDoubleTap,
//     this.textCardDisplayType = TEXT_CARD_DISPLAY_TYPE.SUMMARY,
//   }) : super(key: key);
//   final TextModel? text;

//   final TEXT_CARD_DISPLAY_TYPE textCardDisplayType;

//   final double pictureWidth = Get.width * .30;
//   final Function() onDoubleTap;

//   void route() {
//     Get.toNamed(Paths.Text.createPath([text!.textKey]), arguments: text.obs);
//   }

//   picture() {
//     return InkWell(
//       onTap: route,
//       child: Container(
//           height: pictureWidth,
//           width: pictureWidth,
//           // padding: EdgeInsets.only(top:10),
//           margin: const EdgeInsets.only(top: 12, bottom: 12),
//           child: AspectRatio(
//             aspectRatio: 1,
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                   image: DecorationImage(
//                     onError: (err, stack) {},
//                     fit: BoxFit.cover,
//                     alignment: FractionalOffset.topCenter,
//                     image: CachedNetworkImageProvider(
//                         text!.article!.thumbnailImageUrl!,
//                         cacheManager: Get.find<IrisImageCacheManager>()),
//                   )),
//             ),
//           )),
//     );
//   }

//   Widget headline(BuildContext context) {
//     String headline = text!.article!.headline!;
//     if (headline.length < 20) {
//       headline = text!.article!.summary!;
//     }
//     if (headline.length < 20) {
//       headline = text!.article!.body!;
//     }
//     if (headline.length > 300) {
//       headline = headline.substring(0, 300);
//       headline += '...   See More';
//     }

//     final document = htmlparser.parse(headline);
//     return Flexible(
//       child: Row(
//         children: [
//           Flexible(
//             child: Html(
//               data: document.outerHtml,
//               style: {
//                 'body': Style(
//                     fontSize: const FontSize(20),
//                     color: Colors.white,
//                     margin: const EdgeInsets.all(0))
//               },
//             ),
//           ),
//           // trailing()
//         ],
//       ),
//     );
//   }

//   Widget trailing() {
//     return Icon(
//       Icons.chevron_right,
//       color: (Get.context!.isDarkMode)
//           ? Colors.grey.shade800
//           : Colors.grey.shade300,
//       size: 25,
//     );
//   }

//   Widget image(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: text!.article!.thumbnailImageUrl!,
//       cacheManager: Get.find<IrisImageCacheManager>(),
//     );
//   }

//   Widget summaryView(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Flexible(
//           child: headline(context),
//         ),
//         picture(),
//         trailing()
//       ],
//     );
//   }

//   Widget full(BuildContext context) {
//     final document = htmlparser.parse(text!.article!.body);
//     return Column(
//       children: [
//         image(context),
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 10),
//           child: Html(
//             data: document.outerHtml,
//             style: {
//               'body': Style(
//                   fontSize: const FontSize(15),
//                   margin: const EdgeInsets.all(0)),
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   summaryV2View(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 15, top: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Article by ' + text!.article!.author!,
//                       style: const TextStyle(
//                         fontSize: 20,
//                       )),
//                   Text(
//                     text!.dateFromAbb,
//                     style: const TextStyle(
//                         fontSize: 12, color: IrisColor.dateFromColor),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   )
//                 ],
//               )
//             ],
//           ),
//           headline(context),
//           const SizedBox(
//             height: 15,
//           ),
//           assets()
//         ],
//       ),
//     );
//   }

//   assets() {
//     if (text!.taggedAssets == null || text!.taggedAssets!.isEmpty) {
//       return Container();
//     }
//     final List<Widget> l = [];
//     for (var asset in text!.taggedAssets!) {
//       if (asset.pictureUrl != null && l.length < 12) {
//         l.add(AppAssetImage(asset: asset));
//         l.add(const SizedBox(
//           width: 10,
//         ));
//       }
//     }
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       child: Row(
//         children: l,
//       ),
//     );
//   }

//   String get source {
//     final source = text!.article?.source ?? '';
//     final dateFrom = text!.article?.dateFrom ?? '';
//     return source + ' - ' + dateFrom;
//   }

//   Widget preloadImage(imageUrl) {
//     return CachedNetworkImage(
//       imageUrl: imageUrl,
//       fit: BoxFit.fill,
//       height: Get.height * 0.38,
//       // width: radius,
//       width: Get.width - 40,
//       imageBuilder: (context, imageProvider) => PreloadingImageBuilder(
//         imageProvider: imageProvider,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return Container(
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: imageProvider,
//                       fit: BoxFit.cover,
//                     ),
//                     borderRadius: kBorderRadius,
//                     shape: BoxShape.rectangle,
//                     gradient: const LinearGradient(colors: [
//                       Colors.black,
//                       Colors.transparent,
//                     ])),
//                 child: Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: const BoxDecoration(
//                     borderRadius: kBorderRadius,
//                     gradient: LinearGradient(
//                       begin: Alignment.bottomCenter,
//                       end: Alignment.topCenter,
//                       colors: [
//                         Colors.black87,
//                         Colors.black54,
//                         Colors.transparent,
//                       ],
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         height: 4,
//                       ),
//                       headline(context),
//                       Container(
//                         margin: const EdgeInsets.symmetric(vertical: 16),
//                         child: Text(
//                           source,
//                           style: const TextStyle(fontSize: 12),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ));
//           } else {
//             return Container();
//           }
//         },
//       ),
//       cacheManager: Get.find<IrisImageCacheManager>(),
//       placeholder: (context, url) => Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.transparent)),
//       errorWidget: (context, url, error) => Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.grey.shade300)),
//     );
//   }

//   Widget normalImage(imageUrl, BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           borderRadius: kBorderRadius,
//           image: DecorationImage(
//             image: CachedNetworkImageProvider(imageUrl,
//                 cacheManager: Get.find<IrisImageCacheManager>()),
//             fit: BoxFit.cover,
//           ),
//           gradient: const LinearGradient(colors: [
//             Colors.black,
//             Colors.transparent,
//           ]),
//         ),
//         height: Get.height * 0.38,
//         // width: 192,
//         child: Container(
//             padding: const EdgeInsets.all(10),
//             decoration: const BoxDecoration(
//               borderRadius: kBorderRadius,
//               gradient: LinearGradient(
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 colors: [
//                   Colors.black87,
//                   Colors.black54,
//                   Colors.transparent,
//                 ],
//               ),
//             ),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   headline(context),
//                   Flexible(
//                     child: Material(
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(vertical: 16),
//                         child: Text(
//                           source,
//                           style: const TextStyle(
//                               fontSize: 12, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   )
//                 ])));
//   }

//   Widget storyView(BuildContext context) {
//     final imageUrl = text!.article!.thumbnailImageUrl!;
//     return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 44),
//         child: normalImage(imageUrl, context));
//   }

//   main(BuildContext context) {
//     if (textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.SUMMARY) {
//       return summaryV2View(context);
//     } else if (textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.FULL) {
//       return full(context);
//     } else if (textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.STORY) {
//       return storyView(context);
//     } else {
//       return summaryView(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       GestureDetector(
//         behavior: HitTestBehavior.deferToChild,
//         onDoubleTap: onDoubleTap,
//         onTap: route,
//         child: main(context),
//       ),
//     ]);
//   }
// }

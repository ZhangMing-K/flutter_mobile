// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:get/get.dart';
// import 'package:html/parser.dart' as htmlparser;
// import 'package:iris_common/iris_common.dart';
// import 'package:iris_common/shared/widgets/preloading_image_builder.dart';

// class SharedTextV2Article extends StatelessWidget {
//   final TextModel? text;
//   const SharedTextV2Article({
//     Key? key,
//     this.text,
//   }) : super(key: key);

//   assets() {
//     if (text!.taggedAssets == null || text!.taggedAssets!.isEmpty) {
//       return Container();
//     }
//     final List<Widget> l = [];
//     for (var asset in text!.taggedAssets!) {
//       if (asset.pictureUrl != null && l.length < 6) {
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

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       GestureDetector(
//           behavior: HitTestBehavior.deferToChild,
//           // onDoubleTap: onDoubleTap,
//           onTap: route,
//           child: storyView(context)),
//     ]);
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
//     return Html(
//       data: document.outerHtml,
//       shrinkWrap: false,
//       style: {
//         'body': Style(
//             fontSize: const FontSize(15),
//             fontWeight: FontWeight.w500,
//             margin: const EdgeInsets.all(0))
//       },
//     );
//   }

//   route() async {
//     Get.toNamed(Paths.Text.createPath([text!.textKey]),
//         arguments: TextScreenArgs(text: text!.obs));
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
//                   // Text('Article by ' + text!.article!.author!,
//                   //     style: TextStyle(
//                   //       fontSize: 20,
//                   //     )),
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
//           Flexible(child: headline(context)),
//           const SizedBox(
//             height: 15,
//           ),
//           assets()
//         ],
//       ),
//     );
//   }

//   Widget summaryView(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Flexible(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Article by ' + text!.article!.author!,
//                       style: const TextStyle(
//                         fontSize: 20,
//                       )),
//                   Text(
//                     text!.dateFromAbb,
//                     style: const TextStyle(fontSize: 12),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   headline(context),
//                 ],
//               ),
//             ),
//             trailing()
//           ],
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         assets()
//       ],
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
//       height: 180,
//       imageBuilder: (context, imageProvider) => PreloadingImageBuilder(
//         imageProvider: imageProvider,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: imageProvider,
//                   fit: BoxFit.cover,
//                 ),
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(10)),
//                 shape: BoxShape.rectangle,
//               ),
//             );
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

//   Widget storyView(BuildContext context) {
//     final imageUrl =
//         text!.article!.thumbnailImageUrl ?? text!.article!.imageUrl!;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         preloadImage(imageUrl),
//         Container(
//           padding: const EdgeInsets.only(left: 12),
//           decoration: BoxDecoration(
//             borderRadius:
//                 const BorderRadius.vertical(bottom: Radius.circular(10)),
//             color: context.theme.backgroundColor,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 12,
//               ),
//               headline(context),
//               Container(
//                 margin: const EdgeInsets.symmetric(vertical: 12),
//                 child: Text(
//                   source,
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color:
//                           context.theme.colorScheme.secondary.withOpacity(0.6)),
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
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
// }

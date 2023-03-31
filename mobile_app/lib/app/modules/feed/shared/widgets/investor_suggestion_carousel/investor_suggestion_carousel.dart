// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iris_common/iris_common.dart';
// import 'package:iris_mobile/app/modules/explorer/modules/who_to_follow/controllers/who_to_follow_controller.dart';
// import 'package:iris_mobile/app/modules/feed/shared/widgets/investor_suggestion_carousel/trader_card.dart';

// class InvestorSuggestionCarousel extends StatelessWidget {
//   const InvestorSuggestionCarousel(
//       {Key? key, required this.suggestionType, this.showTopAssets = false})
//       : super(key: key);
//   final FOLLOW_SUGGESTION_TYPE suggestionType;
//   final bool showTopAssets;

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<WhoToFollowController>(
//       builder: (controller) {
//         List<User> suggestions;
//         switch (suggestionType) {
//           case FOLLOW_SUGGESTION_TYPE.WEEKLY_POPULAR:
//             suggestions = controller.popularOnIrisList;
//             break;
//           case FOLLOW_SUGGESTION_TYPE.POPULAR_WITH_FRIENDS:
//             suggestions = controller.popularWithFriendsList;
//             break;
//           // case FOLLOW_SUGGESTION_TYPE.FEATURED:
//           //   suggestions = controller.popularOnIrisList;
//           //   break;
//           case FOLLOW_SUGGESTION_TYPE.ACTIVE_POPULAR_WITH_PORTFOLIO:
//             suggestions = controller.activePopularWithPortfolio;
//             break;
//           default:
//             suggestions = controller.recommendedList;
//             break;
//         }
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
//               child: SizedBox(
//                   width: double.infinity,
//                   child: Text(
//                     'Popular Investors',
//                     textAlign: TextAlign.left,
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyText2
//                         ?.copyWith(fontWeight: FontWeight.bold),
//                   )),
//             ),
//             SizedBox(
//               height: 270,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: suggestions.length,
//                 itemBuilder: (context, index) => TraderCard(
//                     user: suggestions[index], showTopAssets: showTopAssets),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

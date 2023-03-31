// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:unicons/unicons.dart';
// import 'package:get/get.dart';
// import 'package:iris_mobile/app/modules/inbox/modules/groupchat/components/change_group_info/change_group_info.dart';
// import 'package:iris_mobile/app/modules/inbox/modules/groupchat/components/change_group_info/change_group_info_controller.dart';
// import 'package:iris_mobile/app/shared/uuid/uuid.dart';

// import '../../../shared/models/collection/collection.dart';
// import '../../../shared/models/index.dart';
// import '../../../shared/services/collection_service.dart';
// import 'package:iris_mobile/app/shared/widgets/user_name/user_name.dart';
// import '../../pannels/chat_portfolio_pannel/chat_portfolio_pannel.dart';
// import '../../profile_image/profile_image.dart';
// import '../base_controller.dart';

// class AnimatedScaffold extends StatefulWidget {
//   AnimatedScaffold(
//       {this.child, this.collectionKey, this.endDrawer, this.bottomNavbar});

//   Widget? child;
//   Widget? endDrawer;
//   Widget? bottomNavbar;
//   int? collectionKey;

//   @override
//   createState() => AnimatedScaffoldState();
// }

// class AnimatedScaffoldState extends State<AnimatedScaffold>
//     with SingleTickerProviderStateMixin {
//   AnimatedScaffoldState() {
//     controller =
//         AnimationController(duration: Duration(milliseconds: 200), vsync: this);
//     animation = CurvedAnimation(parent: controller, curve: Curves.linear);
//   }

//   late AnimationController controller;
//   late Animation animation;
//   bool expanded = false;

//   _animateAppBar() {
//     expanded ? controller.reverse() : controller.forward();
//     expanded = !expanded;
//   }

//   Widget build(BuildContext context) {
//     return AnimatedScaffoldBottom(
//         animation: animation as Animation<double>,
//         onPressed: _animateAppBar,
//         child: widget.child,
//         endDrawer: widget.endDrawer,
//         bottomNavbar: widget.bottomNavbar,
//         collectionKey: widget.collectionKey);
//   }
// }

// class AnimatedScaffoldBottom extends AnimatedWidget {
//   AnimatedScaffoldBottom(
//       {Key? key,
//       required Animation<double> animation,
//       this.onPressed,
//       this.child,
//       this.endDrawer,
//       this.bottomNavbar,
//       this.collectionKey})
//       : super(key: key, listenable: animation);

//   final VoidCallback? onPressed;
//   static final _sizeTween = Tween<double>(begin: 0.0, end: 56.0);
//   Widget? child;
//   Widget? endDrawer;
//   Widget? bottomNavbar;
//   int? collectionKey;
//   bool get expanded =>
//       _sizeTween.evaluate(listenable as Animation<double>) > 20;

//   CollectionService collectionService = CollectionService();
//   BaseController baseController = Get.find();

//   Future<Collection?> getCollection() async {
//     final Collection? collectionInfo = await collectionService
//         .getCollectionUsers(collectionKeys: [collectionKey]);
//     return collectionInfo;
//   }

//   titlePrimaryUser(User user) {
//     return Center(
//         child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ProfileImage(
//           url: user.profilePictureUrl,
//           radius: 20,
//           uuid: user.userKey.toString(),
//         ),
//         InkWell(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               UserName(
//                   user: user, fontSize: 15, route: false, color: Colors.white),
//               Builder(builder: (context) {
//                 return IconButton(
//                   color: context.theme.colorScheme.secondary,
//                   padding: EdgeInsets.all(0),
//                   constraints: BoxConstraints(
//                     minWidth: 20,
//                     minHeight: 10,
//                   ),
//                   icon: Icon(expanded ? Icons.expand_less : Icons.expand_more,
//                       color: Colors.white),
//                   onPressed: onPressed,
//                 );
//               })
//             ],
//           ),
//           onTap: () {
//             onPressed?.call();
//           },
//         )
//       ],
//     ));
//   }

//   titleGroupUsers(String displayName, List<User>? users, String? groupPicUrl,
//       BuildContext context) {
//     final overlapLeft = -15.0;
//     final List<Widget> groupAvatars = [];
//     var i = 0;
//     if (groupPicUrl != null) {
//       groupAvatars.add(ProfileImage(
//         radius: 20,
//         url: groupPicUrl,
//         uuid: uuid.v4(),
//       ));
//     } else {
//       users!.forEach((user) {
//         groupAvatars.add(Container(
//           transform: Matrix4.translationValues(overlapLeft * i, 0.0, 0.0),
//           child: ProfileImage(
//             url: user.profilePictureUrl,
//             radius: 20,
//             uuid: uuid.v4(),
//           ),
//         ));
//         i = i + 1;
//       });
//     }
//     return Center(
//         child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [...groupAvatars],
//         ),
//         Container(
//           child: InkWell(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Flexible(
//                     child: Text(displayName,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                             fontWeight: FontWeight.normal,
//                             fontSize: 15,
//                             // color: context.theme.indicatorColor,
//                             color: Colors.white)),
//                   ),
//                   IconButton(
//                     color: context.theme.colorScheme.secondary,
//                     padding: EdgeInsets.all(0),
//                     constraints: BoxConstraints(
//                       minWidth: 0,
//                       minHeight: 10,
//                     ),
//                     icon: Icon(expanded ? Icons.expand_less : Icons.expand_more,
//                         color: Colors.white),
//                     onPressed: onPressed,
//                   )
//                 ],
//               ),
//               onTap: () {
//                 onPressed?.call();
//               }),
//           width: 300,
//         ),
//       ],
//     ));
//   }

//   title(BuildContext context, Collection collection) {
//     final collectionType = collection.collectionType;
//     final name = collection.name;
//     final currentUsers = collection.currentUsers;
//     final displayName = collectionType == COLLECTION_TYPE.PRIVATE_MESSAGE
//         ? currentUsers![0].fullName
//         : name;
//     if (collectionType == COLLECTION_TYPE.PRIVATE_MESSAGE) {
//       final user = currentUsers![0];
//       return titlePrimaryUser(user);
//     } else {
//       final groupPicUrl = collection.pictureUrl;
//       List<User>? groupUsers;
//       if (currentUsers!.length > 3) {
//         groupUsers = currentUsers.getRange(0, 3).toList();
//       } else {
//         groupUsers = currentUsers;
//       }
//       return titleGroupUsers(displayName!, groupUsers, groupPicUrl, context);
//     }
//   }

//   Widget bottomContainer(Collection? collection) {
//     return Builder(builder: (context) {
//       return Center(
//           child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           InkWell(
//             child: SingleChildScrollView(
//                 child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(UniconsLine.info, color: Colors.white),
//                 Text('info', style: TextStyle(color: Colors.white))
//               ],
//             )),
//             onTap: () {
//               if (collection!.collectionType == COLLECTION_TYPE.GROUP_MESSAGE) {
//                 final BaseController baseController = Get.find();
//                 final GroupChangeInfoController controller =
//                     GroupChangeInfoController(collection: collection);
//                 baseController.openPanel(
//                     child: ChangeGroupInfo(controller: controller),
//                     context: context);
//               }
//             },
//           ),
//           SizedBox(width: 15),
//           InkWell(
//             child: SingleChildScrollView(
//                 child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.trending_up, color: Colors.white),
//                 Text('Portfolios', style: TextStyle(color: Colors.white))
//               ],
//             )),
//             onTap: () {
//               ChatPortfolioPannel.openPannel(
//                   collectionKey: collection!.collectionKey);
//             },
//           )
//         ],
//       ));
//     });
//   }

//   @override
//   build(BuildContext context) {
//     return FutureBuilder<Collection?>(
//         future: getCollection(),
//         builder: (context, AsyncSnapshot<Collection?> snapshot) {
//           Widget? headerTitle;
//           Collection? collection;
//           if (snapshot.hasData) {
//             collection = snapshot.data;
//             headerTitle = title(context, collection!);
//           }
//           return Scaffold(
//             body: Builder(builder: (context) {
//               // baseController.initContext(context: context);
//               return child!;
//             }),
//             bottomNavigationBar: bottomNavbar,
//             appBar: AppBar(
//               title: Container(
//                 child: headerTitle,
//                 transform: Matrix4.translationValues(
//                     -28.0, 0.0, 0.0), // leading width is 56 by default
//               ),
//               titleSpacing: 0.0,
//               automaticallyImplyLeading: true,
//               elevation: 0, //this is shadow below app bar 0 gets rid of it
//               backgroundColor: context.theme.appBarTheme.color,
//               iconTheme: context.theme.appBarTheme.iconTheme,
//               toolbarHeight: 75 +
//                   _sizeTween.evaluate(
//                       listenable as Animation<double>), // 75 is app bar height
//               bottom: PreferredSize(
//                 preferredSize: Size.fromHeight(
//                     _sizeTween.evaluate(listenable as Animation<double>)),
//                 child: Container(
//                   height: _sizeTween.evaluate(listenable as Animation<double>),
//                   child: bottomContainer(collection),
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }

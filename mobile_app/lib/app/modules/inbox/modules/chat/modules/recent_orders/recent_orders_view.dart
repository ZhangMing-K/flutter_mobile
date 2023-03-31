import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/SharedMessageText/index.dart';
import 'package:unicons/unicons.dart';

import '../../../../../feed/modules/orders/views/no_orders_view.dart';
import 'recent_orders_controller.dart';

class RecentOrdersView extends StatelessWidget {
  final RecentOrdersController controller;
  final ScrollController? scrollController;
  const RecentOrdersView(
      {Key? key, required this.controller, this.scrollController})
      : super(key: key);

  assetsList(BuildContext context) {
    return Obx(() {
      final listAssets = controller.currentAssets$.toList();
      return Container(
          color: context.theme.hoverColor,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          height: 112,
          child: ListView.builder(
              addAutomaticKeepAlives: false,
              scrollDirection: Axis.horizontal,
              itemCount: listAssets.length,
              itemBuilder: (context, index) {
                final CommonAssets asset = listAssets[index]!;
                return Stack(
                  children: <Widget>[
                    Container(
                        width: ScreenUtil().setWidth(50),
                        margin: const EdgeInsets.all(6.0),
                        child: InkWell(
                          child: Column(
                            children: [
                              AppAssetImage(
                                asset: asset.asset,
                                onTap: () {
                                  controller.onClickAsset(asset);
                                },
                              ),
                              Text(asset.asset!.symbol!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          onTap: () {
                            controller.onClickAsset(asset);
                          },
                        )),
                    Obx(() => controller.isSelectedAsset(asset)
                        ? Positioned(
                            right: 3.0,
                            top: 3.0,
                            child: GestureDetector(
                              onTap: () {
                                controller.onClickAsset(asset);
                              },
                              child: const Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  radius: 8.0,
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.close,
                                      color: Colors.white, size: 12.0),
                                ),
                              ),
                            ),
                          )
                        : Container()),
                  ],
                );
              }));
    });
  }

  @override
  build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: context.theme.backgroundColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: listView(context));
  }

  Widget headerTabs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        height: 140,
        child: IrisTabView(
          isScrollable: true, // makes tabs take minimum space
          indicatorFullHeight: true,
          indicatorColor: context.theme.hoverColor,
          backgroundColor: context.theme.backgroundColor,
          tabs: [
            IrisTab(
              text: 'Members',
              body: usersList(context),
              icon: Icon(
                UniconsLine.user,
                color: context.theme.colorScheme.secondary,
                size: 20,
              ),
            ),
            IrisTab(
              text: 'Assets',
              body: assetsList(context),
              icon: Icon(
                UniconsLine.cloud,
                color: context.theme.colorScheme.secondary,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// TODO: REFACTOR THIS
  listView(BuildContext context) {
    return Obx(() => IrisListView(
          shrinkWrap: true,
          controller: scrollController,
          itemCount: controller.recentOrders$.length,
          header: headerTabs(context),
          emptyWidget: const NoOrdersView(),
          widgetLoader: const ShimmerScroll(),
          loadMore: controller.loadMoreOrders,
          builder: (BuildContext context, int index) {
            return Column(children: [
              Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  margin: const EdgeInsets.all(10),
                  child: SharedMessageText(
                    text: controller.recentOrders$[index],
                    onTap: () {
                      controller
                          .setSharingOrder!(controller.recentOrders$[index]);
                      Get.back();
                    },
                    irisEvent: Get.find(),
                  )),
              const SizedBox(height: 8),
              const Divider()
            ]);
          },
        ));
  }

  usersList(BuildContext context) {
    return Obx(() {
      final listUser = controller.currentUsers$;

      return Container(
          color: context.theme.hoverColor,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          //height: ScreenUtil().setWidth(115),
          child: ListView.builder(
              addAutomaticKeepAlives: false,
              scrollDirection: Axis.horizontal,
              itemCount: listUser.length,
              itemBuilder: (context, index) {
                final User user = listUser[index];
                String name = user.fullName.split(' ')[0];
                return Stack(
                  children: <Widget>[
                    FittedBox(
                      child: Container(
                          width: ScreenUtil().setWidth(60),
                          margin: const EdgeInsets.all(6.0),
                          child: Column(
                            children: [
                              UserImage(
                                  user: user,
                                  onTap: () {
                                    controller.onClickUser(user);
                                  }),
                              Text(name,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                            ],
                          )),
                    ),
                    Obx(() => controller.isSelectedUser(user)
                        ? Positioned(
                            right: 3.0,
                            top: 3.0,
                            child: GestureDetector(
                              onTap: () {
                                controller.onClickUser(user);
                              },
                              child: const Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  radius: 8.0,
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.close,
                                      color: Colors.white, size: 12.0),
                                ),
                              ),
                            ),
                          )
                        : Container()),
                  ],
                );
              }));
    });
  }
}

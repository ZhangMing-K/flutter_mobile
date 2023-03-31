import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/filter_button/filter_button.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/text_card.dart';

import '../controllers/profile_posts_controller.dart';

class EmptyProfilePosts extends StatelessWidget {
  const EmptyProfilePosts({required this.type, Key? key}) : super(key: key);
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                Images.noItemsInFeed,
                height: 150,
              ),
              Text(
                'No $type',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ProfilePostsView extends StatelessWidget {
  final ProfilePostsController controller;

  const ProfilePostsView({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        return IrisListView(
          onRefresh: controller.pullRefresh,
          loadMore: controller.loadMore,
          itemCount: state!.length,
          widgetLoader: const TextCardShimmer(
              useSpinner:
                  true), //TODO change to shimmer scroll like Jonatas feed?
          emptyWidget: EmptyProfilePosts(type: controller.textType),
          header: Builder(builder: (context) {
            final scaleFactor = context.textScaleFactor;
            return Obx(
              () {
                return Container(
                    height: 40 * scaleFactor,
                    margin: const EdgeInsets.only(top: 22),
                    child: ListView(
                        shrinkWrap: true,
                        primary: false,
                        addAutomaticKeepAlives: false,
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(width: 9),
                          FilterButtonItem(
                            onTap: () {
                              controller.onClickFilterButton(TEXT_TYPE.ORDER);
                            },
                            isSelected: controller.currentFilter.value ==
                                TEXT_TYPE.ORDER,
                            title: 'Orders',
                          ),
                          FilterButtonItem(
                            onTap: () {
                              controller.onClickFilterButton(TEXT_TYPE.POST);
                            },
                            isSelected: controller.currentFilter.value ==
                                TEXT_TYPE.POST,
                            title: 'Posts',
                          ),
                          const SizedBox(width: 8),
                        ]));
              },
            );
          }),
          builder: (BuildContext context, int index) {
            return Column(
              children: [
                TextCard(
                  text: state[index],
                ),
                Divider(
                  color: context.theme.backgroundColor,
                  height: 1,
                  thickness: 1,
                )
              ],
            );
          },
        );
      },
      onLoading: const TextCardShimmer(useSpinner: true),
    );
  }
}

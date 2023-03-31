import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class ImageDescription {
  String? imagePath;
  String? description;
  String? title;

  ImageDescription(
      {required this.imagePath,
      required this.description,
      required this.title});
}

class IrisSubscriptionCard extends StatelessWidget {
  final int purchaseItemKey;

  final String? title;
  final String? description;
  final String? image;
  final Function(PurchaseItemPrice plan)? onPlanTap;
  final List<ImageDescription> images;
  final List<PurchaseItemPrice> paymentPlans;
  const IrisSubscriptionCard(
      {Key? key,
      this.title,
      this.description,
      this.image,
      required this.onPlanTap,
      required this.images,
      required this.paymentPlans,
      required this.purchaseItemKey})
      : super(key: key);

  Widget body(PurchaseItemPrice plan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          plan.intervalUnitString!,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(plan.price.formatCurrency()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          // height: ScreenUtil().setHeight(135),
          decoration: BoxDecoration(
            color: context.theme.brightness == Brightness.dark
                ? const Color(0xff303235)
                : const Color(0xffECECEC),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: [imageCarousel(context), payments(context)])),
    );
  }

  Widget customTile(PurchaseItemPrice plan) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      head(plan),
      trailing(plan),
    ]);
  }

  Widget head(PurchaseItemPrice plan) {
    return Row(children: [leading(plan), body(plan)]);
  }

  Widget imageCarousel(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: images.length,
        options: CarouselOptions(
          autoPlay: false,
          // enlargeCenterPage: true,
          viewportFraction: 0.8,
          height: 320,
        ),
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          final String imagePath = images[itemIndex].imagePath!;
          final String title = images[itemIndex].title!;
          final String description = images[itemIndex].description!;
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
                imageText(title, description)
              ],
            ),
          );
        });
  }

  Widget imageText(String title, String description) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                title,
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              )),
          Container(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                description,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 17),
              )),
        ],
      ),
    );
  }

  Widget leading(PurchaseItemPrice plan) {
    return Container(
        width: 50,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          plan.intervalString!,
          style: const TextStyle(fontSize: 31),
        ));
  }

  payments(BuildContext context) {
    // return Container();

    return IrisListView(
      shrinkWrap: true,
      itemCount: paymentPlans.length,
      builder: (BuildContext context, int index) {
        final plan = paymentPlans[index];
        final bool last = index == paymentPlans.length - 1;
        return InkWell(
            onTap: () => onPlanTap!(plan),
            child: Column(
              children: [
                const Divider(),
                Container(
                    padding: last ? const EdgeInsets.only(bottom: 10) : null,
                    child: customTile(plan))
              ],
            ));
      },
    );
  }

  Widget trailing(PurchaseItemPrice plan) {
    return const InkWell(
      child: Icon(Icons.chevron_right, size: 24),
    );
  }
}

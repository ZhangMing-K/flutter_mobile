import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/pages.dart';
import '../controllers/auto_pilot_controller.dart';

class AutoPilotScreenWeb extends GetView<AutoPilotController> {
  const AutoPilotScreenWeb({Key? key}) : super(key: key);

  Widget imageCarousel(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: 4,
        options: CarouselOptions(
          autoPlay: false,
          // enlargeCenterPage: true,
          viewportFraction: 0.8,
          height: 320,
        ),
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(itemIndex.toString()),
                Text(pageViewIndex.toString())
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.grey.shade900, width: 0.0))),
          child: BottomNavbar(
            isGoldMode: false,
            onActiveMenuItemPressed: (_) {
              //controller.scrollToTop();
            },
          ),
        ),
        body: Column(
          children: [
            imageCarousel(context),
          ],
        ));
  }
}

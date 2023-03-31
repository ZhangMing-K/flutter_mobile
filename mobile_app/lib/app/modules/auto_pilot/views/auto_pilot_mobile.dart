import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/pages.dart';
import '../controllers/auto_pilot_controller.dart';

const String applyForPilotLink = 'https://sgnryuyw5au.typeform.com/to/pfxJKlgB';
const String becomePilotLink = 'https://sgnryuyw5au.typeform.com/to/XTHTWwkq';

class AutoPilotScreenMobile extends GetView<AutoPilotController> {
  const AutoPilotScreenMobile({Key? key}) : super(key: key);

  Widget header() {
    return Builder(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Images.autopilotIcon,
            height: IrisScreenUtil.dHeight(69),
            width: IrisScreenUtil.dHeight(69),
          ),
          const SizedBox(width: 5),
          Text('Autopilot',
              textScaleFactor: 1,
              style: TextStyle(
                  fontSize: IrisScreenUtil.dFontSize(40),
                  fontWeight: FontWeight.bold)),
          const SizedBox(width: 5),
          Text(
            'by iris',
            textScaleFactor: 1,
            style: TextStyle(
                color: context.theme.colorScheme.secondary.withOpacity(0.6),
                fontSize: IrisScreenUtil.dFontSize(16),
                fontWeight: FontWeight.w500,
                height:
                    2.5 // to adjust the bottom line with autopilot text (40 / 16)
                ),
          )
        ],
      );
    });
  }

  Widget imageCarousel(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: 4,
        carouselController: controller.carouselController,
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            controller.currentIndex.value = index;
          },
          height: IrisScreenUtil.dHeight(370),
        ),
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          final apScreenItem = controller.apScreensList[itemIndex];
          return SizedBox(
            width: double.infinity,
            child: carouselContent(apScreenItem),
          );
        });
  }

  BoxDecoration kGradientBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff47E9FF),
            Color(0xffC82CFF),
          ],
          stops: [0.0, 1],
          transform: GradientRotation(1),
          tileMode: TileMode.clamp),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    );
  }

  Widget carouselContent(ApScreenItemInput item) {
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(item.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: IrisScreenUtil.dFontSize(20),
                      fontWeight: FontWeight.w600)),
              SizedBox(height: IrisScreenUtil.dHeight(24)),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    item.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: context.theme.custom.colorScheme.grayText,
                        fontSize: IrisScreenUtil.dFontSize(16)),
                  )),
            ],
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                context.isDarkMode ? item.imgPath : item.imgPathLight,
                height: IrisScreenUtil.dHeight(item.imgHeight),
                width: IrisScreenUtil.dHeight(item.imgWidth),
              ),
            ),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: IrisTabView.expanded(
        header: Container(
            margin: EdgeInsets.only(top: IrisScreenUtil.dWidth(18)),
            child: header()),
        hideTab: true,
        tabs: [
          IrisTab(
              text: '',
              body: Container(
                padding: EdgeInsets.only(
                    top: IrisScreenUtil.dHeight(30),
                    bottom: IrisScreenUtil.dHeight(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    imageCarousel(context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.apScreensList.map((entry) {
                        return GestureDetector(
                          onTap: () => controller.carouselController
                              .animateToPage(entry.index),
                          child: Obx(() {
                            return Container(
                                width: IrisScreenUtil.dHeight(12.0),
                                height: IrisScreenUtil.dHeight(12.0),
                                margin: EdgeInsets.symmetric(
                                    vertical: IrisScreenUtil.dHeight(8.0),
                                    horizontal: IrisScreenUtil.dWidth(8.0)),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: controller.currentIndex.value ==
                                            entry.index
                                        ? const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xff50DCFF),
                                              Color(0xff9E69FF),
                                            ],
                                            stops: [0.0, 1],
                                            tileMode: TileMode.clamp)
                                        : null,
                                    color: context.isDarkMode
                                        ? const Color(0xff4A4A4A)
                                        : const Color(0xffCDCDCD)));
                          }),
                        );
                      }).toList(),
                    ),
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          height: IrisScreenUtil.dHeight(51),
                          child: InkWell(
                              onTap: () {
                                UrlUtils.open(becomePilotLink);
                              },
                              child: Container(
                                  decoration: kGradientBoxDecoration(),
                                  child: Center(
                                      child: Text('Join the waitlist',
                                          style: TextStyle(
                                            fontSize:
                                                IrisScreenUtil.dFontSize(16),
                                            fontWeight: FontWeight.w600,
                                            color: Colors
                                                .white, //context.theme.colorScheme.secondary,
                                          ))))),
                        ),
                        SizedBox(height: IrisScreenUtil.dHeight(8)),
                        InkWell(
                            onTap: () {
                              UrlUtils.open(applyForPilotLink);
                            },
                            child: Padding(
                                padding:
                                    EdgeInsets.all(IrisScreenUtil.dHeight(8)),
                                child: Text(
                                  'Want to be a Pilot?',
                                  style: TextStyle(
                                    color: context
                                        .theme.custom.colorScheme.autoPilotText,
                                    fontSize: IrisScreenUtil.dFontSize(16),
                                  ),
                                ))),
                      ],
                    ),
                  ],
                ),
              ))
        ],
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
    );
  }
}

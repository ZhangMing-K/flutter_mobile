import 'package:flutter/material.dart';

const BorderRadius kBorderRadius = BorderRadius.all(Radius.circular(10));
const Duration kBubbleAnimation = Duration(milliseconds: 20);
const double kDefaultScreenHeight = 810.0;

///screen
const double kDefaultScreenWidth = 400.0;
const String kFeedSavedTime = 'feed-last-refreshed-time';

///size
const double kIconSize = 25.0;
const double kTouchableSize = 44.0;

const Curve kKeyboardCurve = Curves.easeInOut;
const Curve kKeyboardReverseCurve = Curves.easeInToLinear;

const Duration kKeyboardTransition = Duration(milliseconds: 300);
const String kPrivacyPolicyUrl = 'https://www.iris.finance/privacy-policy';

///Animation
const Duration kRouteTransition = Duration(milliseconds: 400);
const Duration kTabFadeAnimation = Duration(milliseconds: 500);
const Duration kDefaultAnimationDuration = Duration(milliseconds: 300);

//variable that is saved for onboarding
const kTermsOfServiceUrl = 'https://beta.iris.finance/terms-and-conditions/';

//variable that is saved for onboarding
const String kVideoShowOnboarding = 'showOnboarding5';

// variable that is saved for feed refresh
const String kWatchlistStoreageKey = 'used-watch-list-feature';

// shared function to get inner and outer padding for userImage

double baseRingNumber(double radius, {bool isAsset = false}) {
  if (isAsset) {
    return radius / 20;
  }
  return radius / 6;
}

double getInnerPadding(double radius,
    {bool isAsset = false, bool hasUnseenStories = false}) {
  double baseRing = baseRingNumber(radius, isAsset: isAsset);
  if (hasUnseenStories) {
    return baseRing * (3.0 / 5);
  }
  return baseRing * (4 / 5);
}

double getOuterPadding(double radius,
    {bool isAsset = false, bool hasUnseenStories = false}) {
  double baseRing = baseRingNumber(radius, isAsset: isAsset);
  if (hasUnseenStories) {
    return baseRing * (2.0 / 5);
  }
  return baseRing / 5;
}

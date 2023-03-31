import 'dart:math';

import 'package:get/get.dart';

import '../../iris_common.dart';

extension UserExt on User {
  TradePerformanceConnection? get allTradePerformancConnection =>
      tradePerformanceConnections?.firstWhereOrNull(
        (element) => element.segmentType == SEGMENT_TYPE.ALL_POSITION_TYPES,
      );

  String get descriptionPreview {
    if (description == null || description!.isEmpty) return '';

    final descriptionLength = description!.length;
    final index = descriptionLength > 50 ? 50 : descriptionLength;

    return description!.substring(0, index);
  }

  String get displayName {
    String displayUsername = '';

    if (username != null && username!.isNotEmpty) {
      displayUsername = '@' + username!;
    }
    return displayUsername;
  }

  String get fullName {
    String fullName = '';

    if (firstName != null) {
      fullName += '$firstName ';
    }

    if (lastName != null) {
      fullName += '$lastName';
    }
    return fullName;
  }

  bool get highlightTradeAccuracy {
    final tradeAccuracy =
        allTradePerformancConnection?.tradePerformance?.tradeAccuracy;

    if (tradeAccuracy != null && tradeAccuracy > .8) {
      return true;
    }
    return false;
  }

  bool get highlightTradingSimilarity {
    final similarity = authUserSimilarity?.assetSimilarityPercent;

    if (similarity != null && similarity > .5) {
      return true;
    }
    return false;
  }

  bool get isOnline {
    return DateTime.now().difference(lastOnlineAt!) <
        const Duration(minutes: 2);
  }

  String? get timeTrading {
    if (firstOrderAt == null) {
      return null;
    }
    final DateTime now = DateTime.now();
    final int nbr = now.difference(firstOrderAt!).inDays;

    if (nbr == 1) {
      return '1 day';
    } else if (nbr < 30) {
      return '$nbr days';
    } else if (nbr < 365 && nbr >= 30) {
      final int nbrMonths = (nbr / 30).floor();
      if (nbrMonths == 1) {
        return '1 month';
      }
      return '$nbrMonths months';
    } else if (nbr >= 365) {
      final int nbrYears = (nbr / 365).floor();
      final int months = (nbr % 365) % 30;
      if (months <= 1 && nbrYears == 1) {
        return '1 year';
      } else if (months < 1) {
        return '$nbrYears years';
      } else if (months > 1 && nbrYears == 1) {
        return '1 year and $months months';
      } else if (months > 1 && nbrYears >= 1) {
        return '$nbrYears years and $months months';
      } else {
        return '$nbrYears years';
      }
    }
    return '';
  }

  double? get timeTradingNbr {
    if (firstOrderAt == null) {
      return null;
    }
    final DateTime now = DateTime.now();
    final int nbr = now.difference(firstOrderAt!).inDays;
    double years = nbr / 365;
    const int decimals = 1;
    final int fac = pow(10, decimals) as int;
    years = (years * fac).round() / fac;
    return years;
  }

  String? get tradeAccuracy {
    if (tradePerformance?.tradeAccuracy != null) {
      return tradePerformance?.tradeAccuracy.formatPercentage();
    }
    return '0%';
  }

  double? get tradeAccuracyDouble {
    if (tradePerformanceConnections != null &&
        tradePerformanceConnections!.isNotEmpty) {
      final accuracy =
          allTradePerformancConnection?.tradePerformance?.tradeAccuracy;
      if (accuracy != null) {
        return accuracy;
      }
    }
    return null;
  }

  String? get traderPercentile {
    if (tradePerformanceConnections != null &&
        tradePerformanceConnections!.isNotEmpty) {
      final percentile =
          allTradePerformancConnection?.percentileConnection?.percentile;
      if (percentile != null) {
        return percentile.formatPercentageSensitive(dontShowLessthan: .3);
      }
    }

    return null;
  }

  double? get traderPercentileDouble {
    if (tradePerformanceConnections != null &&
        tradePerformanceConnections!.isNotEmpty) {
      final percentile =
          allTradePerformancConnection?.percentileConnection?.percentile;
      if (percentile != null) {
        return percentile;
      }
    }

    return null;
  }

  String? get tradingSimilarity {
    if (authUserSimilarity?.assetSimilarityPercent != null) {
      return authUserSimilarity!.assetSimilarityPercent.formatPercentage();
    } else if (followStats?.numberOfFollowers != null) {
      return 'N/A';
    }
    return null;
  }

  String getShortenedDescription(int length) {
    if (description == null) {
      return '';
    }
    if (description!.length > length) {
      return description!.substring(0, length);
    }
    return description!;
  }

  void routeToFromProfilePicture(Function? afterStories, String id) {
    if (storiesConnection != null &&
        storiesConnection!.metaData != null &&
        storiesConnection!.metaData!.nbrStories! > 0) {
      final storyArgs = StoryArgs(
        user: this,
        storiesConnection: storiesConnection!,
        afterStories: afterStories,
        heroTag: id,
      );
      Get.toNamed(
        Paths.UserSingleStory,
        arguments: storyArgs,
        parameters: {
          'profileUserKey': userKey.toString(),
        },
        // arguments: profileArgs,
      );
    } else {
      final profileArgs = ProfileArgs(
        user: this,
        heroTag: id,
      );
      Get.toNamed(
        Paths.Feed + Paths.Home + Paths.Profile,
        arguments: profileArgs,
        parameters: {
          'profileUserKey': userKey.toString(),
        },
        id: 1,
      );
    }
  }

  void routeToProfile([String? heroTag]) {
    final profileArgs = ProfileArgs(
      user: this,
      heroTag: heroTag ?? userKey.toString(),
    );
    Get.toNamed(
      Paths.Feed + Paths.Home + Paths.Profile,
      arguments: profileArgs,
      parameters: {
        'profileUserKey': userKey.toString(),
      },
      id: 1,
    );
  }
}

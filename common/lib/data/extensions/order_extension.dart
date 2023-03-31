import 'package:flutter/foundation.dart';

import '../../iris_common.dart';

extension OrderExt on Order {
  //TODO add as field, move to backend.
  DateTime? get closedDate {
    // Fully closed position
    if (closedAt is DateTime) {
      return closedAt;
    } else if (positionEffect == POSITION_EFFECT.CLOSE &&
        placedAt is DateTime) {
      return placedAt;
    } else {
      return null;
    }
  }

  //TODO add as field, move to backend.
  get displayAssetName {
    String? display = '';
    if (symbol != null) {
      display = '$symbol';
    } else if (asset?.symbol != null) {
      display = asset!.symbol;
    }

    if (asset?.name != null) {
      display = '$display (${asset!.name})';
    }
    return display;
  }

  //TODO add as field, move to backend.
  bool get hasLongOptionName {
    return [
      ORDER_STRATEGY_TYPE.BACK_RATIO,
      ORDER_STRATEGY_TYPE.BUTTERFLY,
      ORDER_STRATEGY_TYPE.CALENDAR,
      ORDER_STRATEGY_TYPE.COLLAR_SYNTHETIC,
      ORDER_STRATEGY_TYPE.CONDOR,
      ORDER_STRATEGY_TYPE.CUSTOM,
      ORDER_STRATEGY_TYPE.DIAGONAL,
      ORDER_STRATEGY_TYPE.DOUBLE_DIAGONAL,
      ORDER_STRATEGY_TYPE.IRON_CONDOR,
      ORDER_STRATEGY_TYPE.LONG_CALL_SPREAD,
      ORDER_STRATEGY_TYPE.LONG_PUT_SPREAD,
      ORDER_STRATEGY_TYPE.SHORT_CALL_SPREAD,
      ORDER_STRATEGY_TYPE.SHORT_PUT_SPREAD,
      ORDER_STRATEGY_TYPE.STRANGLE,
      ORDER_STRATEGY_TYPE.UNBALANCED_BUTTERFLY,
      ORDER_STRATEGY_TYPE.VERTICAL,
      ORDER_STRATEGY_TYPE.VERTICAL_ROLL,
    ].containsEnum(strategyType);
  }

  //TODO add as field, move to backend.??
  bool get isAutoPiloted {
    if (text?.order?.autoPilotOrder == null) {
      return false;
    }
    return true;
  }

  //TODO add as field, move to backend.
  bool get isComplexOption {
    return [
      ORDER_STRATEGY_TYPE.BACK_RATIO,
      ORDER_STRATEGY_TYPE.BUTTERFLY,
      ORDER_STRATEGY_TYPE.CALENDAR,
      ORDER_STRATEGY_TYPE.COLLAR_SYNTHETIC,
      ORDER_STRATEGY_TYPE.CONDOR,
      ORDER_STRATEGY_TYPE.COVERED,
      ORDER_STRATEGY_TYPE.CUSTOM,
      ORDER_STRATEGY_TYPE.DIAGONAL,
      ORDER_STRATEGY_TYPE.DOUBLE_DIAGONAL,
      ORDER_STRATEGY_TYPE.IRON_CONDOR,
      ORDER_STRATEGY_TYPE.LONG_CALL_SPREAD,
      ORDER_STRATEGY_TYPE.LONG_PUT_SPREAD,
      ORDER_STRATEGY_TYPE.SHORT_CALL_SPREAD,
      ORDER_STRATEGY_TYPE.SHORT_PUT_SPREAD,
      ORDER_STRATEGY_TYPE.STRADDLE,
      ORDER_STRATEGY_TYPE.STRANGLE,
      ORDER_STRATEGY_TYPE.UNBALANCED_BUTTERFLY,
      ORDER_STRATEGY_TYPE.VERTICAL,
      ORDER_STRATEGY_TYPE.VERTICAL_ROLL,
    ].containsEnum(strategyType);
  }

  //TODO add as field, move to backend.
  bool get isMultiExpiration {
    return [
      ORDER_STRATEGY_TYPE.CALENDAR,
    ].containsEnum(strategyType);
  }

  //TODO add as field, move to backend.
  bool get isMultiStrike {
    return [
      ORDER_STRATEGY_TYPE.BACK_RATIO,
      ORDER_STRATEGY_TYPE.BUTTERFLY,
      ORDER_STRATEGY_TYPE.CALENDAR,
      ORDER_STRATEGY_TYPE.COLLAR_SYNTHETIC,
      ORDER_STRATEGY_TYPE.CONDOR,
      ORDER_STRATEGY_TYPE.CUSTOM,
      ORDER_STRATEGY_TYPE.DIAGONAL,
      ORDER_STRATEGY_TYPE.DOUBLE_DIAGONAL,
      ORDER_STRATEGY_TYPE.IRON_CONDOR,
      ORDER_STRATEGY_TYPE.LONG_CALL_SPREAD,
      ORDER_STRATEGY_TYPE.LONG_PUT_SPREAD,
      ORDER_STRATEGY_TYPE.SHORT_CALL_SPREAD,
      ORDER_STRATEGY_TYPE.SHORT_PUT_SPREAD,
      ORDER_STRATEGY_TYPE.STRANGLE,
      ORDER_STRATEGY_TYPE.UNBALANCED_BUTTERFLY,
      ORDER_STRATEGY_TYPE.VERTICAL,
      ORDER_STRATEGY_TYPE.VERTICAL_ROLL,
    ].containsEnum(strategyType);
  }

  //TODO add as field, move to backend.
  bool get isShort {
    return [
      ORDER_STRATEGY_TYPE.SHORT_CALL,
      ORDER_STRATEGY_TYPE.SHORT_PUT,
      ORDER_STRATEGY_TYPE.SHORT_CALL_SPREAD,
      ORDER_STRATEGY_TYPE.SHORT_PUT_SPREAD,
    ].containsEnum(strategyType);
  }

  //TODO add as field, move to backend.
  bool get isSpreadOption {
    return [
      ORDER_STRATEGY_TYPE.BUTTERFLY,
      ORDER_STRATEGY_TYPE.CALENDAR,
      ORDER_STRATEGY_TYPE.COLLAR_SYNTHETIC,
      ORDER_STRATEGY_TYPE.CUSTOM,
      ORDER_STRATEGY_TYPE.DIAGONAL,
      ORDER_STRATEGY_TYPE.DOUBLE_DIAGONAL,
      ORDER_STRATEGY_TYPE.LONG_CALL_SPREAD,
      ORDER_STRATEGY_TYPE.LONG_PUT_SPREAD,
      ORDER_STRATEGY_TYPE.SHORT_CALL_SPREAD,
      ORDER_STRATEGY_TYPE.SHORT_PUT_SPREAD,
      ORDER_STRATEGY_TYPE.UNBALANCED_BUTTERFLY,
      ORDER_STRATEGY_TYPE.VERTICAL,
      ORDER_STRATEGY_TYPE.VERTICAL_ROLL,
    ].containsEnum(strategyType);
  }

  //TODO add as field, move to backend.
  String get optionTypeDisplay {
    if (optionType == OPTION_TYPE.CALL) {
      return 'Call';
    } else if (optionType == OPTION_TYPE.PUT) {
      return 'Put';
    } else {
      return 'Option';
    }
  }

  //TODO add as field, move to backend.
  String get orderSideDisplayAction {
    //good
    final isOrderStrategy =
        ORDER_STRATEGY_TYPE.values.containsEnum(strategyType);
    if (isOrderStrategy && isMultiStrike && !isShort) {
      return positionEffect == POSITION_EFFECT.OPEN ? 'Opened' : 'Closed';
    } else if (isOrderStrategy && isShort) {
      return positionEffect == POSITION_EFFECT.OPEN
          ? 'Sold to Open'
          : 'Bought to Close';
    } else {
      if (orderSide == ORDER_SIDE.BUY) {
        return 'Bought';
      } else if (orderSide == ORDER_SIDE.SELL) {
        return 'Sold';
      }
    }
    return 'Unknown';
  }

  //TODO add as field, move to backend.
  String get orderStrategyDisplay {
    if (strategyType is ORDER_STRATEGY_TYPE) {
      if ([
        ORDER_STRATEGY_TYPE.LONG_CALL,
        ORDER_STRATEGY_TYPE.LONG_PUT,
        ORDER_STRATEGY_TYPE.SHORT_CALL,
        ORDER_STRATEGY_TYPE.SHORT_PUT,
      ].containsEnum(strategyType)) {
        return optionTypeDisplay;
      } else {
        final rgx = RegExp(r'(^long_)|(^short_)');
        String display = describeEnum(strategyType!)
            .toString()
            .toLowerCase()
            .replaceAll(rgx, '')
            .split('_')
            .map((e) => e.capitalizeFirstApp())
            .join(' ');
        if (isSpreadOption &&
            !display.contains(RegExp(r'spread', caseSensitive: false))) {
          display += ' Spread';
        }
        return display;
      }
    } else {
      return optionTypeDisplay;
    }
  }

  //TODO add as field, move to backend.
  String get positionEffectDisplay {
    if (positionEffect == POSITION_EFFECT.OPEN) {
      return 'Open';
    } else if (positionEffect == POSITION_EFFECT.CLOSE) {
      return 'Close';
    } else {
      return 'None';
    }
  }

  //TODO add as field, move to backend.
  int? get positionOpenTimeDays {
    if (closedDate is DateTime && openedAt is DateTime) {
      return closedDate!.difference(openedAt!).inDays;
    } else {
      return null;
    }
  }

  //TODO add as field, move to backend.
  String? get positionOpenTimeDisplay {
    if (positionOpenTimeDays is int && closedDate != null) {
      String? unit;
      double? duration;
      double positionOpenTimeDaysDouble = positionOpenTimeDays!.toDouble();
      if (positionOpenTimeDaysDouble > 0) {
        if (positionOpenTimeDaysDouble > 365) {
          duration = positionOpenTimeDaysDouble / 365;
          unit = 'yrs';
          if (duration == 1) {
            unit = 'yr';
          }
        } else if (positionOpenTimeDaysDouble > 60) {
          duration = positionOpenTimeDaysDouble / 30;
          unit = 'mo';
        } else if (positionOpenTimeDaysDouble > 14) {
          duration = positionOpenTimeDaysDouble / 7;
          unit = 'wk';
          if (duration.round() > 1) {
            unit = 'wks';
          }
        } else if (positionOpenTimeDaysDouble <= 14) {
          duration = positionOpenTimeDaysDouble;
          unit = 'days';
          if (duration == 1) {
            unit = 'day';
          }
        }
      } else if (closedDate!.difference(openedAt!).inHours >= 1) {
        duration = closedDate!.difference(openedAt!).inHours.toDouble();
        unit = 'hrs';
        if (duration == 1) {
          unit = 'hr';
        }
      } else if (closedDate!.difference(openedAt!).inMinutes > 0) {
        duration = closedDate!.difference(openedAt!).inMinutes.toDouble();
        unit = 'min';
      }
      if (duration != null && unit != null) {
        return '${duration.round()} $unit';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //TODO add as field, move to backend.
  double? get profitLossPercentValue {
    if (profitLossPercent is double) {
      return profitLossPercent;
    } else if (positionEffect == POSITION_EFFECT.OPEN &&
        positionType == POSITION_TYPE.EQUITY &&
        closedAt == null &&
        asset?.currentPrice != null &&
        averagePrice != null) {
      return (asset!.currentPrice! - averagePrice!) / averagePrice!;
    } else if (closedAt != null && averageSellPrice != null) {
      if (averageBuyPrice != null) {
        return (averageSellPrice! - averageBuyPrice!) / averageBuyPrice!;
      }
      return null;
    } else {
      return null;
    }
  }

  //TODO add as field, move to backend.
  String get readableAction {
    //bad i should never have done this
    var display = '';
    final assetName = displayAssetName;
    if (orderSide == ORDER_SIDE.BUY) {
      display += 'Bought';
    } else if (orderSide == ORDER_SIDE.SELL) {
      display += 'Sold';
    }

    if (positionType == POSITION_TYPE.EQUITY ||
        positionType == POSITION_TYPE.CRYPTO) {
      display += ' $assetName at \$$averagePrice';
    } else if (positionType == POSITION_TYPE.OPTION) {
      if (optionType == OPTION_TYPE.PUT) {
        display += ' PUT';
      } else if (optionType == OPTION_TYPE.CALL) {
        display += ' CALL';
      }

      display +=
          ' options on $assetName at \$$averagePrice \nStrike price: \$$strikePrice \nExpiration Date: ${expirationDate.formatMonthDayYear()}';
    }

    return display;
  }
}

extension EnumExt<T extends Enum> on Iterable<T> {
  bool containsEnum(String? strategyType) {
    return any((element) => element.name == strategyType);
  }
}

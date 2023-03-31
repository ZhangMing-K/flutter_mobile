import 'package:flutter/material.dart';

import '../../iris_common.dart';

/// returns a basic square logo for the given `brokerName`
/// `useAlt` will return an alternate square logo if one is provided for given `brokerName`,
class BrokerIcon extends StatelessWidget {
  const BrokerIcon(
      {Key? key,
      this.height = 40,
      required this.brokerName,
      this.useAltLogo = false})
      : super(key: key);
  final double height;
  final BROKER_NAME? brokerName;
  final bool useAltLogo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade700,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(height / 4),
        image: DecorationImage(
            onError: (err, stack) {},
            image: AssetImage(getBrokerIcon()),
            fit: BoxFit.cover),
      ),
    );
  }

  String? getAltBrokerIcon() {
    switch (brokerName) {
      case BROKER_NAME.WEBULL:
        return Images.webullLogoAlt;
      default:
        return null;
    }
  }

  String getBrokerIcon() {
    if (useAltLogo) {
      String? logo = getAltBrokerIcon();
      if (logo != null) {
        return logo;
      }
    }
    switch (brokerName) {
      case BROKER_NAME.ROBINHOOD:
        return IconPath.robinHood;
      case BROKER_NAME.TD_AMERITRADE:
        return Images.tdAmeritradeLogo;
      case BROKER_NAME.FIDELITY:
        return Images.fidelityLogo;
      case BROKER_NAME.WEBULL:
        return Images.webullLogo;
      case BROKER_NAME.ETRADE:
        return Images.etradeLogo;
      case BROKER_NAME.SCHWAB:
        return Images.schwab;
      case BROKER_NAME.COINBASE:
        return Images.coinbaseIcon;
      case BROKER_NAME.CUSTOM_GOVERNMENT:
        return Images.customGovernmentLogo;
      case BROKER_NAME.CUSTOM_HEDGE_FUND:
        return Images.customGovernmentLogo; //todo get hedgefund image designed
      case BROKER_NAME.CUSTOM_MANUAL:
        return IconPath.robinHood; //todo get manual image designed
      default:
        return IconPath.robinHood;
    }
  }
}

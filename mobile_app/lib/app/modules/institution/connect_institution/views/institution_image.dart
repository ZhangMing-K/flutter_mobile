import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class InstitutionImage extends StatelessWidget {
  final INSTITUTION_NAME? institionName;

  const InstitutionImage({Key? key, required this.institionName})
      : super(key: key);

  String get assetImage {
    if (institionName == INSTITUTION_NAME.ROBINHOOD) {
      return Images.robinhoodText;
    } else if (institionName == INSTITUTION_NAME.TD_AMERITRADE) {
      return Images.tdAmeritradeText;
    } else if (institionName == INSTITUTION_NAME.FIDELITY) {
      return Images.fidelityText;
    } else if (institionName == INSTITUTION_NAME.WEBULL) {
      return Images.webullLogo;
    } else if (institionName == INSTITUTION_NAME.ETRADE) {
      return Images.etradeLogo;
    } else if (institionName == INSTITUTION_NAME.SCHWAB) {
      return Images.schwab;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Image.asset(
        assetImage,
        height: 170,
        width: 300,
      ),
    );
  }
}

import 'package:iris_common/iris_common.dart';

class ConnectInstitutionArgs {
  INSTITUTION_CONNECTED_FROM from;
  int? portfolioKey;
  ConnectInstitutionArgs(
      {this.from = INSTITUTION_CONNECTED_FROM.PROFILE, this.portfolioKey});
}

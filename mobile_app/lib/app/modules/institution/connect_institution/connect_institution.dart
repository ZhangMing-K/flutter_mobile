import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/connect_institution_mobile.dart';

class ConnectInstitutions extends StatelessWidget {
  const ConnectInstitutions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.responsiveValue(
      mobile: const ConnectInstitutionMobile(),
    )!;
  }
}

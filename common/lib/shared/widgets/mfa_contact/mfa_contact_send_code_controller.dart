import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:get/get.dart';

import '../../../iris_common.dart';

class MfaContactSendCodeController extends GetxController {
  GlobalKey<FormBuilderState> numberFormKey = GlobalKey<FormBuilderState>();
  RxBool submitDisabled$ = RxBool(true);
  RxnString phoneNumber$ = RxnString('');
  MfaContactService mfaContactService = Get.find();

  // Rx<MfaContact?> mfaContact$ = Rx<MfaContact?>(null);
  RxnString dialCode$ = RxnString('+1');
  RxnString countryCode$ = RxnString('US'); // default US
  RxnString sendCodeError$ = RxnString();
  final countries = CountryManager().countries;

  String formatNumber(String? phoneNumber) {
    if (phoneNumber != null) {
      return FlutterLibphonenumber()
          .formatNumberSync(phoneNumber); // +1 414-555-6666
    } else {
      return 'Your phone number';
    }
  }

  CountryWithPhoneCode get currentCountryCode {
    String phoneCode = dialCode$.value!.substring(1);
    String countryCode = countryCode$.value!.toString();
    final countryCodes = countries
        .where((CountryWithPhoneCode element) =>
            (element.phoneCode == phoneCode &&
                element.countryCode == countryCode))
        .toList();
    if (countryCodes.isNotEmpty) {
      return countryCodes[0];
    }
    return const CountryWithPhoneCode.us();
  }

  void listenTextChanges(String? number) async {
    final parsed = await FlutterLibphonenumber().getFormattedParseResult(
        dialCode$.value! + number!, currentCountryCode);
    if (parsed != null) {
      submitDisabled$.value = false;
      phoneNumber$.value = parsed.e164;
    } else {
      submitDisabled$.value = true;
      phoneNumber$.value = null;
    }
    // if (numberFormKey.currentState!.fields['phoneNumber']!.isValid) {
    //   submitDisabled$.value = false;
    //   phoneNumber$.value = number;
    // } else {
    //   submitDisabled$.value = true;
    //   phoneNumber$.value = null;
    // }
    sendCodeError$.value = null;
  }

  Future<MFAContact?> sendCode(MFA_VERIFY_ACTION action) async {
    final completer = Completer<MFAContact?>();
    if (phoneNumber$.value != null) {
      // submitDisabled$.value = true;

      await overlayLoader(
        context: Get.overlayContext!,
        asyncFunction: () async {
          try {
            final contact = await mfaContactService.sendCode(
                action: action,
                contactType: MFA_CONTACT_TYPE.SMS,
                contactValue: '${phoneNumber$.value}');
            debugPrint('contact: $contact');
            completer.complete(contact);
            //         onSendCodeCallback(mfaContact$.value!);
          } catch (err) {
            if (err is List && err.isNotEmpty) {
              sendCodeError$.value = err[0].message;
            }
            debugPrint('err: $err');
            completer.complete(null);
          }
        },
        opacity: .7,
        loaderColor: Get.context!.theme.primaryColor,
      );

      return completer.future;
    }
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class MfaContactVerifyCodeController extends GetxController {
  final UserService userService = Get.find();
  final AuthService authService = Get.find();
  final RxBool verifyDisabled$ = true.obs;
  final RxnString verificationCode$ = RxnString('');
  final IAuthUserService authUserStore = Get.find();
  final MfaContactService mfaContactService = Get.find();
  final RxnString verificationError$ = RxnString();
  final GlobalKey<FormBuilderState> verificationFormKey =
      GlobalKey<FormBuilderState>();

  bool get incorrectData {
    return verificationError$.value != null || verificationError$.value == '';
  }

  String formatNumber(MFAContact? mfaContact) {
    final mfaContactValue = mfaContact?.contactValue;
    if (mfaContactValue != null) {
      return FlutterLibphonenumber()
          .formatNumberSync(mfaContactValue); // +1 414-555-6666
    } else {
      return 'Your phone number';
    }
  }

  void listenInputChange(String code) {
    if (verificationFormKey.currentState!.fields['verification']!.isValid) {
      verifyDisabled$.value = false;
      verificationCode$.value = code;
    } else {
      verifyDisabled$.value = true;
      verificationCode$.value = null;
    }
    verificationError$.value = null;
  }

  Future<MFAContact?> resend(
      MFA_VERIFY_ACTION action, MFAContact? mfaContact) async {
    return overlayLoader(
      context: Get.overlayContext!,
      asyncFunction: () async {
        try {
          return mfaContactService.sendCode(
              action: action,
              contactType: MFA_CONTACT_TYPE.SMS,
              contactValue: mfaContact!.contactValue);
        } catch (e) {
          debugPrint(e.toString());
          return null;
        }
      },
      opacity: .7,
      loaderColor: IrisColor.primaryColor,
    );
  }

  void setAuthUserPhoneNumber(MFAContact mfaContact) {
    authUserStore.editUserData(authUserStore.loggedUser!
        .copyWith(phoneNumber: mfaContact.contactValue));
  }

  Future<MFAContact?> verifyCode(
      MFA_VERIFY_ACTION action, MFAContact? mfaContact) async {
    if (verificationCode$.value != null) {
      // verifyDisabled$.value = true;

      return overlayLoader(
        context: Get.overlayContext!,
        asyncFunction: () async {
          try {
            final data = await mfaContactService.verifyCode(
              action: action,
              challengeId: mfaContact!.challengeId,
              code: verificationCode$.value,
            );

            if (data == null) {
              Get.snackbar('Error', 'Unable to sign in');
              return null;
            }
            if (action == MFA_VERIFY_ACTION.MAKE_PRIMARY) {
              setAuthUserPhoneNumber(data);
            }

            return data;
          } catch (err) {
            if (err is List) {
              if (err.isNotEmpty) verificationError$.value = err[0].message;
              debugPrint(err.toString());
            }
            return null;
          }
        },
        opacity: .7,
        loaderColor: IrisColor.primaryColor,
      );
    }
    return null;
  }
}

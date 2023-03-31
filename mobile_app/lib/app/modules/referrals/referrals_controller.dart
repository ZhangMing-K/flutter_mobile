import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart' hide Share;
import 'package:iris_mobile/widgets_v2/snackbars/success_snackbar.dart';
import 'package:share_plus/share_plus.dart';

class ReferralsController extends GetxController {
  static const int NUM_REFERRALS_NEEDED_FOR_AMBASSADOR_PROGRAM = 10;
  static const String DEFAULT_REFERRAL_FIELDS = '''
      userKey
      inviteLink
      invitedUsersTotalNumber
    ''';
  final AuthService authService = Get.find();
  String? inviteLink;
  //TextEditingController customizeInvitationTextField;

  int? numSuccessfulInvitations;

  bool isLoading = true;

  double get progress =>
      numSuccessfulInvitations! / NUM_REFERRALS_NEEDED_FOR_AMBASSADOR_PROGRAM;

  get progressFractionString {
    return '${min<int>(numSuccessfulInvitations!, 10)}/$NUM_REFERRALS_NEEDED_FOR_AMBASSADOR_PROGRAM';
  }

  copy() async {
    await FlutterClipboard.copy(inviteLink!);
    showTempSuccessSnackbar(
        userFriendlyMessage: 'Success! Link is now in your clipboard.');
    return;
  }

  Future<void> loadReferralData() async {
    final User? user =
        await authService.getAuthUser(requestedFields: DEFAULT_REFERRAL_FIELDS);

    if (user == null) {
      return;
    }
    inviteLink = user.inviteLink;
    numSuccessfulInvitations = user.invitedUsersTotalNumber;

    isLoading = false;
    update();
  }

  @override
  onInit() {
    //customizeInvitationTextField = TextEditingController();
    loadReferralData();
    super.onInit();
  }

  Future<void> share() async {
    await Share.share(DEFAULT_INVITATION_TEXT + inviteLink!,
        subject: DEFAULT_INVITATION_SUBJECT);
    return;
  }
}

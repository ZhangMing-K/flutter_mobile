import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide PaymentMethod;
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:iris_common/iris_common.dart';

enum DATA_SUBSCRIPTION {
  NONE,
  LOADING,
  DONE,
  CANCELED,
}

class PaymentMethodsController extends GetxController {
  final IAuthUserService authUserStore;
  final IProfileRepository profileRepository;
  final IPaymentMethodRepository paymentMethodRepository;
  final loadingPaymentInfo = false.obs;
  // final Rx<PaymentMethod?> paymentMethod = Rx<PaymentMethod?>(null);
  Rx<PaymentMethod?> paymentMethod = Rx<PaymentMethod?>(null);
  String? customerRemoteId;

  PaymentMethodsController({
    required this.authUserStore,
    required this.profileRepository,
    required this.paymentMethodRepository,
  });

  String get paymentMethodPreview {
    return paymentMethod.value?.previewText ?? '';
  }

  Future<bool> confirmIntent(String clientSecret, BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (err) {
      debugPrint(err.toString());
      return false;
    }
  }

  Future<void> initSetupIntent(
      String clientSecret, BuildContext context) async {
    final bool testEnv = ENV.STRIPE_TEST_ENV!.parseBool();
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        applePay: true,
        googlePay: true,
        style: Get.isPlatformDarkMode ? ThemeMode.dark : ThemeMode.light,
        testEnv: testEnv,
        merchantCountryCode: StripeConfig.COUNTRY_CODE,
        merchantDisplayName: StripeConfig.MERCHANT_NAME,
        customerId: customerRemoteId,
        setupIntentClientSecret: clientSecret,
      ),
    );
  }

  loadPaymentInfo() {
    loadingPaymentInfo.value = true;
    return profileRepository.getUserByKey(
      userKey: authUserStore.loggedUser!.userKey!,
      queryType: QueryType.loadRemote,
      userGql: userPaymentGql,
      callback: onLoadPaymentInfoSuccess,
      onError: onError,
    );
  }

  onError(OperationException error) {
    debugPrint(error.toString());
    loadingPaymentInfo.value = false;
  }

  @override
  void onInit() {
    loadPaymentInfo();
    super.onInit();
  }

  void onLoadPaymentInfoSuccess(data) {
    final users = data?['usersGet']?['users'];
    if (users != null && users.isNotEmpty) {
      final User user = User.fromJson(users[0]);
      paymentMethod.value = user.defaultPaymentMethod;
      customerRemoteId = user.customerRemoteId;
    }
    loadingPaymentInfo.value = false;
  }

  onUpdatePaymentMethodError(err) {}

  void updatePaymentMethod(BuildContext context) async {
    loadingPaymentInfo.value = true;
    final data = await paymentMethodRepository.paymentMethodSetup(
        userKey: authUserStore.loggedUser!.userKey!,
        onError: onUpdatePaymentMethodError);

    if (data != null) {
      final String? clientSecret = data.clientSecret;
      customerRemoteId = data.user?.customerRemoteId;

      if (customerRemoteId != null && clientSecret != null) {
        await initSetupIntent(clientSecret, context);

        final confirmed = await confirmIntent(clientSecret, context);
        if (confirmed) {
          loadPaymentInfo();
        } else {
          loadingPaymentInfo.value = false;
        }
        if (confirmed) {
          IrisSnackbar.trigger(
              title: 'Success', body: 'Your payment method was changed');
        }
      } else {
        loadingPaymentInfo.value = false;
      }
    }
  }
}

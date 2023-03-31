import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/institution/classes/connect_institution_arts.dart';
import 'package:iris_mobile/app/modules/iris_gold/widgets/iris_gold_dialog.dart';
import 'package:iris_mobile/app/routes/pages.dart';

class IrisGoldSettingsController extends GetxController {
  final IIrisGoldRepository irisGoldRepository;
  final IPurchaseItemRepository purchaseItemRepository;
  final IAuthUserService authUserStore;
  final IProfileRepository profileRepository;
  final selectedPlanType = PURCHASE_ITEM_PRICE_INTERVAL.MONTH.obs;
  final canShowPrice = false.obs;
  final purchaseItem = Rx<PurchaseItem?>(null);

  IrisGoldSettingsController({
    required this.irisGoldRepository,
    required this.purchaseItemRepository,
    required this.authUserStore,
    required this.profileRepository,
  });

  String get daylyPrice {
    return purchaseItem.value?.dayPurchaseItemPrice?.price.formatCurrency() ??
        '';
  }

  String? get getMonthlyPriceWithDiscountIfElegible {
    final discountPrice = purchaseItem
        .value?.purchaseItemPrice?.couponConnection?.price
        .formatCurrency();
    if (hasPortfolioConnected) {
      return discountPrice;
    } else {
      return null;
    }
  }

  String? get getYearlyPriceWithDiscountIfElegible {
    final discountPrice = purchaseItem
        .value?.yearPurchaseItemPrice?.couponConnection?.price
        .formatCurrency();
    if (hasPortfolioConnected) {
      return discountPrice;
    } else {
      return null;
    }
  }

  bool get hasPortfolioConnected {
    return monthlyPurchaseItemPrice
            ?.couponConnection?.isAuthUserCouponEligible ==
        true;
  }

  String get monthlyPrice {
    return monthlyPurchaseItemPrice?.price.formatCurrency() ?? '';
  }

  PurchaseItemPrice? get monthlyPurchaseItemPrice {
    return purchaseItem.value?.purchaseItemPrice;
  }

  String get price {
    final finalPrice = getMonthlyPriceWithDiscountIfElegible ?? monthlyPrice;
    return 'Starting at $finalPrice/mo';
  }

  String get threeMonthPrice {
    return purchaseItem.value?.threeMonthPurchaseItemPrice?.price
            .formatCurrency() ??
        '';
  }

  String get yearlyPrice {
    return yearlyPurchaseItemPrice?.price.formatCurrency() ?? '';
  }

  PurchaseItemPrice? get yearlyPurchaseItemPrice {
    return purchaseItem.value?.yearPurchaseItemPrice;
  }

  Future<bool> confirmPayment(
      String paymentSecret, BuildContext context) async {
    // final params = PresentPaymentSheetParameters(
    //     clientSecret: paymentSecret, confirmPayment: true);
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (err) {
      debugPrint(err.toString());
      return false;
    }
  }

  Future<void> connectYourPortfolio() async {
    canShowPrice.value = false;
    var args = ConnectInstitutionArgs(from: INSTITUTION_CONNECTED_FROM.PROFILE);
    Get.offAndToNamed(Paths.InstitutionConnectLanding, arguments: args);
  }

  Future<void> initPaymentSheet(String customerRemoteId, String paymentSecret,
      BuildContext context) async {
    final bool testEnv = ENV.STRIPE_TEST_ENV!.parseBool();
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        applePay: true,
        googlePay: true,
        style: ThemeMode.dark,
        testEnv: testEnv,
        merchantCountryCode: StripeConfig.COUNTRY_CODE,
        merchantDisplayName: StripeConfig.MERCHANT_NAME,
        customerId: customerRemoteId,
        paymentIntentClientSecret: paymentSecret,
      ),
    );
  }

  void onError(errMessage) {
    if (Get.isDialogOpen == true) Get.back();
    Get.dialog(IrisDialog(
        title: 'Whoops', onConfirm: () => Get.back(), subtitle: errMessage));
  }

  @override
  void onInit() {
    irisGoldRepository.irisGoldGet(
      callback: onSuccess,
      onError: (_) {
        debugPrint(_.toString());
      },
    );
    super.onInit();
  }

  void onPaymentDone() {
    Get.toNamed(Paths.AnalyticsMenu);
    Get.dialog(const IrisGoldDialog());
  }

  void onSubscribeClicked(BuildContext context) async {
    // Get.toNamed(Paths.IrisGoldSettingsLoading);
    final int? purchaseItemPriceKey =
        selectedPlanType.value == PURCHASE_ITEM_PRICE_INTERVAL.MONTH
            ? monthlyPurchaseItemPrice?.purchaseItemPriceKey
            : selectedPlanType.value == PURCHASE_ITEM_PRICE_INTERVAL.YEAR
                ? yearlyPurchaseItemPrice?.purchaseItemPriceKey
                : null;

    if (purchaseItemPriceKey == null) {
      return;
    }

    final UserSubscription? subscription = await overlayLoader(
      context: Get.overlayContext!,
      asyncFunction: () async {
        final List<int?> purchaseItemPriceKeys = [purchaseItemPriceKey];
        final PurchaseItemCheckoutResponse? data =
            await purchaseItemRepository.purchaseItemCheckout(
                autoRenew: true,
                purchaseItemPriceKeys: purchaseItemPriceKeys,
                onError: onError);

        if (data != null) {
          final String? customerRemoteId = data.user?.customerRemoteId;
          final String? paymentSecret =
              data.subscription?.latestPaymentTransaction?.paymentSecret;

          if (data.subscription?.status != SUBSCRIPTION_STATUS.ACTIVE) {
            if (customerRemoteId != null && paymentSecret != null) {
              await initPaymentSheet(customerRemoteId, paymentSecret, context);
            } else {
              if (customerRemoteId == null) {
                onError('Issue setting the your customerId, try again!');
              } else if (paymentSecret == null) {
                onError(
                    'Issue setting up your subscription, please try again!');
              }

              return null;
            }
          }
          return data.subscription;
        } else {
          return null;
        }
      },
      opacity: .7,
      loaderColor: Get.context!.theme.primaryColor,
    );

    if (subscription != null) {
      bool confirmed = subscription.status == SUBSCRIPTION_STATUS.ACTIVE;
      String? paymentSecret =
          subscription.latestPaymentTransaction?.paymentSecret;

      if (subscription.latestPaymentTransaction?.paymentSecret != null &&
          !confirmed) {
        confirmed = await confirmPayment(paymentSecret!, context);
      }

      if (confirmed) {
        final PurchaseItemPrice? purchaseItemPrice =
            selectedPlanType.value == PURCHASE_ITEM_PRICE_INTERVAL.MONTH
                ? monthlyPurchaseItemPrice
                : selectedPlanType.value == PURCHASE_ITEM_PRICE_INTERVAL.YEAR
                    ? yearlyPurchaseItemPrice
                    : null;

        if (purchaseItemPrice != null) {
          setAuthUserGoldConnection(
              purchaseItemPrice: purchaseItemPrice, subscription: subscription);
        }

        Future.delayed(const Duration(seconds: 1))
            .then((value) => onPaymentDone());
      }
    }
  }

  void onSuccess(IrisGoldGetResponse data) {
    final purchase = data.purchaseItem;
    if (purchase != null) {
      purchaseItem.value = purchase;
    }
    canShowPrice.value = true;
  }

  setAuthUserGoldConnection(
      {required PurchaseItemPrice purchaseItemPrice,
      required UserSubscription subscription}) {
    final discountedPrice = purchaseItemPrice.couponConnection?.price;
    final authUserIsEligible =
        purchaseItemPrice.couponConnection?.isAuthUserCouponEligible;
    final userPayingPrice =
        authUserIsEligible == true && discountedPrice != null
            ? discountedPrice
            : purchaseItemPrice.price;

    final GoldConnection goldConnection = GoldConnection(
        autoRenew: subscription.autoRenew,
        isGoldMember: true,
        purchaseItemPrice: purchaseItemPrice,
        userPayingPrice: userPayingPrice,
        interval: purchaseItemPrice.interval,
        intervalCount: purchaseItemPrice.intervalCount,
        subscription:
            subscription.copyWith(status: SUBSCRIPTION_STATUS.ACTIVE));
    User? loggedUser = authUserStore.loggedUser;
    if (loggedUser != null) {
      authUserStore
          .editUserData(loggedUser.copyWith(goldConnection: goldConnection));
    }
  }
}

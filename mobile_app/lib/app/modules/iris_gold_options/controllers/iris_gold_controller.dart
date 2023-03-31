import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/institution/classes/connect_institution_arts.dart';
import 'package:iris_mobile/app/modules/iris_gold/widgets/iris_gold_dialog.dart';
import 'package:iris_mobile/app/routes/pages.dart';

enum DATA_SUBSCRIPTION {
  NONE,
  LOADING,
  DONE,
  CANCELED,
}

class IrisGoldOptionsController extends GetxController {
  final IIrisGoldRepository irisGoldRepository;
  final IPurchaseItemRepository purchaseItemRepository;
  final IAuthUserService authUserStore;
  final IProfileRepository profileRepository;
  final selectedPlanType = PURCHASE_ITEM_PRICE_INTERVAL.MONTH.obs;
  final ISubscriptionRepository subscriptionRepository;
  final IPaymentMethodRepository paymentMethodRepository;
  final dataSubscription = DATA_SUBSCRIPTION.NONE.obs;
  final loadingPaymentInfo = false.obs;

  IrisGoldOptionsController({
    required this.irisGoldRepository,
    required this.purchaseItemRepository,
    required this.authUserStore,
    required this.profileRepository,
    required this.subscriptionRepository,
    required this.paymentMethodRepository,
  });

  String? get customerRemoteId => subscription?.user?.customerRemoteId;

  int? get daysLeft => endAt?.difference(DateTime.now()).inDays;

  DateTime? get endAt => subscription?.endAt;

  GoldConnection? get goldConnection =>
      authUserStore.loggedUser?.goldConnection;

  bool get hasPortfolioConnected {
    if (goldConnection
            ?.purchaseItemPrice?.couponConnection?.isAuthUserCouponEligible ==
        true) {
      return true;
    } else {
      return false;
    }
  }

  String get interval {
    PURCHASE_ITEM_PRICE_INTERVAL? interval =
        goldConnection?.purchaseItemPrice?.interval;
    int? intervalCount = goldConnection?.purchaseItemPrice?.intervalCount;

    if (intervalCount == null || interval == null) {
      return 'n/a';
    } else if (interval == PURCHASE_ITEM_PRICE_INTERVAL.YEAR &&
        intervalCount == 1) {
      return 'year';
    } else if (interval == PURCHASE_ITEM_PRICE_INTERVAL.MONTH &&
        intervalCount == 1) {
      return 'month';
    } else if (interval == PURCHASE_ITEM_PRICE_INTERVAL.DAY &&
        intervalCount == 1) {
      return 'day';
    }
    return 'unknown interval';
  }

  String get intervalAdjective {
    PURCHASE_ITEM_PRICE_INTERVAL? interval =
        goldConnection?.purchaseItemPrice?.interval;
    int? intervalCount = goldConnection?.purchaseItemPrice?.intervalCount;

    if (intervalCount == null || interval == null) {
      return 'n/a';
    } else if (interval == PURCHASE_ITEM_PRICE_INTERVAL.YEAR &&
        intervalCount == 1) {
      return 'yearly';
    } else if (interval == PURCHASE_ITEM_PRICE_INTERVAL.MONTH &&
        intervalCount == 1) {
      return 'monthly';
    } else if (interval == PURCHASE_ITEM_PRICE_INTERVAL.DAY &&
        intervalCount == 1) {
      return 'daily';
    }
    return 'unknown interval';
  }

  String get nextBillDate {
    return ' ${endAt?.month}/${endAt?.day}/${endAt?.year}';
  }

  String get nextPaymentString {
    PURCHASE_ITEM_PRICE_INTERVAL? interval =
        goldConnection?.purchaseItemPrice?.interval;
    int? intervalCount = goldConnection?.purchaseItemPrice?.intervalCount;

    if (intervalCount == null || interval == null) {
      return 'n/a';
    } else if (interval == PURCHASE_ITEM_PRICE_INTERVAL.YEAR &&
        intervalCount == 1) {
      return ' on $nextBillDate';
    } else if (interval == PURCHASE_ITEM_PRICE_INTERVAL.MONTH &&
        intervalCount == 1) {
      return ' on the ${endAt?.day}th';
    } else if (interval == PURCHASE_ITEM_PRICE_INTERVAL.DAY &&
        intervalCount == 1) {
      return '. Next Payment: tomorrow';
    }
    return ' on the ${endAt?.day}th';
  }

  String get nonDiscountedPrice {
    return goldConnection?.purchaseItemPrice?.price?.formatCurrency() ?? '';
  }

  String get paymentMethod {
    return goldConnection?.subscription?.paymentMethod?.previewText ?? '';
  }

  PaymentTransaction? get paymentTransaction =>
      subscription?.latestPaymentTransaction;

  String get renewalText {
    return "Your changes will take place at the end of your current subscription period and will be automatically renewed at the end of your chosen term until cancelled. Cancel anytime by managing your subscription in settings. The renewal must be cancelled within the 24-hours prior to  the end of the period at $userPayingPrice/$interval  The “beta discount rate” will not change unless the subscription is canceled.";
  }

  bool get requiresPayment => subscription == null || paymentTransaction == null
      ? false
      : subscription!.requiredPaymentAt != null &&
          paymentTransaction!.status ==
              PAYMENT_TRANSACTION_STATUS.PAYMENT_METHOD_REQUIRED;

  UserSubscription? get subscription => goldConnection?.subscription;

  String get userPayingPrice {
    return goldConnection?.userPayingPrice?.formatCurrency() ?? '';
  }

  Future<void> attachPaymentMethodToPaymentTransaction(
      BuildContext context) async {
    loadingPaymentInfo.value = true;
    if (paymentTransaction != null) {
      final String? paymentSecret = paymentTransaction?.paymentSecret;
      if (paymentSecret != null) {
        await initPaymentIntent(paymentSecret, context);
        final bool confirmed = await confirmIntent(paymentSecret, context);

        if (confirmed) {
          GoldConnection? userGoldConnection = goldConnection;
          UserSubscription? goldSubscription = subscription;
          if (goldSubscription != null && goldConnection != null) {
            goldSubscription =
                goldSubscription.copyWith(requiredPaymentAt: null);
            userGoldConnection =
                userGoldConnection?.copyWith(subscription: goldSubscription);
            setAuthUserGoldConnection(userGoldConnection);
          }
          await loadNewGoldPaymentMethod();
        }
      }
    }
    loadingPaymentInfo.value = false;
  }

  Future<void> cancelSubscription() async {
    dataSubscription(DATA_SUBSCRIPTION.LOADING);

    final subscriptionKey = goldConnection?.subscription?.subscriptionKey;

    if (subscriptionKey != null) {
      final value = await subscriptionRepository.subscriptionUpdate(
          autoRenew: false, subscriptionKey: subscriptionKey, onError: onError);

      dataSubscription(DATA_SUBSCRIPTION.CANCELED);
      if (value != null) {
        final user = authUserStore.loggedUser?.copyWith(
            goldConnection: goldConnection?.copyWith(
          subscription: goldConnection?.subscription
              ?.copyWith(autoRenew: value.autoRenew),
          autoRenew: value.autoRenew,
        ));
        if (user != null) {
          authUserStore.editUserData(user);
        }

        Get.back();
      }
    } else {
      throw 'SubscriptionKey is null';
    }
  }

  Future<bool> confirmIntent(String clientSecret, BuildContext context) async {
    // final params = PresentPaymentSheetParameters(
    //     clientSecret: clientSecret, confirmPayment: true);
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (err) {
      debugPrint(err.toString());
      return false;
    }
  }

  Future<void> connectYourPortfolio() async {
    var args = ConnectInstitutionArgs(from: INSTITUTION_CONNECTED_FROM.PROFILE);
    Get.offAndToNamed(Paths.InstitutionConnectLanding, arguments: args);
  }

  Future<void> initPaymentIntent(
      String paymentSecret, BuildContext context) async {
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

  Future<void> initSetupIntent(
      String clientSecret, BuildContext context) async {
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
        setupIntentClientSecret: clientSecret,
      ),
    );
  }

  Future<void> loadGoldConnection() {
    return profileRepository.getGoldConnection(
      userKey: authUserStore.loggedUser!.userKey!,
      queryType: QueryType.loadRemote,
      requestedFields: goldConnectionGql,
      callback: setAuthUserGoldConnection,
      onError: onError,
    );
  }

  Future<void> loadNewGoldPaymentMethod() {
    return profileRepository.getGoldConnection(
      userKey: authUserStore.loggedUser!.userKey!,
      queryType: QueryType.loadRemote,
      requestedFields: goldPaymentMethodGql,
      callback: setGoldPaymentMethod,
      onError: onError,
    );
  }

  void onError(errMessage) {
    if (Get.isDialogOpen == true) Get.back();
    Get.dialog(IrisDialog(
        title: 'Whoops', onConfirm: () => Get.back(), subtitle: errMessage));
  }

  @override
  void onInit() {
    loadGoldConnection();
    super.onInit();
  }

  void onPaymentDone() {
    Get.toNamed(Paths.AnalyticsMenu);
    Get.dialog(const IrisGoldDialog());
  }

  void setAuthUserGoldConnection(GoldConnection? data) {
    User? loggedUser = authUserStore.loggedUser;
    if (loggedUser != null) {
      authUserStore.editUserData(loggedUser.copyWith(goldConnection: data));
    }
  }

  void setGoldPaymentMethod(GoldConnection? data) {
    final newPaymentMethod = data?.subscription?.paymentMethod;
    GoldConnection userGoldConnection = goldConnection!;
    UserSubscription goldSubscription = subscription!;
    goldSubscription =
        goldSubscription.copyWith(paymentMethod: newPaymentMethod);
    userGoldConnection =
        userGoldConnection.copyWith(subscription: goldSubscription);
    setAuthUserGoldConnection(userGoldConnection);
  }

  setSubscriptionPaymentMethod(UserSubscription subscription) {
    User? loggedUser = authUserStore.loggedUser;
    if (loggedUser != null && loggedUser.goldConnection != null) {
      GoldConnection goldConnection = loggedUser.goldConnection!;
      UserSubscription? goldSubscription = goldConnection.subscription;
      if (goldSubscription != null) {
        goldSubscription = goldSubscription.copyWith(
            paymentMethod: subscription.paymentMethod,
            paymentMethodKey: subscription.paymentMethodKey);
        goldConnection =
            goldConnection.copyWith(subscription: goldSubscription);
        setAuthUserGoldConnection(goldConnection);
      }
    }
  }

  Future<void> turnOnAutoSubscription() async {
    final subscriptionKey = goldConnection?.subscription?.subscriptionKey;

    if (subscriptionKey != null) {
      dataSubscription(DATA_SUBSCRIPTION.LOADING);
      final value = await subscriptionRepository.subscriptionUpdate(
          autoRenew: true, subscriptionKey: subscriptionKey, onError: onError);

      dataSubscription(DATA_SUBSCRIPTION.DONE);
      if (value != null) {
        final user = authUserStore.loggedUser?.copyWith(
            goldConnection: goldConnection?.copyWith(
          subscription: goldConnection?.subscription
              ?.copyWith(autoRenew: value.autoRenew),
          autoRenew: value.autoRenew,
        ));
        if (user != null) {
          authUserStore.editUserData(user);
        }

        Get.back();
      }
    } else {
      throw 'SubscriptionKey is null';
    }
  }

  void updatePaymentMethod(BuildContext context) async {
    loadingPaymentInfo.value = true;
    final data = await paymentMethodRepository.paymentMethodSetup(
        userKey: authUserStore.loggedUser!.userKey!, onError: onError);

    if (data != null) {
      final String? clientSecret = data.clientSecret;

      if (customerRemoteId != null && clientSecret != null) {
        await initSetupIntent(clientSecret, context);

        final confirmed = await confirmIntent(clientSecret, context);
        if (confirmed) {
          final userKey = data.user!.userKey;
          final subscriptionKey =
              data.user?.goldConnection?.subscription?.subscriptionKey;
          if (userKey != null && subscriptionKey != null) {
            SubscriptionSetPaymentMethodToUserDefaultResponse? res =
                await paymentMethodRepository.setPaymentMethodToUserDefault(
                    userKey: userKey,
                    subscriptionKey: subscriptionKey,
                    onError: onError);

            if (res?.subscription != null) {
              setSubscriptionPaymentMethod(res!.subscription!);
            }
          }
        }
        if (confirmed) {
          IrisSnackbar.trigger(
              title: 'Success', body: 'Your payment method was changed');
        }
      } else {
        if (customerRemoteId == null) {
          onError('Issue setting the your customerId, try again!');
        } else if (clientSecret == null) {
          onError('Issue setting up your subscription, please try again!');
        }
      }
    }
    loadingPaymentInfo.value = false;
  }
}

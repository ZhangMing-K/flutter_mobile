const String goldConnectionGql = '''
  goldConnection {
    isGoldMember
    autoRenew
    subscription {
      endAt
      startAt
      user {
        customerRemoteId
        userKey
      }
      paymentMethodKey
      subscriptionKey
      subscriptionState
      userKey
      paymentMethod {
        previewText
      }
      requiredPaymentAt
      latestPaymentTransaction {
        status
        paymentSecret
      }

    }
    isGoldMember
    interval
    intervalCount
    userPayingPrice
    purchaseItemPrice {
      price
      interval
      intervalCount
      purchaseItemPriceKey
      couponConnection {
        price
        isAuthUserCouponEligible
      }
    }
  }
''';

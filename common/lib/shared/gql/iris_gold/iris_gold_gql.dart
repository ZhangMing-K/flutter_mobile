const String irisGoldGql = '''
  irisGoldGet {
    purchaseItem {
      purchaseItemKey
      profileUserKey
      profileUser {
        userKey
      }
      subscriptionType
      isSubscription
      description
      name
      remoteId
      createdAt
      updatedAt
      subscriptions {
        subscriptionKey
        userKey
        user {
          userKey
        }
        status
        latestPaymentTransaction {
          paymentTransactionKey
          userKey
          subscriptionKey
          subscription {
            subscriptionKey
            userKey
            status
            paymentMethodKey
            autoRenew
            remoteId
            startAt
            endAt
            cancelledAt
            createdAt
            updatedAt
          }
          remoteId
          paymentSecret
          purchaseItemKey
          purchaseItem {
            purchaseItemKey
            description
            name
            authUserSubscription {
              userKey
            }
            purchaseItemPrice {
              purchaseItemPriceKey
              interval
              intervalCount
              price
              purchaseItemKey
            }
            dayPurchaseItemPrice {
              purchaseItemPriceKey
              interval
              intervalCount
              price
              purchaseItemKey
            }
            threeMonthPurchaseItemPrice {
              purchaseItemPriceKey
              interval
              intervalCount
              price
              purchaseItemKey
            }
            yearPurchaseItemPrice {
              purchaseItemPriceKey
              interval
              intervalCount
              price
              purchaseItemKey
            }
          }
          paymentMethodKey
          status
          createdAt
          updatedAt
          submittedAt
          cancelledAt
          failedAt
        }
        paymentMethodKey
        autoRenew
        remoteId
        startAt
        endAt
        cancelledAt
        createdAt
        updatedAt
      }

      dayPurchaseItemPrice {
        purchaseItemPriceKey
        purchaseItemKey
        status
        name
        remoteId
        price
        couponConnection {
          price
          isAuthUserCouponEligible
        }
        interval
        intervalCount
        createdAt
        purchaseItem {
          purchaseItemKey
          description
          name
          authUserSubscription {
            userKey
          }
          purchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
          dayPurchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
          threeMonthPurchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
          yearPurchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
        }
      }
      purchaseItemPrice {
        purchaseItemPriceKey
        purchaseItemKey
        status
        name
        remoteId
        price
        couponConnection {
          price
          isAuthUserCouponEligible
        }
        interval
        intervalCount
        createdAt
        purchaseItem {
          purchaseItemKey
          description
          name
          authUserSubscription {
            userKey
          }
          purchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
          dayPurchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
          threeMonthPurchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
          yearPurchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
        }
      }

      threeMonthPurchaseItemPrice {
        purchaseItemPriceKey
        purchaseItemKey
        status
        name
        remoteId
        price
        couponConnection {
          price
          isAuthUserCouponEligible
        }
        interval
        intervalCount
        createdAt
        purchaseItem {
          purchaseItemKey
          description
          name
          authUserSubscription {
            userKey
          }
          purchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
          dayPurchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
          threeMonthPurchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
          yearPurchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
        }
      }

      yearPurchaseItemPrice {
        purchaseItemPriceKey
        purchaseItemKey
        status
        name
        remoteId
        price
        couponConnection {
          price
          isAuthUserCouponEligible
        }
        interval
        intervalCount
        createdAt
        purchaseItem {
          purchaseItemKey
          description
          name
          authUserSubscription {
            userKey
          }
          purchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
          dayPurchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
          threeMonthPurchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
          yearPurchaseItemPrice {
            purchaseItemPriceKey
            interval
            intervalCount
            price
            purchaseItemKey
          }
        }
      }
      
    }
  }
''';

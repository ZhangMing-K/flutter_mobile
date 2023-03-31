const String goldPaymentMethodGql = '''
  goldConnection {
    subscription {
      paymentMethod {
        paymentMethodKey
        previewText
        remoteId
      }
    }
  }
''';

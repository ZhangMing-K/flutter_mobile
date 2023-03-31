import 'package:iris_common/data/models/enums/seller_account_status.dart';
import 'package:iris_common/data/models/output/user_subscription.dart';
import 'package:collection/collection.dart';

class IrisProConnection {
  final bool? isIrisPro;
  final bool? isIrisProElligible;
  final SELLER_ACCOUNT_STATUS? sellerAccountStatus;
  final String? loginUrl;
  final String? onboardingUrl;
  final List<UserSubscription>? activeSubscriptions;
  const IrisProConnection(
      {this.isIrisPro,
      this.isIrisProElligible,
      this.sellerAccountStatus,
      this.loginUrl,
      this.onboardingUrl,
      this.activeSubscriptions});
  IrisProConnection copyWith(
      {bool? isIrisPro,
      bool? isIrisProElligible,
      SELLER_ACCOUNT_STATUS? sellerAccountStatus,
      String? loginUrl,
      String? onboardingUrl,
      List<UserSubscription>? activeSubscriptions}) {
    return IrisProConnection(
      isIrisPro: isIrisPro ?? this.isIrisPro,
      isIrisProElligible: isIrisProElligible ?? this.isIrisProElligible,
      sellerAccountStatus: sellerAccountStatus ?? this.sellerAccountStatus,
      loginUrl: loginUrl ?? this.loginUrl,
      onboardingUrl: onboardingUrl ?? this.onboardingUrl,
      activeSubscriptions: activeSubscriptions ?? this.activeSubscriptions,
    );
  }

  factory IrisProConnection.fromJson(Map<String, dynamic> json) {
    return IrisProConnection(
      isIrisPro: json['isIrisPro'],
      isIrisProElligible: json['isIrisProElligible'],
      sellerAccountStatus: json['sellerAccountStatus'] != null
          ? SELLER_ACCOUNT_STATUS.values.byName(json['sellerAccountStatus'])
          : null,
      loginUrl: json['loginUrl'],
      onboardingUrl: json['onboardingUrl'],
      activeSubscriptions: json['activeSubscriptions']
          ?.map<UserSubscription>((o) => UserSubscription.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['isIrisPro'] = isIrisPro;
    data['isIrisProElligible'] = isIrisProElligible;
    data['sellerAccountStatus'] = sellerAccountStatus?.name;
    data['loginUrl'] = loginUrl;
    data['onboardingUrl'] = onboardingUrl;
    data['activeSubscriptions'] =
        activeSubscriptions?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IrisProConnection &&
            (identical(other.isIrisPro, isIrisPro) ||
                const DeepCollectionEquality()
                    .equals(other.isIrisPro, isIrisPro)) &&
            (identical(other.isIrisProElligible, isIrisProElligible) ||
                const DeepCollectionEquality()
                    .equals(other.isIrisProElligible, isIrisProElligible)) &&
            (identical(other.sellerAccountStatus, sellerAccountStatus) ||
                const DeepCollectionEquality()
                    .equals(other.sellerAccountStatus, sellerAccountStatus)) &&
            (identical(other.loginUrl, loginUrl) ||
                const DeepCollectionEquality()
                    .equals(other.loginUrl, loginUrl)) &&
            (identical(other.onboardingUrl, onboardingUrl) ||
                const DeepCollectionEquality()
                    .equals(other.onboardingUrl, onboardingUrl)) &&
            (identical(other.activeSubscriptions, activeSubscriptions) ||
                const DeepCollectionEquality()
                    .equals(other.activeSubscriptions, activeSubscriptions)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(isIrisPro) ^
        const DeepCollectionEquality().hash(isIrisProElligible) ^
        const DeepCollectionEquality().hash(sellerAccountStatus) ^
        const DeepCollectionEquality().hash(loginUrl) ^
        const DeepCollectionEquality().hash(onboardingUrl) ^
        const DeepCollectionEquality().hash(activeSubscriptions);
  }

  @override
  String toString() => 'IrisProConnection(${toJson()})';
}

import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/enums/payment_method_entity_type.dart';
import 'package:collection/collection.dart';

class PaymentMethod {
  final int? paymentMethodKey;
  final int? userKey;
  final User? user;
  final int? entityKey;
  final String? remoteId;
  final PAYMENT_METHOD_ENTITY_TYPE? entityType;
  final bool? reusable;
  final String? previewText;
  final DateTime? failedAt;
  final DateTime? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const PaymentMethod(
      {this.paymentMethodKey,
      this.userKey,
      this.user,
      this.entityKey,
      this.remoteId,
      this.entityType,
      this.reusable,
      this.previewText,
      this.failedAt,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});
  PaymentMethod copyWith(
      {int? paymentMethodKey,
      int? userKey,
      User? user,
      int? entityKey,
      String? remoteId,
      PAYMENT_METHOD_ENTITY_TYPE? entityType,
      bool? reusable,
      String? previewText,
      DateTime? failedAt,
      DateTime? deletedAt,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return PaymentMethod(
      paymentMethodKey: paymentMethodKey ?? this.paymentMethodKey,
      userKey: userKey ?? this.userKey,
      user: user ?? this.user,
      entityKey: entityKey ?? this.entityKey,
      remoteId: remoteId ?? this.remoteId,
      entityType: entityType ?? this.entityType,
      reusable: reusable ?? this.reusable,
      previewText: previewText ?? this.previewText,
      failedAt: failedAt ?? this.failedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      paymentMethodKey: json['paymentMethodKey'],
      userKey: json['userKey'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      entityKey: json['entityKey'],
      remoteId: json['remoteId'],
      entityType: json['entityType'] != null
          ? PAYMENT_METHOD_ENTITY_TYPE.values.byName(json['entityType'])
          : null,
      reusable: json['reusable'],
      previewText: json['previewText'],
      failedAt:
          json['failedAt'] != null ? DateTime.parse(json['failedAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['paymentMethodKey'] = paymentMethodKey;
    data['userKey'] = userKey;
    data['user'] = user?.toJson();
    data['entityKey'] = entityKey;
    data['remoteId'] = remoteId;
    data['entityType'] = entityType?.name;
    data['reusable'] = reusable;
    data['previewText'] = previewText;
    data['failedAt'] = failedAt?.toString();
    data['deletedAt'] = deletedAt?.toString();
    data['createdAt'] = createdAt?.toString();
    data['updatedAt'] = updatedAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaymentMethod &&
            (identical(other.paymentMethodKey, paymentMethodKey) ||
                const DeepCollectionEquality()
                    .equals(other.paymentMethodKey, paymentMethodKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.entityKey, entityKey) ||
                const DeepCollectionEquality()
                    .equals(other.entityKey, entityKey)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.entityType, entityType) ||
                const DeepCollectionEquality()
                    .equals(other.entityType, entityType)) &&
            (identical(other.reusable, reusable) ||
                const DeepCollectionEquality()
                    .equals(other.reusable, reusable)) &&
            (identical(other.previewText, previewText) ||
                const DeepCollectionEquality()
                    .equals(other.previewText, previewText)) &&
            (identical(other.failedAt, failedAt) ||
                const DeepCollectionEquality()
                    .equals(other.failedAt, failedAt)) &&
            (identical(other.deletedAt, deletedAt) ||
                const DeepCollectionEquality()
                    .equals(other.deletedAt, deletedAt)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(paymentMethodKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(entityKey) ^
        const DeepCollectionEquality().hash(remoteId) ^
        const DeepCollectionEquality().hash(entityType) ^
        const DeepCollectionEquality().hash(reusable) ^
        const DeepCollectionEquality().hash(previewText) ^
        const DeepCollectionEquality().hash(failedAt) ^
        const DeepCollectionEquality().hash(deletedAt) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(updatedAt);
  }

  @override
  String toString() => 'PaymentMethod(${toJson()})';
}

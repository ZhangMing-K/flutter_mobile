import 'package:iris_common/data/models/enums/seller_account_link_type.dart';
import 'package:collection/collection.dart';

class CreateSellerAccountLinkInput {
  final int? userKey;
  final SELLER_ACCOUNT_LINK_TYPE? type;
  const CreateSellerAccountLinkInput(
      {required this.userKey, required this.type});
  CreateSellerAccountLinkInput copyWith(
      {int? userKey, SELLER_ACCOUNT_LINK_TYPE? type}) {
    return CreateSellerAccountLinkInput(
      userKey: userKey ?? this.userKey,
      type: type ?? this.type,
    );
  }

  factory CreateSellerAccountLinkInput.fromJson(Map<String, dynamic> json) {
    return CreateSellerAccountLinkInput(
      userKey: json['userKey'],
      type: json['type'] != null
          ? SELLER_ACCOUNT_LINK_TYPE.values.byName(json['type'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['userKey'] = userKey;
    data['type'] = type?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateSellerAccountLinkInput &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(type);
  }

  @override
  String toString() => 'CreateSellerAccountLinkInput(${toJson()})';
}

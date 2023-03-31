import 'package:collection/collection.dart';

class AccountsBrokerInput {
  final int? portfolioKey;
  const AccountsBrokerInput({required this.portfolioKey});
  AccountsBrokerInput copyWith({int? portfolioKey}) {
    return AccountsBrokerInput(
      portfolioKey: portfolioKey ?? this.portfolioKey,
    );
  }

  factory AccountsBrokerInput.fromJson(Map<String, dynamic> json) {
    return AccountsBrokerInput(
      portfolioKey: json['portfolioKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['portfolioKey'] = portfolioKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AccountsBrokerInput &&
            (identical(other.portfolioKey, portfolioKey) ||
                const DeepCollectionEquality()
                    .equals(other.portfolioKey, portfolioKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(portfolioKey);
  }

  @override
  String toString() => 'AccountsBrokerInput(${toJson()})';
}

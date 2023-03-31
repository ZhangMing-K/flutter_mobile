import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/integration.dart';
import 'package:collection/collection.dart';

class SocialUserIntegrationUpdateResponse {
  final User? user;
  final Integration? integration;
  const SocialUserIntegrationUpdateResponse({this.user, this.integration});
  SocialUserIntegrationUpdateResponse copyWith(
      {User? user, Integration? integration}) {
    return SocialUserIntegrationUpdateResponse(
      user: user ?? this.user,
      integration: integration ?? this.integration,
    );
  }

  factory SocialUserIntegrationUpdateResponse.fromJson(
      Map<String, dynamic> json) {
    return SocialUserIntegrationUpdateResponse(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      integration: json['integration'] != null
          ? Integration.fromJson(json['integration'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['user'] = user?.toJson();
    data['integration'] = integration?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SocialUserIntegrationUpdateResponse &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.integration, integration) ||
                const DeepCollectionEquality()
                    .equals(other.integration, integration)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(integration);
  }

  @override
  String toString() => 'SocialUserIntegrationUpdateResponse(${toJson()})';
}

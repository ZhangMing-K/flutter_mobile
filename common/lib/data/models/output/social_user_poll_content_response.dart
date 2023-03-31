import 'package:collection/collection.dart';

class SocialUserPollContentResponse {
  final bool? success;
  const SocialUserPollContentResponse({this.success});
  SocialUserPollContentResponse copyWith({bool? success}) {
    return SocialUserPollContentResponse(
      success: success ?? this.success,
    );
  }

  factory SocialUserPollContentResponse.fromJson(Map<String, dynamic> json) {
    return SocialUserPollContentResponse(
      success: json['success'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SocialUserPollContentResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(success);
  }

  @override
  String toString() => 'SocialUserPollContentResponse(${toJson()})';
}

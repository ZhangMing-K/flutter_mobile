import 'package:collection/collection.dart';

class JediBalancePortfoliosResponse {
  final bool? success;
  final String? message;
  const JediBalancePortfoliosResponse({required this.success, this.message});
  JediBalancePortfoliosResponse copyWith({bool? success, String? message}) {
    return JediBalancePortfoliosResponse(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  factory JediBalancePortfoliosResponse.fromJson(Map<String, dynamic> json) {
    return JediBalancePortfoliosResponse(
      success: json['success'],
      message: json['message'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is JediBalancePortfoliosResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality()
                    .equals(other.success, success)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(success) ^
        const DeepCollectionEquality().hash(message);
  }

  @override
  String toString() => 'JediBalancePortfoliosResponse(${toJson()})';
}

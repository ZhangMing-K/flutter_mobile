import 'package:collection/collection.dart';

class JediPortfolioOrdersSyncResponse {
  final bool? success;
  final String? message;
  const JediPortfolioOrdersSyncResponse({this.success, this.message});
  JediPortfolioOrdersSyncResponse copyWith({bool? success, String? message}) {
    return JediPortfolioOrdersSyncResponse(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  factory JediPortfolioOrdersSyncResponse.fromJson(Map<String, dynamic> json) {
    return JediPortfolioOrdersSyncResponse(
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
        (other is JediPortfolioOrdersSyncResponse &&
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
  String toString() => 'JediPortfolioOrdersSyncResponse(${toJson()})';
}

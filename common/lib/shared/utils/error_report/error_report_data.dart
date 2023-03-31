import 'dart:convert';

class ErrorReportData {
  int? userKey;
  String type;
  String error;
  ErrorReportData({
    required this.userKey,
    required this.type,
    required this.error,
  });

  ErrorReportData copyWith({
    int? userKey,
    String? type,
    String? error,
  }) {
    return ErrorReportData(
      userKey: userKey ?? this.userKey,
      type: type ?? this.type,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userKey': userKey,
      'type': type,
      'error': error,
    };
  }

  factory ErrorReportData.fromMap(Map<String, dynamic> map) {
    return ErrorReportData(
      userKey: map['userKey'],
      type: map['type'],
      error: map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorReportData.fromJson(String source) =>
      ErrorReportData.fromMap(json.decode(source));

  @override
  String toString() =>
      'ErrorReportData(userKey: $userKey, type: $type, error: $error)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ErrorReportData &&
        other.userKey == userKey &&
        other.type == type &&
        other.error == error;
  }

  @override
  int get hashCode => userKey.hashCode ^ type.hashCode ^ error.hashCode;
}

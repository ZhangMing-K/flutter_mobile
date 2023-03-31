import 'dart:convert';

class CacheConfig {
  //final Duration maxDuration;
  final int maxEntries;
  const CacheConfig({
    // required this.maxDuration,
    required this.maxEntries,
  });

  factory CacheConfig.standard() {
    return const CacheConfig(
      // maxDuration: Duration(days: 3),
      maxEntries: 20,
    );
  }

  CacheConfig copyWith({
    Duration? maxDuration,
    int? maxEntries,
  }) {
    return CacheConfig(
      // maxDuration: maxDuration ?? this.maxDuration,
      maxEntries: maxEntries ?? this.maxEntries,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'maxDuration': maxDuration.inSeconds,
      'maxEntries': maxEntries,
    };
  }

  factory CacheConfig.fromMap(Map<String, dynamic> map) {
    return CacheConfig(
      // maxDuration: Duration(seconds: map['maxDuration']),
      maxEntries: map['maxEntries'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CacheConfig.fromJson(String source) =>
      CacheConfig.fromMap(json.decode(source));

  @override
  String toString() => 'CacheConfig(maxDuration: maxEntries: $maxEntries)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CacheConfig &&
        // other.maxDuration == maxDuration &&
        other.maxEntries == maxEntries;
  }

  @override
  int get hashCode => // maxDuration.hashCode ^
      maxEntries.hashCode;
}

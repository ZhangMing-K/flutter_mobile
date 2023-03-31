import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'cache_config.dart';
import 'cache_entry.dart';

class CacheResult {
  final CacheConfig config;
  final List<CacheEntry> entry;
  CacheResult({
    CacheConfig? config,
    List<CacheEntry>? entry,
  })  : config = config ?? CacheConfig.standard(),
        entry = entry ?? <CacheEntry>[];

  CacheResult copyWith({
    CacheConfig? config,
    List<CacheEntry>? entry,
  }) {
    return CacheResult(
      config: config ?? this.config,
      entry: entry ?? this.entry,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'config': config.toMap(),
      'entry': entry.map((x) => x.toMap()).toList(),
    };
  }

  factory CacheResult.fromMap(Map<String, dynamic> map) {
    return CacheResult(
      config: CacheConfig.fromMap(map['config']),
      entry: List<CacheEntry>.from(
          map['entry']?.map((x) => CacheEntry.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CacheResult.fromJson(String source) =>
      CacheResult.fromMap(json.decode(source));

  @override
  String toString() => 'CacheResult(config: $config, entry: $entry)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CacheResult &&
        other.config == config &&
        listEquals(other.entry, entry);
  }

  @override
  int get hashCode => config.hashCode ^ entry.hashCode;
}

import 'dart:convert';

class CacheEntry {
  final String id;
  // final DateTime dateTime;
  final dynamic data;
  CacheEntry({
    required this.id,
    required this.data,
    // DateTime? dateTime,
  }); // : dateTime = dateTime ?? DateTime.now();

  CacheEntry copyWith({
    String? id,
    DateTime? dateTime,
    dynamic data,
  }) {
    return CacheEntry(
      id: id ?? this.id,
      // dateTime: dateTime ?? this.dateTime,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      //'dateTime': dateTime.millisecondsSinceEpoch,
      'data': data,
    };
  }

  factory CacheEntry.fromMap(Map<String, dynamic> map) {
    return CacheEntry(
      id: map['id'],
      // dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CacheEntry.fromJson(String source) =>
      CacheEntry.fromMap(json.decode(source));

  @override
  String toString() => 'CacheEntry(id: $id,  data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CacheEntry &&
        other.id == id &&
        // other.dateTime == dateTime &&
        other.data == data;
  }

  @override
  int get hashCode =>
      id.hashCode
      //^ dateTime.hashCode
      ^
      data.hashCode;
}

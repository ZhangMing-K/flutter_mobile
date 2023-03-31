import 'package:iris_common/data/models/enums/giff_source.dart';
import 'package:collection/collection.dart';

class Giff {
  final int? giffKey;
  final String? remoteId;
  final GIFF_SOURCE? giffSource;
  final String? url;
  final DateTime? createdAt;
  const Giff(
      {this.giffKey, this.remoteId, this.giffSource, this.url, this.createdAt});
  Giff copyWith(
      {int? giffKey,
      String? remoteId,
      GIFF_SOURCE? giffSource,
      String? url,
      DateTime? createdAt}) {
    return Giff(
      giffKey: giffKey ?? this.giffKey,
      remoteId: remoteId ?? this.remoteId,
      giffSource: giffSource ?? this.giffSource,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Giff.fromJson(Map<String, dynamic> json) {
    return Giff(
      giffKey: json['giffKey'],
      remoteId: json['remoteId'],
      giffSource: json['giffSource'] != null
          ? GIFF_SOURCE.values.byName(json['giffSource'])
          : null,
      url: json['url'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['giffKey'] = giffKey;
    data['remoteId'] = remoteId;
    data['giffSource'] = giffSource?.name;
    data['url'] = url;
    data['createdAt'] = createdAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Giff &&
            (identical(other.giffKey, giffKey) ||
                const DeepCollectionEquality()
                    .equals(other.giffKey, giffKey)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.giffSource, giffSource) ||
                const DeepCollectionEquality()
                    .equals(other.giffSource, giffSource)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(giffKey) ^
        const DeepCollectionEquality().hash(remoteId) ^
        const DeepCollectionEquality().hash(giffSource) ^
        const DeepCollectionEquality().hash(url) ^
        const DeepCollectionEquality().hash(createdAt);
  }

  @override
  String toString() => 'Giff(${toJson()})';
}

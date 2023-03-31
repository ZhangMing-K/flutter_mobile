import 'package:iris_common/data/models/enums/giff_source.dart';
import 'package:collection/collection.dart';

class TextCreateGiffInput {
  final GIFF_SOURCE? giffSource;
  final String? remoteId;
  final String? url;
  const TextCreateGiffInput(
      {required this.giffSource, required this.remoteId, required this.url});
  TextCreateGiffInput copyWith(
      {GIFF_SOURCE? giffSource, String? remoteId, String? url}) {
    return TextCreateGiffInput(
      giffSource: giffSource ?? this.giffSource,
      remoteId: remoteId ?? this.remoteId,
      url: url ?? this.url,
    );
  }

  factory TextCreateGiffInput.fromJson(Map<String, dynamic> json) {
    return TextCreateGiffInput(
      giffSource: json['giffSource'] != null
          ? GIFF_SOURCE.values.byName(json['giffSource'])
          : null,
      remoteId: json['remoteId'],
      url: json['url'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['giffSource'] = giffSource?.name;
    data['remoteId'] = remoteId;
    data['url'] = url;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TextCreateGiffInput &&
            (identical(other.giffSource, giffSource) ||
                const DeepCollectionEquality()
                    .equals(other.giffSource, giffSource)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(giffSource) ^
        const DeepCollectionEquality().hash(remoteId) ^
        const DeepCollectionEquality().hash(url);
  }

  @override
  String toString() => 'TextCreateGiffInput(${toJson()})';
}

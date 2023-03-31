import 'package:iris_common/data/models/enums/share_type.dart';
import 'package:collection/collection.dart';

class ShareCreateInput {
  final SHARE_TYPE? shareType;
  final int? entityKey;
  final bool? preview;
  final bool? showAmounts;
  final DateTime? expiresAt;
  const ShareCreateInput(
      {required this.shareType,
      required this.entityKey,
      this.preview,
      this.showAmounts,
      this.expiresAt});
  ShareCreateInput copyWith(
      {SHARE_TYPE? shareType,
      int? entityKey,
      bool? preview,
      bool? showAmounts,
      DateTime? expiresAt}) {
    return ShareCreateInput(
      shareType: shareType ?? this.shareType,
      entityKey: entityKey ?? this.entityKey,
      preview: preview ?? this.preview,
      showAmounts: showAmounts ?? this.showAmounts,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  factory ShareCreateInput.fromJson(Map<String, dynamic> json) {
    return ShareCreateInput(
      shareType: json['shareType'] != null
          ? SHARE_TYPE.values.byName(json['shareType'])
          : null,
      entityKey: json['entityKey'],
      preview: json['preview'],
      showAmounts: json['showAmounts'],
      expiresAt:
          json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['shareType'] = shareType?.name;
    data['entityKey'] = entityKey;
    data['preview'] = preview;
    data['showAmounts'] = showAmounts;
    data['expiresAt'] = expiresAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ShareCreateInput &&
            (identical(other.shareType, shareType) ||
                const DeepCollectionEquality()
                    .equals(other.shareType, shareType)) &&
            (identical(other.entityKey, entityKey) ||
                const DeepCollectionEquality()
                    .equals(other.entityKey, entityKey)) &&
            (identical(other.preview, preview) ||
                const DeepCollectionEquality()
                    .equals(other.preview, preview)) &&
            (identical(other.showAmounts, showAmounts) ||
                const DeepCollectionEquality()
                    .equals(other.showAmounts, showAmounts)) &&
            (identical(other.expiresAt, expiresAt) ||
                const DeepCollectionEquality()
                    .equals(other.expiresAt, expiresAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(shareType) ^
        const DeepCollectionEquality().hash(entityKey) ^
        const DeepCollectionEquality().hash(preview) ^
        const DeepCollectionEquality().hash(showAmounts) ^
        const DeepCollectionEquality().hash(expiresAt);
  }

  @override
  String toString() => 'ShareCreateInput(${toJson()})';
}

import 'package:iris_common/data/models/enums/file_type.dart';
import 'package:collection/collection.dart';

class FileModel {
  final int? fileKey;
  final int? userKey;
  final FILE_TYPE? fileType;
  final String? url;
  final DateTime? createdAt;
  const FileModel(
      {this.fileKey, this.userKey, this.fileType, this.url, this.createdAt});
  FileModel copyWith(
      {int? fileKey,
      int? userKey,
      FILE_TYPE? fileType,
      String? url,
      DateTime? createdAt}) {
    return FileModel(
      fileKey: fileKey ?? this.fileKey,
      userKey: userKey ?? this.userKey,
      fileType: fileType ?? this.fileType,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      fileKey: json['fileKey'],
      userKey: json['userKey'],
      fileType: json['fileType'] != null
          ? FILE_TYPE.values.byName(json['fileType'])
          : null,
      url: json['url'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['fileKey'] = fileKey;
    data['userKey'] = userKey;
    data['fileType'] = fileType?.name;
    data['url'] = url;
    data['createdAt'] = createdAt?.toString();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FileModel &&
            (identical(other.fileKey, fileKey) ||
                const DeepCollectionEquality()
                    .equals(other.fileKey, fileKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.fileType, fileType) ||
                const DeepCollectionEquality()
                    .equals(other.fileType, fileType)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(fileKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(fileType) ^
        const DeepCollectionEquality().hash(url) ^
        const DeepCollectionEquality().hash(createdAt);
  }

  @override
  String toString() => 'FileModel(${toJson()})';
}

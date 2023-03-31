import 'package:iris_common/data/models/enums/file_upload_type.dart';
import 'package:collection/collection.dart';

class FileUploadInput {
  final FILE_UPLOAD_TYPE? fileType;
  final dynamic upload;
  const FileUploadInput({required this.fileType, required this.upload});
  FileUploadInput copyWith({FILE_UPLOAD_TYPE? fileType, dynamic upload}) {
    return FileUploadInput(
      fileType: fileType ?? this.fileType,
      upload: upload ?? this.upload,
    );
  }

  factory FileUploadInput.fromJson(Map<String, dynamic> json) {
    return FileUploadInput(
      fileType: json['fileType'] != null
          ? FILE_UPLOAD_TYPE.values.byName(json['fileType'])
          : null,
      upload: json['upload'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['fileType'] = fileType?.name;
    data['upload'] = upload;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FileUploadInput &&
            (identical(other.fileType, fileType) ||
                const DeepCollectionEquality()
                    .equals(other.fileType, fileType)) &&
            (identical(other.upload, upload) ||
                const DeepCollectionEquality().equals(other.upload, upload)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(fileType) ^
        const DeepCollectionEquality().hash(upload);
  }

  @override
  String toString() => 'FileUploadInput(${toJson()})';
}

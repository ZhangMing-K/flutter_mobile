import 'package:collection/collection.dart';

class TextCreateFileUpload {
  final dynamic upload;
  final dynamic previewImage;
  const TextCreateFileUpload({required this.upload, this.previewImage});
  TextCreateFileUpload copyWith({dynamic upload, dynamic previewImage}) {
    return TextCreateFileUpload(
      upload: upload ?? this.upload,
      previewImage: previewImage ?? this.previewImage,
    );
  }

  factory TextCreateFileUpload.fromJson(Map<String, dynamic> json) {
    return TextCreateFileUpload(
      upload: json['upload'],
      previewImage: json['previewImage'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['upload'] = upload;
    data['previewImage'] = previewImage;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TextCreateFileUpload &&
            (identical(other.upload, upload) ||
                const DeepCollectionEquality().equals(other.upload, upload)) &&
            (identical(other.previewImage, previewImage) ||
                const DeepCollectionEquality()
                    .equals(other.previewImage, previewImage)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(upload) ^
        const DeepCollectionEquality().hash(previewImage);
  }

  @override
  String toString() => 'TextCreateFileUpload(${toJson()})';
}

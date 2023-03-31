import 'package:iris_common/data/models/output/user.dart';
import 'package:collection/collection.dart';

class FileUploadResponse {
  final String? url;
  final User? user;
  final bool? success;
  const FileUploadResponse({this.url, this.user, this.success});
  FileUploadResponse copyWith({String? url, User? user, bool? success}) {
    return FileUploadResponse(
      url: url ?? this.url,
      user: user ?? this.user,
      success: success ?? this.success,
    );
  }

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) {
    return FileUploadResponse(
      url: json['url'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      success: json['success'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['user'] = user?.toJson();
    data['success'] = success;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FileUploadResponse &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(url) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(success);
  }

  @override
  String toString() => 'FileUploadResponse(${toJson()})';
}

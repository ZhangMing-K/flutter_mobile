import 'package:collection/collection.dart';

class CreateSellerAccountLinkResponse {
  final String? url;
  const CreateSellerAccountLinkResponse({this.url});
  CreateSellerAccountLinkResponse copyWith({String? url}) {
    return CreateSellerAccountLinkResponse(
      url: url ?? this.url,
    );
  }

  factory CreateSellerAccountLinkResponse.fromJson(Map<String, dynamic> json) {
    return CreateSellerAccountLinkResponse(
      url: json['url'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateSellerAccountLinkResponse &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(url);
  }

  @override
  String toString() => 'CreateSellerAccountLinkResponse(${toJson()})';
}

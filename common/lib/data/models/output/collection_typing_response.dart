import 'package:collection/collection.dart';

class CollectionTypingResponse {
  final bool? success;
  const CollectionTypingResponse({this.success});
  CollectionTypingResponse copyWith({bool? success}) {
    return CollectionTypingResponse(
      success: success ?? this.success,
    );
  }

  factory CollectionTypingResponse.fromJson(Map<String, dynamic> json) {
    return CollectionTypingResponse(
      success: json['success'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionTypingResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(success);
  }

  @override
  String toString() => 'CollectionTypingResponse(${toJson()})';
}

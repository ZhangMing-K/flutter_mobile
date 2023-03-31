import 'package:collection/collection.dart';

class DiscoverPageGetInput {
  final String? nextCursor;
  const DiscoverPageGetInput({this.nextCursor});
  DiscoverPageGetInput copyWith({String? nextCursor}) {
    return DiscoverPageGetInput(
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  factory DiscoverPageGetInput.fromJson(Map<String, dynamic> json) {
    return DiscoverPageGetInput(
      nextCursor: json['nextCursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['nextCursor'] = nextCursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DiscoverPageGetInput &&
            (identical(other.nextCursor, nextCursor) ||
                const DeepCollectionEquality()
                    .equals(other.nextCursor, nextCursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(nextCursor);
  }

  @override
  String toString() => 'DiscoverPageGetInput(${toJson()})';
}

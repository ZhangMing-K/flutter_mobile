import 'package:collection/collection.dart';

class SharesGetInput {
  final List<String>? uris;
  const SharesGetInput({this.uris});
  SharesGetInput copyWith({List<String>? uris}) {
    return SharesGetInput(
      uris: uris ?? this.uris,
    );
  }

  factory SharesGetInput.fromJson(Map<String, dynamic> json) {
    return SharesGetInput(
      uris: json['uris']?.map<String>((o) => o.toString()).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['uris'] = uris;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SharesGetInput &&
            (identical(other.uris, uris) ||
                const DeepCollectionEquality().equals(other.uris, uris)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(uris);
  }

  @override
  String toString() => 'SharesGetInput(${toJson()})';
}

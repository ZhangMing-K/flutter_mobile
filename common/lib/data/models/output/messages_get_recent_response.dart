import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class MessagesGetRecentResponse {
  final List<TextModel>? messages;
  final String? nextCursor;
  final String? newCursor;
  const MessagesGetRecentResponse(
      {this.messages, this.nextCursor, this.newCursor});
  MessagesGetRecentResponse copyWith(
      {List<TextModel>? messages, String? nextCursor, String? newCursor}) {
    return MessagesGetRecentResponse(
      messages: messages ?? this.messages,
      nextCursor: nextCursor ?? this.nextCursor,
      newCursor: newCursor ?? this.newCursor,
    );
  }

  factory MessagesGetRecentResponse.fromJson(Map<String, dynamic> json) {
    return MessagesGetRecentResponse(
      messages: json['messages']
          ?.map<TextModel>((o) => TextModel.fromJson(o))
          .toList(),
      nextCursor: json['nextCursor'],
      newCursor: json['newCursor'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['messages'] = messages?.map((item) => item.toJson()).toList();
    data['nextCursor'] = nextCursor;
    data['newCursor'] = newCursor;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MessagesGetRecentResponse &&
            (identical(other.messages, messages) ||
                const DeepCollectionEquality()
                    .equals(other.messages, messages)) &&
            (identical(other.nextCursor, nextCursor) ||
                const DeepCollectionEquality()
                    .equals(other.nextCursor, nextCursor)) &&
            (identical(other.newCursor, newCursor) ||
                const DeepCollectionEquality()
                    .equals(other.newCursor, newCursor)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(messages) ^
        const DeepCollectionEquality().hash(nextCursor) ^
        const DeepCollectionEquality().hash(newCursor);
  }

  @override
  String toString() => 'MessagesGetRecentResponse(${toJson()})';
}

import 'package:iris_common/data/models/output/text_model.dart';
import 'package:iris_common/data/models/output/follow_suggestion.dart';
import 'package:iris_common/data/models/enums/feed_symbol_type.dart';
import 'package:collection/collection.dart';

class FeedItem {
  final TextModel? text;
  final FollowSuggestion? followSuggestion;
  final FEED_SYMBOL_TYPE? symbol;
  const FeedItem({this.text, this.followSuggestion, required this.symbol});
  FeedItem copyWith(
      {TextModel? text,
      FollowSuggestion? followSuggestion,
      FEED_SYMBOL_TYPE? symbol}) {
    return FeedItem(
      text: text ?? this.text,
      followSuggestion: followSuggestion ?? this.followSuggestion,
      symbol: symbol ?? this.symbol,
    );
  }

  factory FeedItem.fromJson(Map<String, dynamic> json) {
    return FeedItem(
      text: json['text'] != null ? TextModel.fromJson(json['text']) : null,
      followSuggestion: json['followSuggestion'] != null
          ? FollowSuggestion.fromJson(json['followSuggestion'])
          : null,
      symbol: json['symbol'] != null
          ? FEED_SYMBOL_TYPE.values.byName(json['symbol'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['text'] = text?.toJson();
    data['followSuggestion'] = followSuggestion?.toJson();
    data['symbol'] = symbol?.name;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FeedItem &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.followSuggestion, followSuggestion) ||
                const DeepCollectionEquality()
                    .equals(other.followSuggestion, followSuggestion)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(text) ^
        const DeepCollectionEquality().hash(followSuggestion) ^
        const DeepCollectionEquality().hash(symbol);
  }

  @override
  String toString() => 'FeedItem(${toJson()})';
}

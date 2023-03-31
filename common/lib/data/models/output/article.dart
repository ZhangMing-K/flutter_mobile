import 'package:iris_common/data/models/output/asset.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class Article {
  final int? articleKey;
  final String? headline;
  final String? source;
  final String? body;
  final String? author;
  final String? url;
  final String? summary;
  final String? relatedStockSymbols;
  final String? language;
  final bool? hasPaywall;
  final DateTime? postedAt;
  final String? imageUrl;
  final String? largeImageUrl;
  final String? thumbnailImageUrl;
  final int? assetKey;
  final Asset? asset;
  final TextModel? text;
  const Article(
      {this.articleKey,
      this.headline,
      this.source,
      this.body,
      this.author,
      this.url,
      this.summary,
      this.relatedStockSymbols,
      this.language,
      this.hasPaywall,
      this.postedAt,
      this.imageUrl,
      this.largeImageUrl,
      this.thumbnailImageUrl,
      this.assetKey,
      this.asset,
      this.text});
  Article copyWith(
      {int? articleKey,
      String? headline,
      String? source,
      String? body,
      String? author,
      String? url,
      String? summary,
      String? relatedStockSymbols,
      String? language,
      bool? hasPaywall,
      DateTime? postedAt,
      String? imageUrl,
      String? largeImageUrl,
      String? thumbnailImageUrl,
      int? assetKey,
      Asset? asset,
      TextModel? text}) {
    return Article(
      articleKey: articleKey ?? this.articleKey,
      headline: headline ?? this.headline,
      source: source ?? this.source,
      body: body ?? this.body,
      author: author ?? this.author,
      url: url ?? this.url,
      summary: summary ?? this.summary,
      relatedStockSymbols: relatedStockSymbols ?? this.relatedStockSymbols,
      language: language ?? this.language,
      hasPaywall: hasPaywall ?? this.hasPaywall,
      postedAt: postedAt ?? this.postedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      largeImageUrl: largeImageUrl ?? this.largeImageUrl,
      thumbnailImageUrl: thumbnailImageUrl ?? this.thumbnailImageUrl,
      assetKey: assetKey ?? this.assetKey,
      asset: asset ?? this.asset,
      text: text ?? this.text,
    );
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      articleKey: json['articleKey'],
      headline: json['headline'],
      source: json['source'],
      body: json['body'],
      author: json['author'],
      url: json['url'],
      summary: json['summary'],
      relatedStockSymbols: json['relatedStockSymbols'],
      language: json['language'],
      hasPaywall: json['hasPaywall'],
      postedAt:
          json['postedAt'] != null ? DateTime.parse(json['postedAt']) : null,
      imageUrl: json['imageUrl'],
      largeImageUrl: json['largeImageUrl'],
      thumbnailImageUrl: json['thumbnailImageUrl'],
      assetKey: json['assetKey'],
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      text: json['text'] != null ? TextModel.fromJson(json['text']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['articleKey'] = articleKey;
    data['headline'] = headline;
    data['source'] = source;
    data['body'] = body;
    data['author'] = author;
    data['url'] = url;
    data['summary'] = summary;
    data['relatedStockSymbols'] = relatedStockSymbols;
    data['language'] = language;
    data['hasPaywall'] = hasPaywall;
    data['postedAt'] = postedAt?.toString();
    data['imageUrl'] = imageUrl;
    data['largeImageUrl'] = largeImageUrl;
    data['thumbnailImageUrl'] = thumbnailImageUrl;
    data['assetKey'] = assetKey;
    data['asset'] = asset?.toJson();
    data['text'] = text?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Article &&
            (identical(other.articleKey, articleKey) ||
                const DeepCollectionEquality()
                    .equals(other.articleKey, articleKey)) &&
            (identical(other.headline, headline) ||
                const DeepCollectionEquality()
                    .equals(other.headline, headline)) &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.summary, summary) ||
                const DeepCollectionEquality()
                    .equals(other.summary, summary)) &&
            (identical(other.relatedStockSymbols, relatedStockSymbols) ||
                const DeepCollectionEquality()
                    .equals(other.relatedStockSymbols, relatedStockSymbols)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.hasPaywall, hasPaywall) ||
                const DeepCollectionEquality()
                    .equals(other.hasPaywall, hasPaywall)) &&
            (identical(other.postedAt, postedAt) ||
                const DeepCollectionEquality()
                    .equals(other.postedAt, postedAt)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.largeImageUrl, largeImageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.largeImageUrl, largeImageUrl)) &&
            (identical(other.thumbnailImageUrl, thumbnailImageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.thumbnailImageUrl, thumbnailImageUrl)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(articleKey) ^
        const DeepCollectionEquality().hash(headline) ^
        const DeepCollectionEquality().hash(source) ^
        const DeepCollectionEquality().hash(body) ^
        const DeepCollectionEquality().hash(author) ^
        const DeepCollectionEquality().hash(url) ^
        const DeepCollectionEquality().hash(summary) ^
        const DeepCollectionEquality().hash(relatedStockSymbols) ^
        const DeepCollectionEquality().hash(language) ^
        const DeepCollectionEquality().hash(hasPaywall) ^
        const DeepCollectionEquality().hash(postedAt) ^
        const DeepCollectionEquality().hash(imageUrl) ^
        const DeepCollectionEquality().hash(largeImageUrl) ^
        const DeepCollectionEquality().hash(thumbnailImageUrl) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(text);
  }

  @override
  String toString() => 'Article(${toJson()})';
}

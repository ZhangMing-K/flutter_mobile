import 'package:iris_common/data/models/enums/collection_event_type.dart';
import 'package:iris_common/data/models/output/collection.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/portfolio.dart';
import 'package:iris_common/data/models/output/order.dart';
import 'package:iris_common/data/models/output/reaction.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:collection/collection.dart';

class CollectionEventsResponse {
  final COLLECTION_EVENT_TYPE? eventType;
  final int? collectionKey;
  final int? userKey;
  final Collection? collection;
  final User? user;
  final Portfolio? portfolio;
  final Order? order;
  final Reaction? reaction;
  final TextModel? text;
  const CollectionEventsResponse(
      {this.eventType,
      this.collectionKey,
      this.userKey,
      this.collection,
      this.user,
      this.portfolio,
      this.order,
      this.reaction,
      this.text});
  CollectionEventsResponse copyWith(
      {COLLECTION_EVENT_TYPE? eventType,
      int? collectionKey,
      int? userKey,
      Collection? collection,
      User? user,
      Portfolio? portfolio,
      Order? order,
      Reaction? reaction,
      TextModel? text}) {
    return CollectionEventsResponse(
      eventType: eventType ?? this.eventType,
      collectionKey: collectionKey ?? this.collectionKey,
      userKey: userKey ?? this.userKey,
      collection: collection ?? this.collection,
      user: user ?? this.user,
      portfolio: portfolio ?? this.portfolio,
      order: order ?? this.order,
      reaction: reaction ?? this.reaction,
      text: text ?? this.text,
    );
  }

  factory CollectionEventsResponse.fromJson(Map<String, dynamic> json) {
    return CollectionEventsResponse(
      eventType: json['eventType'] != null
          ? COLLECTION_EVENT_TYPE.values.byName(json['eventType'])
          : null,
      collectionKey: json['collectionKey'],
      userKey: json['userKey'],
      collection: json['collection'] != null
          ? Collection.fromJson(json['collection'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
      reaction:
          json['reaction'] != null ? Reaction.fromJson(json['reaction']) : null,
      text: json['text'] != null ? TextModel.fromJson(json['text']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['eventType'] = eventType?.name;
    data['collectionKey'] = collectionKey;
    data['userKey'] = userKey;
    data['collection'] = collection?.toJson();
    data['user'] = user?.toJson();
    data['portfolio'] = portfolio?.toJson();
    data['order'] = order?.toJson();
    data['reaction'] = reaction?.toJson();
    data['text'] = text?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionEventsResponse &&
            (identical(other.eventType, eventType) ||
                const DeepCollectionEquality()
                    .equals(other.eventType, eventType)) &&
            (identical(other.collectionKey, collectionKey) ||
                const DeepCollectionEquality()
                    .equals(other.collectionKey, collectionKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.collection, collection) ||
                const DeepCollectionEquality()
                    .equals(other.collection, collection)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.portfolio, portfolio) ||
                const DeepCollectionEquality()
                    .equals(other.portfolio, portfolio)) &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)) &&
            (identical(other.reaction, reaction) ||
                const DeepCollectionEquality()
                    .equals(other.reaction, reaction)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(eventType) ^
        const DeepCollectionEquality().hash(collectionKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(collection) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(portfolio) ^
        const DeepCollectionEquality().hash(order) ^
        const DeepCollectionEquality().hash(reaction) ^
        const DeepCollectionEquality().hash(text);
  }

  @override
  String toString() => 'CollectionEventsResponse(${toJson()})';
}

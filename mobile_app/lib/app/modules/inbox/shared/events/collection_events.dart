import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

enum COLLECTION_EVENT_TYPE {
  COLLECTION_EDITED,
  COLLECTION_CREATED,
  COLLECTION_DELETED,
  TEXT_EDITED,
  TEXT_CREATED,
  TEXT_DELETED,
  USER_TYPING,
  USER_ADDED,
  USER_REMOVED,
  PORTFOLIO_ADDED,
  PORTFOLIO_REMOVED,
  ORDER_ADDED,
  REACTION_DELETED,
  REACTION_EDITED,
  REACTION_CREATED,
}

const List<COLLECTION_EVENT_TYPE> messageCollectionEvents = [
  COLLECTION_EVENT_TYPE.COLLECTION_CREATED,
  COLLECTION_EVENT_TYPE.COLLECTION_EDITED,
  COLLECTION_EVENT_TYPE.COLLECTION_DELETED,
  COLLECTION_EVENT_TYPE.TEXT_CREATED,
  COLLECTION_EVENT_TYPE.TEXT_EDITED,
  COLLECTION_EVENT_TYPE.TEXT_DELETED,
  COLLECTION_EVENT_TYPE.USER_TYPING,
  COLLECTION_EVENT_TYPE.REACTION_DELETED,
  COLLECTION_EVENT_TYPE.REACTION_EDITED,
  COLLECTION_EVENT_TYPE.REACTION_CREATED,
  COLLECTION_EVENT_TYPE.USER_ADDED,
  COLLECTION_EVENT_TYPE.USER_REMOVED,
];

extension CollectionEventTypeExt on COLLECTION_EVENT_TYPE {
  String stringify() {
    return describeEnum(this);
  }

  bool isEquals(String value) {
    return value == stringify();
  }
}

extension CollectionEventExt on String {
  COLLECTION_EVENT_TYPE? collectionTypeFromString() {
    return messageCollectionEvents
        .firstWhereOrNull((element) => element.stringify() == this);
  }

  bool isEquals(COLLECTION_EVENT_TYPE value) {
    return value.stringify() == this;
  }
}

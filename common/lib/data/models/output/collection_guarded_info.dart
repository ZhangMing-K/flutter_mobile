import 'package:iris_common/data/models/output/collection.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:iris_common/data/models/output/collection_messages_connection.dart';
import 'package:iris_common/data/models/output/collection_current_portfolios_connection.dart';
import 'package:iris_common/data/models/output/collection_pending_portfolios_connection.dart';
import 'package:iris_common/data/models/output/collection_orders_connection.dart';
import 'package:collection/collection.dart';

class CollectionGuardedInfo {
  final Collection? collection;
  final String? encryptionCode;
  final List<TextModel>? messages;
  final CollectionMessagesConnection? messagesConnection;
  final CollectionCurrentPortfoliosConnection? currentPortfoliosConnection;
  final CollectionPendingPortfoliosConnection? pendingPortfoliosConnection;
  final CollectionOrdersConnection? ordersConnection;
  const CollectionGuardedInfo(
      {this.collection,
      this.encryptionCode,
      this.messages,
      this.messagesConnection,
      this.currentPortfoliosConnection,
      this.pendingPortfoliosConnection,
      this.ordersConnection});
  CollectionGuardedInfo copyWith(
      {Collection? collection,
      String? encryptionCode,
      List<TextModel>? messages,
      CollectionMessagesConnection? messagesConnection,
      CollectionCurrentPortfoliosConnection? currentPortfoliosConnection,
      CollectionPendingPortfoliosConnection? pendingPortfoliosConnection,
      CollectionOrdersConnection? ordersConnection}) {
    return CollectionGuardedInfo(
      collection: collection ?? this.collection,
      encryptionCode: encryptionCode ?? this.encryptionCode,
      messages: messages ?? this.messages,
      messagesConnection: messagesConnection ?? this.messagesConnection,
      currentPortfoliosConnection:
          currentPortfoliosConnection ?? this.currentPortfoliosConnection,
      pendingPortfoliosConnection:
          pendingPortfoliosConnection ?? this.pendingPortfoliosConnection,
      ordersConnection: ordersConnection ?? this.ordersConnection,
    );
  }

  factory CollectionGuardedInfo.fromJson(Map<String, dynamic> json) {
    return CollectionGuardedInfo(
      collection: json['collection'] != null
          ? Collection.fromJson(json['collection'])
          : null,
      encryptionCode: json['encryptionCode'],
      messages: json['messages']
          ?.map<TextModel>((o) => TextModel.fromJson(o))
          .toList(),
      messagesConnection: json['messagesConnection'] != null
          ? CollectionMessagesConnection.fromJson(json['messagesConnection'])
          : null,
      currentPortfoliosConnection: json['currentPortfoliosConnection'] != null
          ? CollectionCurrentPortfoliosConnection.fromJson(
              json['currentPortfoliosConnection'])
          : null,
      pendingPortfoliosConnection: json['pendingPortfoliosConnection'] != null
          ? CollectionPendingPortfoliosConnection.fromJson(
              json['pendingPortfoliosConnection'])
          : null,
      ordersConnection: json['ordersConnection'] != null
          ? CollectionOrdersConnection.fromJson(json['ordersConnection'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['collection'] = collection?.toJson();
    data['encryptionCode'] = encryptionCode;
    data['messages'] = messages?.map((item) => item.toJson()).toList();
    data['messagesConnection'] = messagesConnection?.toJson();
    data['currentPortfoliosConnection'] = currentPortfoliosConnection?.toJson();
    data['pendingPortfoliosConnection'] = pendingPortfoliosConnection?.toJson();
    data['ordersConnection'] = ordersConnection?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CollectionGuardedInfo &&
            (identical(other.collection, collection) ||
                const DeepCollectionEquality()
                    .equals(other.collection, collection)) &&
            (identical(other.encryptionCode, encryptionCode) ||
                const DeepCollectionEquality()
                    .equals(other.encryptionCode, encryptionCode)) &&
            (identical(other.messages, messages) ||
                const DeepCollectionEquality()
                    .equals(other.messages, messages)) &&
            (identical(other.messagesConnection, messagesConnection) ||
                const DeepCollectionEquality()
                    .equals(other.messagesConnection, messagesConnection)) &&
            (identical(other.currentPortfoliosConnection,
                    currentPortfoliosConnection) ||
                const DeepCollectionEquality().equals(
                    other.currentPortfoliosConnection,
                    currentPortfoliosConnection)) &&
            (identical(other.pendingPortfoliosConnection,
                    pendingPortfoliosConnection) ||
                const DeepCollectionEquality().equals(
                    other.pendingPortfoliosConnection,
                    pendingPortfoliosConnection)) &&
            (identical(other.ordersConnection, ordersConnection) ||
                const DeepCollectionEquality()
                    .equals(other.ordersConnection, ordersConnection)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(collection) ^
        const DeepCollectionEquality().hash(encryptionCode) ^
        const DeepCollectionEquality().hash(messages) ^
        const DeepCollectionEquality().hash(messagesConnection) ^
        const DeepCollectionEquality().hash(currentPortfoliosConnection) ^
        const DeepCollectionEquality().hash(pendingPortfoliosConnection) ^
        const DeepCollectionEquality().hash(ordersConnection);
  }

  @override
  String toString() => 'CollectionGuardedInfo(${toJson()})';
}

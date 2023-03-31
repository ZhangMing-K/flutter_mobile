import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../providers/remote/iris_graphql_interface.dart';

class NotificationService extends GetxService {
  IGraphqlProvider iGraphqlProvider = Get.find();

  notificationsUpdate(
      {required List<int?> notificationKeys, bool? seen, bool? ignored}) async {
    if (seen == null && ignored == null) {
      throw 'Seen or Ingored must be given a value';
    }

    const document = r'''
      mutation notificationsUpdate($input: NotificationsUpdateInput!) {
        notificationsUpdate(input: $input) {
          notifications{
            notificationKey
            seenAt
            ignoredAt
          }
        }
      }
    ''';

    final dynamic variables = {
      'input': {
        'notificationKeys': notificationKeys,
        'seen': seen,
        'ignored': ignored
      }
    };

    final mutationOptions = iGraphqlProvider.createMutationOptions(
        document: document, variables: variables);
    try {
      await iGraphqlProvider.mutateWithOptions(mutationOptions);
      return true;
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  makeAllSeen() async {
    const document = r'''
      mutation{
        notificationChangeAllToSeen
      }
    ''';

    final mutationOptions =
        iGraphqlProvider.createMutationOptions(document: document);
    try {
      await iGraphqlProvider.mutateWithOptions(mutationOptions);
      return true;
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }
}

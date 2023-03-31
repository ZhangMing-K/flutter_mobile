import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';

import 'iris_exception.dart';

class IrisExceptionHandler {
  final List<GraphQLError> graphqlErrors;
  final String type;
  IrisExceptionHandler({
    required this.graphqlErrors,
    this.type = 'Post',
  });

  // void _invalidHandler() {
  //   final IAuthUserService authUserStore = Get.find();
  //   authUserStore.logout(isAutoLogout: true, description: 'invalid signature');
  // }

  // List<IrisException> parse() {
  //   final exceptions = <IrisException>[];
  //   for (final i in graphqlErrors) {
  //     if (i.toString().contains('invalid signature')) {
  //       exceptions.add(TokenExpiredException());
  //       _invalidHandler();
  //     }
  //     if (i.toString().contains('deleted')) {
  //       exceptions.add(DeletedDataException(type: type));
  //     }
  //   }
  //   return exceptions;
  // }

  // void showExceptionOf<T extends IrisException>() {
  //   final list = parse().whereType<T>();
  //   if (list.isNotEmpty) {
  //     show(list.first);
  //   }
  // }

  static void show(IrisException exception) {
    Get.snackbar(
      'Error',
      '$exception',
      colorText: Colors.red,
      shouldIconPulse: true,
      barBlur: 20,
      isDismissible: true,
      duration: const Duration(seconds: 3),
    );
  }
}

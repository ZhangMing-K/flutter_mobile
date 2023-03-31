import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../providers/remote/iris_graphql_interface.dart';

class StorageService extends GetxService {
  StorageService();
  IGraphqlProvider iGraphqlProvider = Get.find();

  Future<String?> fileUpload({required http.MultipartFile file}) async {
    const document = r'''
    mutation fileUpload($upload: Upload!){
      fileUpload(input:{fileType:PROFILE_PICTURE, upload: $upload}){
        url
        user{
          profilePictureUrl
        }
      }
    }
    ''';
    final variables = {'upload': file};
    final options = iGraphqlProvider.createMutationOptions(
        document: document, variables: variables);
    try {
      final res = await iGraphqlProvider.mutateWithOptions(options);
      return res.data!['fileUpload']['url'];
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }
}

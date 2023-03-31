import 'dart:async';

import 'package:get/get.dart';

import '../../iris_common.dart';

class AssetService extends GetxService {
  IGraphqlProvider iGraphqlProvider = Get.find();

  Future<List<Asset>> assetSearch(
      {String? partialSymbol,
      String? searchValue,
      int? offset,
      int limit = 10,
      List<int?>? assetKeys,
      String? requestedFields}) async {
    const defaultFields = '''
      assetKey
      symbol  
      name
      pictureUrl
      quote{
        changePercent
        extendedChange
        latestPrice
      }
    ''';

    requestedFields ??= defaultFields;

    var document = '''
      query assetSearch(\$input: AssetSearchInput) 
    ''';
    document += '''
    {
        assetSearch(input: \$input) {
          assets{
            $requestedFields
          }
        }
      }
    ''';

    final input = {'limit': limit, 'offset': offset, 'assetKeys': assetKeys};
    if (partialSymbol != null) {
      input['partialSymbol'] = partialSymbol;
    }
    if (searchValue != null) {
      input['searchValue'] = searchValue;
    }
    final queryOptions = iGraphqlProvider.createQueryOptions(
      document: document,
      variables: {'input': input},
    );
    final res = await iGraphqlProvider
        .queryWithOptions(queryOptions)
        .catchError((e) {});
    final data = res?.data;
    if (data == null) return <Asset>[];
    final assetListData = data['assetSearch']['assets'];
    final List<Asset> assetList =
        List<Asset>.from(assetListData.map((i) => Asset.fromJson(i)));
    return assetList;
  }
}

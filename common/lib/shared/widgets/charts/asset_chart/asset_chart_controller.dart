import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class AssetChartController extends GetxController {
  final int assetKey;
  Rx<Asset?> asset$ = Rx<Asset?>(null);

  Rx<API_STATUS> apiStatus$ = Rx(API_STATUS.NOT_STARTED);
  final AssetService assetService = Get.find();
  String historicalResponseFragment = '''
    span
    returnAmount
    returnPercentage
    openAmount
    closeAmount
    historicalType
    points{
      beginsAt
      openAmount
      closeAmount
      spanReturnAmount
      spanReturnPercentage
      volume
    }
  ''';

  AssetChartController({required this.assetKey});

  assetSearch() async {
    asset$.value = null;
    apiStatus$.value = API_STATUS.PENDING;
    final List<Asset> assets = await assetService.assetSearch(
        assetKeys: [assetKey], requestedFields: getRequestedFields());
    asset$.value = assets[0];
    apiStatus$.value = API_STATUS.FINISHED;
  }

  getHistorical({required HISTORICAL_SPAN span}) async {
    final assets = await assetService
        .assetSearch(assetKeys: [assetKey], requestedFields: '''
          historical : historical(input:{span:${describeEnum(span)}}){
          $historicalResponseFragment
        }
        ''');
    return assets[0].historical;
  }

  String getRequestedFields() {
    return '''
      assetKey
      symbol
      pictureUrl
      name
      currentPrice
      ceo{
        displayName
        personPictureUrl
      }
      orders(input:{authUser: true}){
        orderKey
        symbol
        orderSide
        optionType
        positionType
        averagePrice
        placedAt
        fullfilledAt
      }
      assetStat{
        putCallRatio
        peRatio
        numberEmployees
        nextDividendRate
        marketCap
        ttmDividendRate
        ttmEPS
        beta
        maxChangePercent
        profitMargin
        revenuePerShare
        totalCash
        currentDebt
        revenue
        grossProfit
        ebitda
        revenuePerShare
        dividendYield
      }
      dayHistorical : historical(input:{span:DAY}){
        $historicalResponseFragment
      }
      irisAssetOutlook {
        bullish
        bearish
      }
  ''';
  }

  @override
  onReady() async {
    await assetSearch();
    super.onReady();
  }
}

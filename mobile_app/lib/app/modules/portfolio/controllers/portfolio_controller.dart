import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/pages.dart';
import '../modules/orders/controllers/orders_controller.dart';
import '../modules/position/controllers/position_controller.dart';

class PortfolioController extends FullLifeCycleController {
  // final OverviewController overviewController;
  final PositionController positionController;
  final PortfolioOrdersController ordersController;
  final IPortfolioRepository repository;
  final IAuthUserService authUserStore;
  final PortfolioService? portfolioService;
  final IrisEvent irisEvent;
  final ScrollController scrollController = ScrollController();
  ISecureStorage secureStorage = Get.find();
  Rx<API_STATUS> apiStatus$ = API_STATUS.NOT_STARTED.obs;

  Rx<Portfolio?> portfolio$ = Rx<Portfolio?>(null);
  int? portfolioKey;
  late StreamSubscription _routeListener;

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
      beginsAt
      buyVolume
      sellVolume
    }
  ''';

  PortfolioController({
    //  required this.overviewController,
    required this.positionController,
    required this.ordersController,
    required this.repository,
    required this.authUserStore,
    required this.irisEvent,
    this.portfolioService,
  });

  // @override
  // void onReady() {}

  getHistorical({required HISTORICAL_SPAN span}) async {
    final portfolio = await portfolioService!.portfolioGet(
        portfolioKey: portfolio$.value!.portfolioKey, requestedFields: '''
        portfolios{
          brokerConnection {
            historicalV2 : historicalV2(input:{span:${describeEnum(span)}}){
              $historicalResponseFragment
            }
          }
        }
      ''');
    return portfolio.brokerConnection?.historicalV2;
  }

  void init() {
    portfolioGet();
    irisEvent.add(
        eventType: EVENT_TYPE.VIEW_PORTFOLIO_FULL,
        entityType: EVENT_ENTITY_TYPE.PORTFOLIO,
        entityKey: portfolioKey);
  }

  initializePortfolios() {
    portfolio$.value = null;
    positionController.portfolio$.value = null;
    ordersController.portfolio$.value = null;
    // overviewController.portfolio$.value = null;
  }

  @override
  void onClose() {
    _routeListener.cancel();
    debugPrint('on close portfolio page');
  }

  @override
  onInit() {
    if (Get.parameters['portfolioKey'] != null &&
        Get.parameters['portfolioKey'] != '') {
      portfolioKey = int.parse(Get.parameters['portfolioKey']!);
    }
    init();
    // when navigating to other page without `back` button press,
    // it does not close the current screen
    _routeListener = IrisStackObserver.stackChange.listen((stackChange) {
      if (stackChange.newRoute == null) {
        return;
      }
      final stackName = stackChange.newRoute?.settings.name;
      if (stackName == null) {
        debugPrint('stack name is null');
        return;
      }
      final names = stackName.split('/');
      if (names[1] == 'portfolio' && stackChange.oldRoute is GetPageRoute) {
        portfolioKey = int.parse(names[2]);
        ordersController.offset = 0;
        initializePortfolios();
        init();
      }
    });
    super.onInit();
  }

  Future<Portfolio?> portfolioFetchFromApi({required int? portfolioKey}) async {
    //this is separated from service to get access to graphql error why getting the userKey of the portfolio from the api
    List<String> fragments;
    fragments = [
      portfolioService!.portfolioResponseFragment,
      portfolioService!.historicalSpanResponseFragment
    ];
    const requestedFields = '...portfolioResponseFragment';
    const document = '''
      query portfoliosGet(\$input: PortfoliosGetInput) {
        portfoliosGet(input: \$input) {
          $requestedFields
        }
      }
    ''';
    return repository
        .getPortfolio(
            portfolioKey: portfolioKey,
            document: document,
            fragments: fragments)
        .remote;
  }

  portfolioGet() async {
    apiStatus$.value = API_STATUS.PENDING;

    final unsorrtedPortfolio =
        await portfolioFetchFromApi(portfolioKey: portfolioKey);
    if (unsorrtedPortfolio?.brokerConnection?.positions != null) {
      unsorrtedPortfolio!.brokerConnection!.positions!.sort((a, b) {
        final apercent = a.percentOfPortfolio ?? 0;
        final bpercent = b.percentOfPortfolio ?? 0;
        return bpercent.compareTo(apercent);
      });
    }
    portfolio$.value = unsorrtedPortfolio;
    positionController.portfolio$.value = unsorrtedPortfolio;
    ordersController.portfolio$.value = unsorrtedPortfolio;
    // overviewController.portfolio$.value = unsorrtedPortfolio;
    apiStatus$.value = API_STATUS.FINISHED;
  }

  reconnect() async {
    final portfolio = portfolio$.value!;
    Get.toNamed(Paths.ConnectInstitution.createPath([
      describeEnum(portfolio.brokerName!),
      portfolio.portfolioKey,
    ]));
  }

  void scrollToTop() {
    positionController.listviewController.currentState!.scrollToTop();
  }
}

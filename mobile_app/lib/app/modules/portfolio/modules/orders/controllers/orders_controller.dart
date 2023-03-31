import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class PortfolioOrdersController extends GetxController
    with StateMixin<List<TextModel?>> {
  PortfolioOrdersController(
      {required this.repository, this.portfolioService, this.textService});
  final IPortfolioRepository repository;
  final PortfolioService? portfolioService;
  final TextService? textService;

  final scrollController = ScrollController();
  final listviewController = GlobalKey<IrisListViewState>();

  int offset = 0;
  Rx<Portfolio?> portfolio$ = Rx<Portfolio?>(null);

  ///The [getResponse] method receives a callback that is called whenever it has new data.
  ///It first searches the internal storage, and only then searches the server.
  ///If the result is exactly the same, it will only call the callback the first time (from the cache).
  @override
  void onInit() {
    super.onInit();
  }

  init() async {
    if (offset == 0) {
      change([], status: RxStatus.loading());
      final list = await getOrders();
      rebuildOnChange(list);
    }
  }

  void rebuildOnChange(List<TextModel?> data) {
    change(textService!.groupOptionStrategies(data),
        status: RxStatus.success());
  }

  orderRequestedFields({required int offset}) {
    return '''
        portfolios{
          portfolioKey
          brokerName
          orders(input: {limit: 10, offset: $offset}){
            orderKey
            symbol
            asset{
              assetKey
              symbol
              name
              currentPrice
              pictureUrl
            }
            averagePrice
            positionType
            optionType
            orderSide
            strikePrice
            expirationDate
            averageBuyPrice
            averageSellPrice
            orderGroupUUID
            optionLegGroupId
            profitLoss
            profitLossPercent
            positionEffect
            orderStrategy
            strategyType
            closedAt
            openedAt
            placedAt
            fullfilledAt
            text{
              textKey
              value
              parentKey
              textType
              orderedCreatedAt
              featuredAt
              reactions(input: {limit:1}){
                user{
                  userKey
                  firstName
                  lastName
                  profilePictureUrl
                  avatar {
                    avatarKey
                    avatarName
                    code
                    url
                  }
                }
              }
              authUserReaction{
                user{
                  userKey
                  firstName
                  lastName
                }
              }
              numberOfReactions
              numberOfComments
              comments(input:{limit:1,offset:0}){
                textKey
                value
                user{
                  userKey
                  firstName
                  lastName
                  profilePictureUrl
                  avatar {
                    avatarKey
                    avatarName
                    code
                    url
                  }
                }
                authUserReaction{
                  user{
                    userKey
                    firstName
                    lastName
                  }
                }
              }
            }
          }
        }
      ''';
  }

  Future<List<TextModel?>> getOrders() async {
    final portfolio = await portfolioService!.portfolioGet(
        portfolioKey: portfolio$.value!.portfolioKey,
        requestedFields: orderRequestedFields(offset: offset));

    final List<TextModel?> newOrderTexts = [];
    if (portfolio.orders == null) {
      return newOrderTexts;
    }
    for (var order in portfolio.orders!) {
      newOrderTexts.add(
          order.text!.copyWith(user: portfolio$.value!.user, order: order));
    }

    if (newOrderTexts.isNotEmpty) offset += 10;

    return newOrderTexts;
  }

  Future<void> loadMore() async {
    final data = await getOrders();
    if (data.isNotEmpty) {
      offset += 10;
    }
    final newData = textService!.groupOptionStrategies(state!..addAll(data));
    change(newData, status: RxStatus.success());
  }

  Future<void> pullRefresh() async {
    offset = 0;
    final data = await getOrders();
    if (data.isNotEmpty) {
      offset += 10;
    }
    rebuildOnChange(data);
  }
}

extension Rep<E> on List<E> {
  bool replaceWhere(TestPredicate<E> test, E replacement) {
    var found = false;
    final len = length;
    for (var i = 0; i < len; i++) {
      if (test(this[i])) {
        this[i] = replacement;
        found = true;
      }
    }

    return found;
  }
}

typedef TestPredicate<E> = bool Function(E element);

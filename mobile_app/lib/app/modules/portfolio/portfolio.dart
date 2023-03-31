import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'controllers/portfolio_controller.dart';
import 'modules/orders/views/orders_view.dart';
import 'modules/position/views/position_view.dart';

const List<CONNECTION_STATUS> notConnectedStatuses = [
  CONNECTION_STATUS.DISCONNECTED,
  CONNECTION_STATUS.NEVER_CONNECTED,
];

class PortfolioScreen extends GetView<PortfolioController> {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: IrisTabView.expanded(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            showBackButton: true,
            horizontalPadding: 0,
            tabs: [
              IrisTab(
                  text: 'Portfolio',
                  body: NestedScrollView(
                    controller: controller.scrollController,
                    headerSliverBuilder: (context, _) {
                      return [
                        SliverOverlapAbsorber(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                          sliver: SliverToBoxAdapter(child: Obx(() {
                            return Container(
                                color: context.theme.scaffoldBackgroundColor,
                                child: Column(children: [chart()]));
                          })),
                        ),
                      ];
                    },
                    body: main(),
                  ))
            ]));
  }

  Widget chart() {
    if (controller.portfolio$.value == null ||
        notConnectedStatuses
            .contains(controller.portfolio$.value?.connectionStatus)) {
      return Container();
    } else {
      final p = controller.portfolio$.value!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppChart(
            tag: 'portfolio-${controller.portfolioKey}',
            historicalFunction: controller.getHistorical,
            yAxisType: Y_AXIS_TYPE.PERCENT,
            leading: ProfileImage(
              url: p.user!.profilePictureUrl,
              radius: 30,
              uuid: uuid.v4(),
            ),
            title: UserName(
              user: p.user,
              fontSize: 22,
            ),
            subtitle: Text(
              p.portfolioName!,
              style: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            chartData:
                ChartData(dayHistorical: p.brokerConnection?.dayHistorical),
          )
        ],
      );
    }
  }

  Widget main() {
    return Obx(() {
      final Portfolio? portfolio = controller.portfolio$.value;

      Widget view = Container();
      if (portfolio == null &&
          controller.apiStatus$.value == API_STATUS.PENDING) {
        view = const HistoricalChartShimmer();
      } else if (notConnectedStatuses.contains(portfolio?.connectionStatus) &&
          !portfolio!.isAuthUser) {
        const String text = 'Portfolio temporarily unavailable';
        view = const NoData(text: text);
      } else if (notConnectedStatuses.contains(portfolio?.connectionStatus) &&
          portfolio!.isAuthUser) {
        view = reconnectView();
      } else if (portfolio != null) {
        return Builder(
          builder: (context) => IrisTabView(
            onTabChange: (index) async {
              if (index == 1) {
                await controller.ordersController.init();
              }
            },
            tabs: const [
              IrisTab(text: 'Positions', body: PositionView()),
              IrisTab(text: 'Orders', body: OrdersView()),
            ],
            initialIndex: 0,
            indicatorColor: context.theme.colorScheme.secondary.withOpacity(.8),
          ),
        );
      }
      return ListView.builder(
          itemCount: 1,
          primary: false,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return view;
          });
    });
  }

  Widget reconnectButton() {
    return SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          child: const Text('Reconnect portfolio',
              style: TextStyle(
                fontSize: 20,
                color: IrisColor.accentColorDark,
              )),
          onPressed: controller.reconnect,
        ));
  }

  Widget reconnectView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Portfolio Disconnected',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
              'Your portfolio has been disconnected. This can be because you have 2 factor authentication setup and the connection expired, you changed your password, or our connection has expired. Please reconnect to see your data.',
              style: TextStyle(fontSize: 16)),
          const SizedBox(
            height: 30,
          ),
          reconnectButton()
        ],
      ),
    );
  }
}

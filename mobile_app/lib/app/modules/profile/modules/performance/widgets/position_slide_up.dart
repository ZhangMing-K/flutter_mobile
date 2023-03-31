import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'metric_display.dart';

class PositionSlideUp extends StatelessWidget {
  const PositionSlideUp({
    Key? key,
    required this.positionSummary,
    required this.firstName,
  }) : super(key: key);
  final PositionsSummaryItem positionSummary;
  final String firstName;

  Widget _positionItem({required String title, required String subtitle}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xff9e9e9e),
            fontSize: 12,
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _position(IrisPosition position) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xff5e5e5e),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      position.positionType!.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Opened ${position.openedAt!.formatMonthDayYear()}",
                          style: const TextStyle(
                            color: Color(0xff9e9e9e),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MetricDisplay(
                      label: 'Today',
                      percent:
                          position.relativeMetrics?.todayProfitLossPercent ?? 0,
                      labelSize: 12,
                      percentSize: 14,
                    ),
                    const SizedBox(width: 8),
                    MetricDisplay(
                      label: 'Total',
                      percent:
                          position.relativeMetrics?.totalProfitLossPercent ?? 0,
                      labelSize: 14,
                      percentSize: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.withOpacity(.3),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _positionItem(
                  title: '% portfolio',
                  subtitle: position.relativeMetrics!.portfolioAllocation!
                      .formatPercentage(),
                ),
                const SizedBox(width: 12),
                _positionItem(
                  title: 'Trades',
                  subtitle: position.totalTransactionCount.toString(),
                ),
                const SizedBox(width: 12),
                _positionItem(
                  title: 'Avg buy price',
                  subtitle: position.averageBuyPrice!.formatCurrency(),
                ),
                const SizedBox(width: 12),
                _positionItem(
                  title: 'Current price',
                  subtitle:
                      positionSummary.asset!.currentPrice.formatCurrency(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Text(
              '$firstName and ${positionSummary.asset?.symbol}',
              style: const TextStyle(
                fontSize: 16,
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Positions",
                      style: TextStyle(
                        color: Color(0xff9e9e9e),
                        fontSize: 14,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: 414,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.theme.colorScheme.secondary
                            .withOpacity(.03),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 54,
                                      height: 54,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: AppAssetImage(
                                        asset: positionSummary.asset,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          positionSummary.symbol ?? '',
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          width: context.width / 2,
                                          child: Text(
                                            positionSummary.asset?.name ?? '',
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: Color(0xff9e9e9e),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ...positionSummary.positions!
                              .map(
                                (position) => _position(position),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Container(
              //   width: 414,
              //   padding: const EdgeInsets.only(
              //     right: 16,
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: const [
              //       Text(
              //         "Report bad data",
              //         style: TextStyle(
              //           color: Color(0xff7a7a7a),
              //           fontSize: 16,
              //           fontFamily: "Inter",
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
          // const SizedBox(height: 32),
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Container(
          //       width: 414,
          //       padding: const EdgeInsets.only(
          //         left: 16,
          //       ),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: const [
          //           Text(
          //             "Feed",
          //             style: TextStyle(
          //               color: Color(0xff9e9e9e),
          //               fontSize: 14,
          //               fontFamily: "Inter",
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     const SizedBox(height: 24),
          //     Container(
          //       width: 414,
          //       padding: const EdgeInsets.only(
          //         left: 16,
          //       ),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             mainAxisSize: MainAxisSize.min,
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Container(
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(20),
          //                   border: Border.all(
          //                     color: const Color(0xff9e9e9e),
          //                     width: 1,
          //                   ),
          //                 ),
          //                 padding: const EdgeInsets.symmetric(
          //                   horizontal: 12,
          //                   vertical: 8,
          //                 ),
          //                 child: Row(
          //                   mainAxisSize: MainAxisSize.min,
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     Container(
          //                       width: 16,
          //                       height: 16,
          //                       decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(8),
          //                       ),
          //                       child: const FlutterLogo(size: 16),
          //                     ),
          //                     const SizedBox(width: 4),
          //                     const Text(
          //                       "Orders (12)",
          //                       style: TextStyle(
          //                         color: Color(0xfff5f6fa),
          //                         fontSize: 15,
          //                         fontFamily: "Inter",
          //                         fontWeight: FontWeight.w500,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //           const SizedBox(width: 8),
          //           Row(
          //             mainAxisSize: MainAxisSize.min,
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Container(
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(20),
          //                   color: const Color(0xff333333),
          //                 ),
          //                 padding: const EdgeInsets.symmetric(
          //                   horizontal: 12,
          //                   vertical: 8,
          //                 ),
          //                 child: Row(
          //                   mainAxisSize: MainAxisSize.min,
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     Container(
          //                       width: 16,
          //                       height: 16,
          //                       decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(8),
          //                       ),
          //                       child: const FlutterLogo(size: 16),
          //                     ),
          //                     const SizedBox(width: 4),
          //                     const Text(
          //                       "Posts (2)",
          //                       style: TextStyle(
          //                         color: Color(0xfff5f6fa),
          //                         fontSize: 15,
          //                         fontFamily: "Inter",
          //                         fontWeight: FontWeight.w500,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     const SizedBox(height: 24),
          // ],
          //),
        ],
      ),
    );
  }
}

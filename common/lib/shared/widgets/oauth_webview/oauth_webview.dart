import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../iris_common.dart';

class OauthWebViewContainer extends StatelessWidget {
  final String url;

  final BROKER_NAME? brokerName;
  final bool clearCache;
  final SOCIAL_SOURCE? socialSource;
  final _key = UniqueKey();
  final Completer _controller = Completer();

  OauthWebViewContainer(
      {Key? key,
      required this.url,
      this.brokerName,
      this.socialSource,
      this.clearCache = false})
      : super(key: key);

  String get getTitle {
    if (brokerName != null) return getBrokerTitle();

    if (socialSource != null) return getSocialSourceTitle();

    return 'Not Implemented';
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OauthWebviewController>(
      init: OauthWebviewController(
          url: url, brokerName: brokerName, socialSource: socialSource),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: context.theme.appBarTheme.backgroundColor,
              title: Text(getTitle)),
          body: Column(
            children: [
              Expanded(
                child: webView(controller),
              ),
            ],
          ),
        );
      },
    );
  }

  String getBrokerTitle() {
    switch (brokerName) {
      case BROKER_NAME.ROBINHOOD:
        return 'Robinhood';
      case BROKER_NAME.TD_AMERITRADE:
        return 'TD Ameritrade';
      case BROKER_NAME.ETRADE:
        return 'E-Trade';
      default:
        return 'Not Implemented';
    }
  }

  String getSocialSourceTitle() {
    switch (socialSource) {
      case SOCIAL_SOURCE.TWITTER:
        return 'Twitter';
      case SOCIAL_SOURCE.DISCORD:
        return 'Discord';
      default:
        return 'Not Implemented';
    }
  }

  Widget webView(OauthWebviewController controller) {
    return InAppWebView(
      key: _key,
      initialUrlRequest: URLRequest(url: controller.uri),
      onLoadStop: (InAppWebViewController c, Uri? url) async {
        final brokerRgxCode = controller.getBrokerUrlParser();

        final hasMatch = brokerName != null
            ? brokerRgxCode.hasMatch(url.toString())
            : socialSource != null
                ? controller.socialHasMatch(url.toString())
                : false;

        if (hasMatch) {
          final result = controller.getUrlResult(brokerRgxCode, url);
          Get.back(result: result);
        }
      },
      onWebViewCreated: (InAppWebViewController webViewController) async {
        if (clearCache) webViewController.clearCache();

        _controller.complete(webViewController);
      },
      onReceivedServerTrustAuthRequest: (controller, challenge) async {
        return ServerTrustAuthResponse(
            action: ServerTrustAuthResponseAction.PROCEED);
      },
      onLoadError: (controller, url, code, message) => debugPrint(message),
      onLoadHttpError: (controller, url, code, message) => debugPrint(message),
    );
  }
}

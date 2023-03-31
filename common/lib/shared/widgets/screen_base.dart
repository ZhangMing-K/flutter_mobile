import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:provider/provider.dart';

enum APP_BAR_TYPE {
  NONE,
  // MAIN,
  //STEP,
  BASIC,
  // SAVE,
  //PROFILE,
  //LOGO,
}

enum BOTTOM_NAVBAR_TYPE {
  NONE,
  MAIN,
}

class Pannel extends StatefulWidget {
  final Widget child;

  const Pannel({Key? key, required this.child}) : super(key: key);

  @override
  _PannelState createState() => _PannelState();
}

//TODO: REMOVE THIS CLASS
class ScreenBase extends StatelessWidget {
  final Widget child;

  final bool resizeToAvoidBottomInset;
  final BOTTOM_NAVBAR_TYPE bottomNavbarType;
  final APP_BAR_TYPE appBarType;
  final BaseController baseController = Get.find();
  final bool appBarBackButton;
  final String title;
  final Function? appBarOnCancel;
  final Function? appBarOnDone;
  final IAuthUserService authUserStore = Get.find();
  final ValueSetter<int>? onActiveMenuItemPressed;
  final Widget? bottomNavbar;
  final Widget? customAction;
  final int? collectionKey;

  ScreenBase({
    Key? key,
    required this.child,
    this.resizeToAvoidBottomInset = true,
    this.bottomNavbarType = BOTTOM_NAVBAR_TYPE.MAIN,
    this.appBarType = APP_BAR_TYPE.BASIC,
    required this.title,
    this.appBarBackButton = true,
    this.appBarOnCancel,
    this.appBarOnDone,
    this.onActiveMenuItemPressed,
    this.bottomNavbar,
    this.customAction,
    this.collectionKey,
  }) : super(key: key);

  Widget body() {
    return child;
  }

  Widget? bottomNavbarWidget() {
    Widget? aBottomNavbar;
    if (bottomNavbar != null) {
      return bottomNavbar;
    }
    if (bottomNavbarType == BOTTOM_NAVBAR_TYPE.MAIN) {
      aBottomNavbar = Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.grey.shade900, width: 0.0))),
          child: BottomNavbar(
              onActiveMenuItemPressed: onActiveMenuItemPressed,
              isGoldMode: false));
    }

    return aBottomNavbar;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.red,
        child: Pannel(
          child: Builder(builder: (context) {
            Widget? appBar;
            if (appBarType == APP_BAR_TYPE.BASIC) {
              appBar = BasicAppBar(
                title: title,
                appBarBackButton: appBarBackButton,
                customAction: customAction,
              );
            } else if (appBarType == APP_BAR_TYPE.NONE) {
              appBar = AppBar(
                elevation: 0, //this is shadow below app bar 0 gets rid of it
                backgroundColor: context.theme.appBarTheme.backgroundColor,
                iconTheme: context.theme.appBarTheme.iconTheme,
                toolbarHeight: 0,
              );
            }
            return Scaffold(
              bottomNavigationBar: bottomNavbarWidget.call(),
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              body: body(),
              // endDrawer: appBarType != APP_BAR_TYPE.STEP ? NavDrawer() : null,
              // backgroundColor: Color(0xfff5f6fa),

              appBar: appBar as PreferredSizeWidget?,
            );
          }),
        ));
  }
}

class _PannelState extends State<Pannel> {
  BaseController baseController = Get.find();
  PanelController panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => panelController,
      child: SlidingUpPanel(
        controller: panelController,
        onPanelClosed: () {
          baseController.panelWidget$.value = Container();
        },
        header: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 7,
            child: Center(
              child: Container(
                  width: MediaQuery.of(context).size.width / 7,
                  height: 6,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8))),
            )),
        minHeight: 0,
        maxHeight: context.height * .85,
        padding: const EdgeInsets.only(top: 20),
        body: widget.child,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
        backdropColor: Colors.transparent,
        backdropEnabled: true,
        color: context.theme.backgroundColor,
        // isDraggable: false,

        // panel: main(),
        panelBuilder: (sc) {
          return mainWidget(sc);
        },
      ),
    );
  }

  main() {
    return Obx(() => baseController.panelWidget$.value);
  }

  mainWidget(ScrollController? sc) {
    return Obx(() => baseController.isWidgetScroll$.value
        ? Column(children: [
            Expanded(child: baseController.panelWidget$.value),
          ])
        : ScrollListView(
            scrollController: sc,
            children: [
              baseController.panelWidget$.value,
              const SizedBox(
                height: 30,
              )
            ],
          ));
  }
}

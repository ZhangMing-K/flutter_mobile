import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:photo_view/photo_view.dart';

enum DisposeLevel { High, Medium, Low }

class FullScreenWidget extends StatelessWidget {
  final Widget child;

  final String? url;
  final String? tag;
  final Color backgroundColor;
  final bool backgroundIsTransparent;
  final DisposeLevel? disposeLevel;

  const FullScreenWidget(
      {Key? key,
      required this.child,
      required this.url,
      this.tag,
      this.backgroundColor = Colors.black,
      this.backgroundIsTransparent = true,
      this.disposeLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
            opaque: false,
            barrierColor: backgroundIsTransparent
                ? Colors.white.withOpacity(0)
                : backgroundColor,
            pageBuilder: (BuildContext context, _, __) {
              return FullScreenPage(
                child: child,
                url: url,
                tag: tag,
                backgroundColor: backgroundColor,
                backgroundIsTransparent: backgroundIsTransparent,
                disposeLevel: disposeLevel,
              );
            }));
      },
      child: child,
    );
  }
}

class FullScreenPage extends StatefulWidget {
  final Widget child;

  final String? url;
  final String? tag;
  final Color backgroundColor;
  final bool backgroundIsTransparent;
  final DisposeLevel? disposeLevel;

  const FullScreenPage(
      {Key? key,
      required this.child,
      required this.url,
      this.tag,
      this.backgroundColor = Colors.black,
      this.backgroundIsTransparent = true,
      this.disposeLevel = DisposeLevel.Medium})
      : super(key: key);

  @override
  _FullScreenPageState createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {
  double? initialPositionY = 0;

  double? currentPositionY = 0;

  double positionYDelta = 0;

  double opacity = 0;

  double disposeLimit = 150;

  late Duration animationDuration;

  double scale = 1.0;
  double? beforeScale;
  PhotoViewScaleStateController? scaleStateController;
  bool _isZoomed = false;

  @override
  void initState() {
    scaleStateController = PhotoViewScaleStateController();
    scaleStateController!.outputScaleStateStream.listen((event) {
      setState(() {
        _isZoomed = event != PhotoViewScaleState.zoomedOut &&
            event != PhotoViewScaleState.initial;
      });
    });

    setDisposeLevel();
    animationDuration = Duration.zero;
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          opacity = 1;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundIsTransparent
          ? Colors.transparent
          : widget.backgroundColor,
      body: GestureDetector(
        onVerticalDragStart:
            !_isZoomed ? (details) => _startVerticalDrag(details) : null,
        onVerticalDragUpdate:
            !_isZoomed ? (details) => _whileVerticalDrag(details) : null,
        onVerticalDragEnd:
            !_isZoomed ? (details) => _endVerticalDrag(details) : null,
        onScaleStart: _startScale,
        onScaleUpdate: _updateScale,
        onScaleEnd: _endScale,
        child: AnimatedContainer(
          color: widget.backgroundColor.withOpacity(opacity),
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          //default page transition is 300ms.
          duration: const Duration(milliseconds: 300),
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                duration: animationDuration,
                curve: Curves.fastOutSlowIn,
                top: 0 + positionYDelta,
                bottom: 0 - positionYDelta,
                left: 0,
                right: 0,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: widget.url!,
                    cacheManager: Get.find<IrisImageCacheManager>(),
                    imageBuilder: (context, imageProvider) => PhotoView(
                      imageProvider: imageProvider,
                      minScale: PhotoViewComputedScale.contained,
                      scaleStateController: scaleStateController,
                      initialScale: PhotoViewComputedScale.contained,
                      backgroundDecoration:
                          const BoxDecoration(color: Colors.transparent),
                      heroAttributes: PhotoViewHeroAttributes(tag: widget.tag!),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_isZoomed)
                    Container(
                      child: IconButton(
                        onPressed: () {
                          scaleStateController!.scaleState =
                              PhotoViewScaleState.initial;
                        },
                        icon: const Icon(Icons.close_outlined,
                            size: 32.0, color: Colors.white),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 30),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    scaleStateController?.dispose();
    super.dispose();
  }

  setDisposeLevel() {
    setState(() {
      if (widget.disposeLevel == DisposeLevel.High) {
        disposeLimit = 300;
      } else if (widget.disposeLevel == DisposeLevel.Medium) {
        disposeLimit = 200;
      } else {
        disposeLimit = 100;
      }
    });
  }

  setOpacity() {
    final double tmp = positionYDelta < 0
        ? 1 - ((positionYDelta / 1000) * -1)
        : 1 - (positionYDelta / 1000);

    if (tmp > 1) {
      opacity = 1;
    } else if (tmp < 0) {
      opacity = 0;
    } else {
      opacity = tmp;
    }

    if (positionYDelta > disposeLimit || positionYDelta < -disposeLimit) {
      opacity = 0.0;
    }
  }

  void updateScale(double newScale) {
    setState(() {
      scale = newScale;
    });
  }

  _endScale(ScaleEndDetails details) {
    if (scale < 1.0) {
      // goes to the original size
      updateScale(1.0);
    }
    beforeScale = null;
  }

  _endVerticalDrag(DragEndDetails details) {
    if (positionYDelta > disposeLimit || positionYDelta < -disposeLimit) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        animationDuration = const Duration(milliseconds: 300);
        opacity = 1;
        positionYDelta = 0;
      });

      Future.delayed(animationDuration).then((_) {
        setState(() {
          animationDuration = Duration.zero;
        });
      });
    }
  }

  _startScale(ScaleStartDetails details) {
    beforeScale = scale;
  }

  void _startVerticalDrag(details) {
    setState(() {
      initialPositionY = details.globalPosition.dy;
    });
  }

  _updateScale(ScaleUpdateDetails details) {
    scale = beforeScale! * details.scale;
    updateScale(scale);
  }

  void _whileVerticalDrag(details) {
    setState(() {
      currentPositionY = details.globalPosition.dy;
      positionYDelta = currentPositionY! - initialPositionY!;
      setOpacity();
    });
  }
}

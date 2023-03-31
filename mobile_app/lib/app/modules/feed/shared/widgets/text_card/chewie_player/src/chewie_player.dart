import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/app_easy_rich_text/index.dart';
import 'package:iris_common/shared/widgets/like_button/like_button.dart';
import 'package:unicons/unicons.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import '../../text_card_controller.dart';
import '../../video_watch.dart';
import 'chewie_progress_colors.dart';
import 'elevation.dart';
import 'player_with_controls.dart';

typedef ChewieRoutePageBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  _ChewieControllerProvider controllerProvider,
);

/// A Video Player with Material and Cupertino skins.
///
/// `video_player` is pretty low level. Chewie wraps it in a friendly skin to
/// make it easy to use!
class Chewie extends StatefulWidget {
  /// The [ChewieController]
  final ChewieController controller;

  final TextCardController? textCardController;
  final String? tag;
  final Widget? topContainer;
  final Widget? statContainer;
  final TextModel? text;
  const Chewie({
    Key? key,
    required this.controller,
    this.textCardController,
    this.tag,
    this.topContainer,
    this.statContainer,
    this.text,
  }) : super(key: key);
  @override
  ChewieState createState() {
    return ChewieState();
  }
}

/// The ChewieController is used to configure and drive the Chewie Player
/// Widgets. It provides methods to control playback, such as [pause] and
/// [play], as well as methods that control the visual appearance of the player,
/// such as [enterFullScreen] or [exitFullScreen].
///
/// In addition, you can listen to the ChewieController for presentational
/// changes, such as entering and exiting full screen mode. To listen for
/// changes to the playback, such as a change to the seek position of the
/// player, please use the standard information provided by the
/// `VideoPlayerController`.
class ChewieController extends ChangeNotifier {
  /// The controller for the video you want to play
  final VideoPlayerController videoPlayerController;

  /// Initialize the Video on Startup. This will prep the video for playback.
  final bool autoInitialize;

  /// Play the video as soon as it's displayed
  final bool autoPlay;

  /// Start video at a certain position
  final Duration? startAt;

  /// Whether or not the video should loop
  final bool looping;

  /// Weather or not to show the controls when initializing the widget.
  final bool showControlsOnInitialize;

  /// Whether or not to show the controls at all
  final bool showControls;

  bool? showBottom;

  /// Defines customised controls. Check [MaterialControls] or
  /// [CupertinoControls] for reference.
  final Widget? customControls;

  /// When the video playback runs  into an error, you can build a custom
  /// error message.
  final Widget Function(BuildContext context, String? errorMessage)?
      errorBuilder;

  /// The Aspect Ratio of the Video. Important to get the correct size of the
  /// video!
  ///
  /// Will fallback to fitting within the space allowed.
  final double? aspectRatio;

  /// The colors to use for controls on iOS. By default, the iOS player uses
  /// colors sampled from the original iOS 11 designs.
  final ChewieProgressColors? cupertinoProgressColors;

  /// The colors to use for the Material Progress Bar. By default, the Material
  /// player uses the colors from your Theme.
  final ChewieProgressColors? materialProgressColors;

  /// The placeholder is displayed underneath the Video before it is initialized
  /// or played.
  final Widget? placeholder;

  /// A widget which is placed between the video and the controls
  final Widget? overlay;

  /// Defines if the player will start in fullscreen when play is pressed
  final bool fullScreenByDefault;

  /// Defines if the player will sleep in fullscreen or not
  final bool allowedScreenSleep;

  /// Defines if the controls should be for live stream video
  final bool isLive;

  /// Defines if the fullscreen control should be shown
  final bool allowFullScreen;

  /// Defines if the mute control should be shown
  final bool allowMuting;

  /// Defines if the playback speed control should be shown
  final bool allowPlaybackSpeedChanging;

  /// Defines the set of allowed playback speeds user can change
  final List<double> playbackSpeeds;

  /// Defines the system overlays visible on entering fullscreen
  final List<SystemUiOverlay>? systemOverlaysOnEnterFullScreen;

  /// Defines the set of allowed device orientations on entering fullscreen
  final List<DeviceOrientation>? deviceOrientationsOnEnterFullScreen;

  /// Defines the system overlays visible after exiting fullscreen
  final List<SystemUiOverlay> systemOverlaysAfterFullScreen;

  /// Defines the set of allowed device orientations after exiting fullscreen
  final List<DeviceOrientation> deviceOrientationsAfterFullScreen;

  /// Defines a custom RoutePageBuilder for the fullscreen
  final ChewieRoutePageBuilder? routePageBuilder;

  final bool showWatch;

  bool _isFullScreen = false;

  bool _mounted = true;

  ChewieController({
    required this.videoPlayerController,
    this.aspectRatio,
    this.autoInitialize = false,
    this.autoPlay = false,
    this.startAt,
    this.looping = false,
    this.fullScreenByDefault = false,
    this.cupertinoProgressColors,
    this.materialProgressColors,
    this.placeholder,
    this.overlay,
    this.showControlsOnInitialize = true,
    this.showControls = true,
    this.customControls,
    this.errorBuilder,
    this.allowedScreenSleep = true,
    this.isLive = false,
    this.allowFullScreen = true,
    this.allowMuting = true,
    this.allowPlaybackSpeedChanging = true,
    this.playbackSpeeds = const [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2],
    this.systemOverlaysOnEnterFullScreen,
    this.deviceOrientationsOnEnterFullScreen,
    this.systemOverlaysAfterFullScreen = SystemUiOverlay.values,
    this.deviceOrientationsAfterFullScreen = DeviceOrientation.values,
    this.routePageBuilder,
    this.showBottom = true,
    this.showWatch = false,
  }) : assert(playbackSpeeds.every((speed) => speed > 0),
            'The playbackSpeeds values must all be greater than 0') {
    _initialize();
  }

  bool get isFullScreen => _isFullScreen;

  bool get isPlaying => videoPlayerController.value.isPlaying;
  bool get mounted => _mounted;

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  void enterFullScreen() {
    _isFullScreen = true;
    notifyListeners();
  }

  void exitFullScreen() {
    _isFullScreen = false;
    notifyListeners();
  }

  Future<void> pause() async {
    if (_mounted) await videoPlayerController.pause();
  }

  Future<void> play() async {
    if (_mounted) await videoPlayerController.play();
  }

  Future<void> seekTo(Duration moment) async {
    if (_mounted) await videoPlayerController.seekTo(moment);
  }

  Future<void> setLooping(bool looping) async {
    if (_mounted) await videoPlayerController.setLooping(looping);
  }

  Future<void> setVolume(double volume) async {
    if (_mounted) {
      await videoPlayerController.setVolume(volume);
    }
  }

  void toggleFullScreen() {
    _isFullScreen = !_isFullScreen;
    notifyListeners();
  }

  // ignore: avoid_positional_boolean_parameters
  void togglePause() {
    isPlaying ? pause() : play();
  }

  Future<void> _fullScreenListener() async {
    if (videoPlayerController.value.isPlaying && !_isFullScreen) {
      enterFullScreen();
      videoPlayerController.removeListener(_fullScreenListener);
    }
  }

  Future _initialize() async {
    await videoPlayerController.setLooping(looping);

    if ((autoInitialize || autoPlay) &&
        !videoPlayerController.value.isInitialized) {
      await videoPlayerController.initialize();
    }

    if (autoPlay) {
      if (fullScreenByDefault) {
        enterFullScreen();
      }

      await videoPlayerController.play();
    }

    if (startAt != null) {
      await videoPlayerController.seekTo(startAt!);
    }

    if (fullScreenByDefault) {
      videoPlayerController.addListener(_fullScreenListener);
    }
  }

  static ChewieController of(BuildContext context) {
    final chewieControllerProvider = context
        .dependOnInheritedWidgetOfExactType<_ChewieControllerProvider>()!;

    return chewieControllerProvider.controller;
  }
}

class ChewieState extends State<Chewie> {
  bool _isFullScreen = false;
  double sidebarWidth = 50.0;

  LinearGradient get musicGradient => LinearGradient(colors: [
        Colors.grey[800]!,
        Colors.grey[900]!,
        Colors.grey[900]!,
        Colors.grey[800]!
      ], stops: const [
        0.0,
        0.4,
        0.6,
        1.0
      ], begin: Alignment.bottomLeft, end: Alignment.topRight);

  Widget bottomBar() {
    final infoPosition = ScreenUtil().screenWidth;
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 10, right: 10),
          child: Container(
              width: infoPosition - sidebarWidth - 20 - 30,
              margin: const EdgeInsets.only(
                  left: 10, right: 0, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    ProfileImage(
                      radius: 20,
                      url: widget.text!.user!.profilePictureUrl,
                      uuid: widget.text!.user!.userKey.toString(),
                    ),
                    const SizedBox(width: 6),
                    Text(
                        widget.text?.user?.displayName ??
                            widget.text?.user?.fullName ??
                            '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Color.fromRGBO(41, 41, 41, 0.7),
                        )),
                  ]),
                  const SizedBox(height: 6),
                  RichTextEditor(
                    originalText: widget.text!.value,
                    text: widget.text!.value,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        backgroundColor: Color.fromRGBO(41, 41, 41, 0.7)),
                    showMore: () {},
                  )
                ],
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _ChewieControllerProvider(
      controller: widget.controller,
      child: const PlayerWithControls(),
    );
  }

  @override
  void didUpdateWidget(Chewie oldWidget) {
    if (oldWidget.controller != widget.controller) {
      widget.controller.addListener(listener);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listener);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listener);
  }

  Future<void> listener() async {
    if (widget.controller.isFullScreen && !_isFullScreen) {
      _isFullScreen = true;
      await _pushFullScreenWidget(context);
    } else if (_isFullScreen) {
      Navigator.of(context, rootNavigator: true).pop();
      _isFullScreen = false;
    }
  }

  void onEnterFullScreen() {
    final videoWidth = widget.controller.videoPlayerController.value.size.width;
    final videoHeight =
        widget.controller.videoPlayerController.value.size.height;

    if (widget.controller.deviceOrientationsOnEnterFullScreen != null) {
      /// Optional user preferred settings
      SystemChrome.setPreferredOrientations(
          widget.controller.deviceOrientationsOnEnterFullScreen!);
    } else {
      final isLandscapeVideo = videoWidth > videoHeight;
      final isPortraitVideo = videoWidth < videoHeight;

      /// Default behavior
      /// Video w > h means we force landscape
      if (isLandscapeVideo) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }

      /// Video h > w means we force portrait
      else if (isPortraitVideo) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }

      /// Otherwise if h == w (square video)
      else {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      }
    }
  }

  Widget sideBar() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Padding(
          padding: const EdgeInsets.only(bottom: 0.0, left: 0, right: 10),
          child: Container(
            width: sidebarWidth,
            margin:
                const EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 70),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 0),
                    height: 70,
                    width: sidebarWidth,
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LikeButton(
                          isExpanded: false,
                          unselectedColor: Colors.white,
                          text$: widget.textCardController!.text$,
                          height: 40,
                          color: Colors.white,
                          showNumber: false,
                          onPressed: (reaction) =>
                              widget.textCardController!.reactToPost(),
                        ),
                        Obx(() => Text(
                            widget.textCardController!.text$!.value!
                                .numberOfReactions
                                .toString(),
                            style: const TextStyle(color: Colors.white))),
                      ],
                    )),
                const SizedBox(height: 8),
                Container(
                    width: sidebarWidth,
                    alignment: Alignment.topLeft,
                    height: 60,
                    child: InkWell(
                      child: Column(
                        children: [
                          const Icon(UniconsLine.comment,
                              size: 40, color: Colors.white),
                          Text(
                              widget.textCardController!.text$!.value!
                                  .numberOfComments
                                  .toString(),
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      onTap: () {
                        //TODO: COME BACK HERE
                        Get.toNamed(
                            Paths.Text.createPath([
                              widget.textCardController!.text$!.value!.textKey
                            ]),
                            arguments: TextScreenArgs(
                                text: widget.textCardController!.text$!));
                      },
                    )),
              ],
            ),
          )),
    );
  }

  Future<dynamic> _pushFullScreenWidget(
    BuildContext context,
  ) async {
    onEnterFullScreen();

    if (!widget.controller.allowedScreenSleep) {
      Wakelock.enable();
    }
    final controllerProvider = _ChewieControllerProvider(
      controller: widget.controller,
      child: const PlayerWithControls(),
    );
    final TransitionRoute<void> route = PageRouteBuilder<void>(
        opaque: false,
        barrierColor: Colors.black.withOpacity(0),
        pageBuilder: (BuildContext context, _, __) {
          final statusBarHeight = MediaQuery.of(context).viewPadding.top;
          return OrientationBuilder(builder: (context, orientation) {
            return VideoWatchPage(
              onClose: () {
                widget.controller.exitFullScreen();
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  alignment: Alignment.center,
                  color: Colors.black,
                  child: StackZ(
                    childrenZ: [
                      Positioned(bottom: 0, left: 0, child: bottomBar())
                          .elevate(2) as Elevation,
                      Positioned(bottom: 0, right: 0, child: sideBar())
                          .elevate(2) as Elevation,
                      Positioned(
                          top: 0,
                          child: SizedBox(
                            child: controllerProvider,
                            height: MediaQuery.of(context).size.height -
                                statusBarHeight,
                            width: MediaQuery.of(context).size.width,
                          )).elevate(1) as Elevation,
                    ],
                  ),
                ),
              ),
              url: 'video',
            );
          });
        });

    await Navigator.of(context).push(route);
    _isFullScreen = false;
    // widget.controller.exitFullScreen();

    // The wakelock plugins checks whether it needs to perform an action internally,
    // so we do not need to check Wakelock.isEnabled.
    Wakelock.disable();

    SystemChrome.setPreferredOrientations(
        widget.controller.deviceOrientationsAfterFullScreen);
  }
}

class _ChewieControllerProvider extends InheritedWidget {
  final ChewieController controller;

  const _ChewieControllerProvider({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_ChewieControllerProvider old) =>
      controller != old.controller;
}

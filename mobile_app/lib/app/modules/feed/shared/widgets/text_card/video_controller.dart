import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iris_common/iris_common.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'chewie_player/chewie.dart';
import 'text_card_controller.dart';
import 'video_watch.dart';

class ChewiePlayer extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ChewiePlayer(
      {required this.url,
      this.textCardController,
      this.showBottom,
      this.topContainer,
      this.statContainer,
      this.text});

  final String url;
  final TextCardController? textCardController;
  final bool? showBottom;
  final Widget? topContainer;
  final Widget? statContainer;
  final TextModel? text;

  @override
  State<StatefulWidget> createState() {
    return _ChewiePlayerState();
  }
}

class _ChewiePlayerState extends State<ChewiePlayer> {
  VideoPlayerController? _videoPlayerController1;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(widget.url,
        videoPlayerOptions: VideoPlayerOptions(
            mixWithOthers:
                true) // mixWithOtheres true to play the system audio together
        );
    await _videoPlayerController1!.initialize();
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController1!,
        autoPlay: true,
        looping: true,
        showBottom: widget.showBottom);
    _chewieController!.setVolume(0.0);
    setState(() {});
  }

  void onCancel() {
    _chewieController!.exitFullScreen();
  }

  generateTag() {
    final rnd = Random();
    var next = rnd.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    return next.toInt();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    double videoWidth;
    double videoHeight;
    double containerHeight = 200;
    double containerWidth = screenWidth;
    if (_chewieController != null &&
        _chewieController!.videoPlayerController.value.isInitialized) {
      videoWidth = _chewieController!.videoPlayerController.value.size.width;
      videoHeight = _chewieController!.videoPlayerController.value.size.height;
      if (videoWidth > videoHeight) {
        containerWidth = screenWidth;
        final ratio = videoWidth / screenWidth;
        containerHeight = videoHeight / ratio + 50;
      } else {
        containerHeight = ScreenUtil().setHeight(400);
      }
    }
    final tag = generateTag().toString();
    return VisibilityDetector(
      key: Key(widget.url),
      onVisibilityChanged: (visibilityInfo) {
        final visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 80.0) {
          if (_chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized) {
            if (!_chewieController!.videoPlayerController.value.isPlaying) {
              _chewieController!.videoPlayerController.play();
            }
          }
        } else {
          final isFullScreen = _chewieController?.isFullScreen;
          if (_chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized) {
            if (_chewieController!.videoPlayerController.value.isPlaying &&
                !isFullScreen!) {
              _chewieController!.videoPlayerController.pause();
              _chewieController!.setVolume(0.0);
            }
          }
        }
      },
      child: SizedBox(
          height: containerHeight,
          width: containerWidth,
          child: Column(
            children: <Widget>[
              Expanded(
                child: _chewieController != null &&
                        _chewieController!
                            .videoPlayerController.value.isInitialized
                    ? VideoWatchWidget(
                        child: Center(
                            child: Chewie(
                          controller: _chewieController!,
                          textCardController: widget.textCardController,
                          tag: tag,
                          text: widget.text,
                        )),
                        onClose: onCancel,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                        ],
                      ),
              ),
            ],
          )),
    );
  }
}

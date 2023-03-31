// import 'dart:async';
// import 'dart:typed_data';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:video_thumbnail/video_thumbnail.dart';

// class ThumbnailRequest {
//   final String? video;
//   final String? thumbnailPath;
//   final ImageFormat? imageFormat;
//   final int? maxHeight;
//   final int? maxWidth;
//   final int? timeMs;
//   final int? quality;

//   const ThumbnailRequest(
//       {this.video,
//       this.thumbnailPath,
//       this.imageFormat,
//       this.maxHeight,
//       this.maxWidth,
//       this.timeMs,
//       this.quality});
// }

// class ThumbnailResult {
//   final Image? image;
//   final int? dataSize;
//   final int? height;
//   final int? width;
//   const ThumbnailResult({this.image, this.dataSize, this.height, this.width});
// }

// class GenThumbnailImage extends StatefulWidget {
//   final ThumbnailRequest? thumbnailRequest;

//   const GenThumbnailImage({Key? key, this.thumbnailRequest}) : super(key: key);

//   @override
//   _GenThumbnailImageState createState() => _GenThumbnailImageState();
// }

// Future<ThumbnailResult> genThumbnail(ThumbnailRequest r) async {
//   //WidgetsFlutterBinding.ensureInitialized();
//   Uint8List? bytes;
//   final Completer<ThumbnailResult> completer = Completer();

//   bytes = await VideoThumbnail.thumbnailData(
//       video: r.video!,
//       imageFormat: ImageFormat.JPEG,
//       maxHeight: r.maxHeight!,
//       maxWidth: r.maxWidth!,
//       timeMs: r.timeMs!,
//       quality: r.quality!);
//   final _image = Image.memory(bytes!);
//   _image.image
//       .resolve(ImageConfiguration())
//       .addListener(ImageStreamListener((ImageInfo info, bool _) {
//     completer.complete(ThumbnailResult(
//       image: _image,
//     ));
//   }));
//   return completer.future;
// }

// class _GenThumbnailImageState extends State<GenThumbnailImage> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<ThumbnailResult>(
//       future: genThumbnail(widget.thumbnailRequest!),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.hasData) {
//           final _image = snapshot.data.image;
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               _image,
//             ],
//           );
//         } else if (snapshot.hasError) {
//           return Container(
//             color: Colors.red,
//             child: Text(
//               'Error:\n${snapshot.error.toString()}',
//             ),
//           );
//         } else {
//           return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 CircularProgressIndicator(),
//               ]);
//         }
//       },
//     );
//   }
// }

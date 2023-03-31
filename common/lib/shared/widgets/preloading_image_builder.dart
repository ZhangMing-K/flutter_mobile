import 'package:flutter/widgets.dart';

class PreloadingImageBuilder extends StatefulWidget {
  final ImageProvider? imageProvider;
  final AsyncWidgetBuilder<dynamic>? builder;

  const PreloadingImageBuilder({Key? key, this.imageProvider, this.builder})
      : super(key: key);

  @override
  _PreloadingImageBuilderState createState() => _PreloadingImageBuilderState();
}

class _PreloadingImageBuilderState extends State<PreloadingImageBuilder> {
  Future? future;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    future ??=
        precacheImage(widget.imageProvider!, context).then((value) => true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: widget.builder!,
    );
  }
}

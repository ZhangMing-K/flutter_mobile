import 'package:flutter/cupertino.dart';

extension Elevete on Widget {
  Elevated elevate(num i) => Elevation(
        child: this,
        elevation: i,
      );
}

abstract class Elevated {
  const Elevated({this.elevation});
  final num? elevation;
  Widget call();
}

class Elevation extends Elevated {
  const Elevation({required this.elevation, required this.child});
  @override
  final num elevation;
  @protected
  final Widget child;

  @override
  Widget call() => child;
}

abstract class AxisZInterface<T extends Elevated> {
  const AxisZInterface(this.childrenZ);
  final List<T> childrenZ;
}

class StackZ extends Stack implements AxisZInterface<Elevation> {
  StackZ({Key? key, required this.childrenZ}) : super(key: key);
  @override
  final List<Elevation> childrenZ;

  @override
  List<Widget> get children {
    childrenZ.sort((a, b) => a.elevation.compareTo(b.elevation));
    return <Widget>[for (Elevated e in childrenZ) e()];
  }
}

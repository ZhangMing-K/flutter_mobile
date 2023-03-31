import 'package:collection/collection.dart';

class PositionEffectCount {
  final int? open;
  final int? close;
  const PositionEffectCount({this.open, this.close});
  PositionEffectCount copyWith({int? open, int? close}) {
    return PositionEffectCount(
      open: open ?? this.open,
      close: close ?? this.close,
    );
  }

  factory PositionEffectCount.fromJson(Map<String, dynamic> json) {
    return PositionEffectCount(
      open: json['open'],
      close: json['close'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['open'] = open;
    data['close'] = close;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PositionEffectCount &&
            (identical(other.open, open) ||
                const DeepCollectionEquality().equals(other.open, open)) &&
            (identical(other.close, close) ||
                const DeepCollectionEquality().equals(other.close, close)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(open) ^
        const DeepCollectionEquality().hash(close);
  }

  @override
  String toString() => 'PositionEffectCount(${toJson()})';
}

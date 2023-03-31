import 'package:iris_common/data/models/enums/context_type.dart';
import 'package:collection/collection.dart';

class Context {
  final CONTEXT_TYPE? contextType;
  final int? contextKey;
  const Context({this.contextType, this.contextKey});
  Context copyWith({CONTEXT_TYPE? contextType, int? contextKey}) {
    return Context(
      contextType: contextType ?? this.contextType,
      contextKey: contextKey ?? this.contextKey,
    );
  }

  factory Context.fromJson(Map<String, dynamic> json) {
    return Context(
      contextType: json['contextType'] != null
          ? CONTEXT_TYPE.values.byName(json['contextType'])
          : null,
      contextKey: json['contextKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['contextType'] = contextType?.name;
    data['contextKey'] = contextKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Context &&
            (identical(other.contextType, contextType) ||
                const DeepCollectionEquality()
                    .equals(other.contextType, contextType)) &&
            (identical(other.contextKey, contextKey) ||
                const DeepCollectionEquality()
                    .equals(other.contextKey, contextKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(contextType) ^
        const DeepCollectionEquality().hash(contextKey);
  }

  @override
  String toString() => 'Context(${toJson()})';
}

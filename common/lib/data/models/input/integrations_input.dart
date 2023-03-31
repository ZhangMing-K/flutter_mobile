import 'package:iris_common/data/models/enums/social_source.dart';
import 'package:collection/collection.dart';

class IntegrationsInput {
  final List<SOCIAL_SOURCE>? sources;
  const IntegrationsInput({this.sources});
  IntegrationsInput copyWith({List<SOCIAL_SOURCE>? sources}) {
    return IntegrationsInput(
      sources: sources ?? this.sources,
    );
  }

  factory IntegrationsInput.fromJson(Map<String, dynamic> json) {
    return IntegrationsInput(
      sources: json['sources']
          ?.map<SOCIAL_SOURCE>((o) => SOCIAL_SOURCE.values.byName(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['sources'] = sources?.map((item) => item.name).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IntegrationsInput &&
            (identical(other.sources, sources) ||
                const DeepCollectionEquality().equals(other.sources, sources)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(sources);
  }

  @override
  String toString() => 'IntegrationsInput(${toJson()})';
}

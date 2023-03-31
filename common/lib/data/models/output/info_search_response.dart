import 'package:iris_common/data/models/output/info.dart';
import 'package:collection/collection.dart';

class InfoSearchResponse {
  final List<Info>? infos;
  const InfoSearchResponse({this.infos});
  InfoSearchResponse copyWith({List<Info>? infos}) {
    return InfoSearchResponse(
      infos: infos ?? this.infos,
    );
  }

  factory InfoSearchResponse.fromJson(Map<String, dynamic> json) {
    return InfoSearchResponse(
      infos: json['infos']?.map<Info>((o) => Info.fromJson(o)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['infos'] = infos?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InfoSearchResponse &&
            (identical(other.infos, infos) ||
                const DeepCollectionEquality().equals(other.infos, infos)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(infos);
  }

  @override
  String toString() => 'InfoSearchResponse(${toJson()})';
}

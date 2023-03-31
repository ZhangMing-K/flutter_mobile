import 'package:iris_common/data/models/output/institution.dart';
import 'package:collection/collection.dart';

class InstitutionsGetResponse {
  final List<Institution>? institutions;
  const InstitutionsGetResponse({this.institutions});
  InstitutionsGetResponse copyWith({List<Institution>? institutions}) {
    return InstitutionsGetResponse(
      institutions: institutions ?? this.institutions,
    );
  }

  factory InstitutionsGetResponse.fromJson(Map<String, dynamic> json) {
    return InstitutionsGetResponse(
      institutions: json['institutions']
          ?.map<Institution>((o) => Institution.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['institutions'] = institutions?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InstitutionsGetResponse &&
            (identical(other.institutions, institutions) ||
                const DeepCollectionEquality()
                    .equals(other.institutions, institutions)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(institutions);
  }

  @override
  String toString() => 'InstitutionsGetResponse(${toJson()})';
}

import 'package:iris_common/data/models/output/reaction.dart';
import 'package:collection/collection.dart';

class ReactToTextResponse {
  final Reaction? reaction;
  const ReactToTextResponse({this.reaction});
  ReactToTextResponse copyWith({Reaction? reaction}) {
    return ReactToTextResponse(
      reaction: reaction ?? this.reaction,
    );
  }

  factory ReactToTextResponse.fromJson(Map<String, dynamic> json) {
    return ReactToTextResponse(
      reaction:
          json['reaction'] != null ? Reaction.fromJson(json['reaction']) : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['reaction'] = reaction?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ReactToTextResponse &&
            (identical(other.reaction, reaction) ||
                const DeepCollectionEquality()
                    .equals(other.reaction, reaction)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ const DeepCollectionEquality().hash(reaction);
  }

  @override
  String toString() => 'ReactToTextResponse(${toJson()})';
}

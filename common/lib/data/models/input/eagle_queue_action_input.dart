import 'package:iris_common/data/models/enums/eagle_queue_action.dart';
import 'package:collection/collection.dart';

class EagleQueueActionInput {
  final EAGLE_QUEUE_ACTION? jobName;
  final int? assetKey;
  const EagleQueueActionInput({required this.jobName, this.assetKey});
  EagleQueueActionInput copyWith({EAGLE_QUEUE_ACTION? jobName, int? assetKey}) {
    return EagleQueueActionInput(
      jobName: jobName ?? this.jobName,
      assetKey: assetKey ?? this.assetKey,
    );
  }

  factory EagleQueueActionInput.fromJson(Map<String, dynamic> json) {
    return EagleQueueActionInput(
      jobName: json['jobName'] != null
          ? EAGLE_QUEUE_ACTION.values.byName(json['jobName'])
          : null,
      assetKey: json['assetKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['jobName'] = jobName?.name;
    data['assetKey'] = assetKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EagleQueueActionInput &&
            (identical(other.jobName, jobName) ||
                const DeepCollectionEquality()
                    .equals(other.jobName, jobName)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(jobName) ^
        const DeepCollectionEquality().hash(assetKey);
  }

  @override
  String toString() => 'EagleQueueActionInput(${toJson()})';
}

import 'package:iris_common/data/models/output/auto_pilot_order_preview.dart';
import 'package:collection/collection.dart';

class AutoPilotUpdateAllocationPreviewGetResponse {
  final List<AutoPilotOrderPreview>? orderPreviews;
  final double? amountOpened;
  final double? amountClosed;
  const AutoPilotUpdateAllocationPreviewGetResponse(
      {this.orderPreviews, this.amountOpened, this.amountClosed});
  AutoPilotUpdateAllocationPreviewGetResponse copyWith(
      {List<AutoPilotOrderPreview>? orderPreviews,
      double? amountOpened,
      double? amountClosed}) {
    return AutoPilotUpdateAllocationPreviewGetResponse(
      orderPreviews: orderPreviews ?? this.orderPreviews,
      amountOpened: amountOpened ?? this.amountOpened,
      amountClosed: amountClosed ?? this.amountClosed,
    );
  }

  factory AutoPilotUpdateAllocationPreviewGetResponse.fromJson(
      Map<String, dynamic> json) {
    return AutoPilotUpdateAllocationPreviewGetResponse(
      orderPreviews: json['orderPreviews']
          ?.map<AutoPilotOrderPreview>((o) => AutoPilotOrderPreview.fromJson(o))
          .toList(),
      amountOpened: json['amountOpened']?.toDouble(),
      amountClosed: json['amountClosed']?.toDouble(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['orderPreviews'] =
        orderPreviews?.map((item) => item.toJson()).toList();
    data['amountOpened'] = amountOpened;
    data['amountClosed'] = amountClosed;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AutoPilotUpdateAllocationPreviewGetResponse &&
            (identical(other.orderPreviews, orderPreviews) ||
                const DeepCollectionEquality()
                    .equals(other.orderPreviews, orderPreviews)) &&
            (identical(other.amountOpened, amountOpened) ||
                const DeepCollectionEquality()
                    .equals(other.amountOpened, amountOpened)) &&
            (identical(other.amountClosed, amountClosed) ||
                const DeepCollectionEquality()
                    .equals(other.amountClosed, amountClosed)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(orderPreviews) ^
        const DeepCollectionEquality().hash(amountOpened) ^
        const DeepCollectionEquality().hash(amountClosed);
  }

  @override
  String toString() =>
      'AutoPilotUpdateAllocationPreviewGetResponse(${toJson()})';
}

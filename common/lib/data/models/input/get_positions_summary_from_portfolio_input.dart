import 'package:collection/collection.dart';

class GetPositionsSummaryFromPortfolioInput {
  final int? limit;
  final int? autoPilotMasterPortfolioKey;
  const GetPositionsSummaryFromPortfolioInput(
      {this.limit, this.autoPilotMasterPortfolioKey});
  GetPositionsSummaryFromPortfolioInput copyWith(
      {int? limit, int? autoPilotMasterPortfolioKey}) {
    return GetPositionsSummaryFromPortfolioInput(
      limit: limit ?? this.limit,
      autoPilotMasterPortfolioKey:
          autoPilotMasterPortfolioKey ?? this.autoPilotMasterPortfolioKey,
    );
  }

  factory GetPositionsSummaryFromPortfolioInput.fromJson(
      Map<String, dynamic> json) {
    return GetPositionsSummaryFromPortfolioInput(
      limit: json['limit'],
      autoPilotMasterPortfolioKey: json['autoPilotMasterPortfolioKey'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    data['autoPilotMasterPortfolioKey'] = autoPilotMasterPortfolioKey;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetPositionsSummaryFromPortfolioInput &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.autoPilotMasterPortfolioKey,
                    autoPilotMasterPortfolioKey) ||
                const DeepCollectionEquality().equals(
                    other.autoPilotMasterPortfolioKey,
                    autoPilotMasterPortfolioKey)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(autoPilotMasterPortfolioKey);
  }

  @override
  String toString() => 'GetPositionsSummaryFromPortfolioInput(${toJson()})';
}

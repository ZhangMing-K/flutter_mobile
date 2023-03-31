import 'package:iris_common/data/models/output/portfolio_financial_info.dart';
import 'package:collection/collection.dart';

class GetUserPortfoliosFinancialInfoResponse {
  final List<PortfolioFinancialInfo>? financialInfos;
  const GetUserPortfoliosFinancialInfoResponse({this.financialInfos});
  GetUserPortfoliosFinancialInfoResponse copyWith(
      {List<PortfolioFinancialInfo>? financialInfos}) {
    return GetUserPortfoliosFinancialInfoResponse(
      financialInfos: financialInfos ?? this.financialInfos,
    );
  }

  factory GetUserPortfoliosFinancialInfoResponse.fromJson(
      Map<String, dynamic> json) {
    return GetUserPortfoliosFinancialInfoResponse(
      financialInfos: json['financialInfos']
          ?.map<PortfolioFinancialInfo>(
              (o) => PortfolioFinancialInfo.fromJson(o))
          .toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['financialInfos'] =
        financialInfos?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetUserPortfoliosFinancialInfoResponse &&
            (identical(other.financialInfos, financialInfos) ||
                const DeepCollectionEquality()
                    .equals(other.financialInfos, financialInfos)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(financialInfos);
  }

  @override
  String toString() => 'GetUserPortfoliosFinancialInfoResponse(${toJson()})';
}

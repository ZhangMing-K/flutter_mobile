import 'package:iris_common/data/models/output/due_diligence_reason.dart';
import 'package:iris_common/data/models/output/author_asset_allocation_edge.dart';
import 'package:iris_common/data/models/enums/term.dart';
import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/text_model.dart';
import 'package:iris_common/data/models/output/asset.dart';
import 'package:iris_common/data/models/output/order.dart';
import 'package:collection/collection.dart';

class DueDiligence {
  final int? dueDiligenceKey;
  final int? userKey;
  final int? assetKey;
  final int? textKey;
  final String? symbol;
  final String? cancelledReason;
  final String? riskRatingReason;
  final String? title;
  final List<DueDiligenceReason>? historicalReasons;
  final double? assetPriceAtCreation;
  final double? bearishAllocationAtCreation;
  final double? bullishAllocationAtCreation;
  final double? bearishAmountAtCreation;
  final double? bullishAmountAtCreation;
  final double? bearishAllocation;
  final double? bullishAllocation;
  final double? bearishAmount;
  final double? bullishAmount;
  final AuthorAssetAllocationEdge? authorAssetAllocationEdge;
  final double? assetPriceAtCancellation;
  final double? assetPriceAtExpiration;
  final double? priceTarget;
  final double? percentChangeTarget;
  final double? percentChangeCaptured;
  final int? riskRating;
  final TERM? term;
  final bool? isExpired;
  final bool? reasonsIsEditable;
  final bool? isEditable;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? updatedDDAt;
  final DateTime? deletedAt;
  final DateTime? cancelledAt;
  final DateTime? expiresAt;
  final User? user;
  final TextModel? text;
  final Asset? asset;
  final List<DueDiligence>? relatedDueDiligence;
  final List<Order>? orders;
  const DueDiligence(
      {this.dueDiligenceKey,
      this.userKey,
      this.assetKey,
      this.textKey,
      this.symbol,
      this.cancelledReason,
      this.riskRatingReason,
      this.title,
      this.historicalReasons,
      this.assetPriceAtCreation,
      this.bearishAllocationAtCreation,
      this.bullishAllocationAtCreation,
      this.bearishAmountAtCreation,
      this.bullishAmountAtCreation,
      this.bearishAllocation,
      this.bullishAllocation,
      this.bearishAmount,
      this.bullishAmount,
      this.authorAssetAllocationEdge,
      this.assetPriceAtCancellation,
      this.assetPriceAtExpiration,
      this.priceTarget,
      this.percentChangeTarget,
      this.percentChangeCaptured,
      this.riskRating,
      this.term,
      this.isExpired,
      this.reasonsIsEditable,
      this.isEditable,
      this.createdAt,
      this.updatedAt,
      this.updatedDDAt,
      this.deletedAt,
      this.cancelledAt,
      this.expiresAt,
      this.user,
      this.text,
      this.asset,
      this.relatedDueDiligence,
      this.orders});
  DueDiligence copyWith(
      {int? dueDiligenceKey,
      int? userKey,
      int? assetKey,
      int? textKey,
      String? symbol,
      String? cancelledReason,
      String? riskRatingReason,
      String? title,
      List<DueDiligenceReason>? historicalReasons,
      double? assetPriceAtCreation,
      double? bearishAllocationAtCreation,
      double? bullishAllocationAtCreation,
      double? bearishAmountAtCreation,
      double? bullishAmountAtCreation,
      double? bearishAllocation,
      double? bullishAllocation,
      double? bearishAmount,
      double? bullishAmount,
      AuthorAssetAllocationEdge? authorAssetAllocationEdge,
      double? assetPriceAtCancellation,
      double? assetPriceAtExpiration,
      double? priceTarget,
      double? percentChangeTarget,
      double? percentChangeCaptured,
      int? riskRating,
      TERM? term,
      bool? isExpired,
      bool? reasonsIsEditable,
      bool? isEditable,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? updatedDDAt,
      DateTime? deletedAt,
      DateTime? cancelledAt,
      DateTime? expiresAt,
      User? user,
      TextModel? text,
      Asset? asset,
      List<DueDiligence>? relatedDueDiligence,
      List<Order>? orders}) {
    return DueDiligence(
      dueDiligenceKey: dueDiligenceKey ?? this.dueDiligenceKey,
      userKey: userKey ?? this.userKey,
      assetKey: assetKey ?? this.assetKey,
      textKey: textKey ?? this.textKey,
      symbol: symbol ?? this.symbol,
      cancelledReason: cancelledReason ?? this.cancelledReason,
      riskRatingReason: riskRatingReason ?? this.riskRatingReason,
      title: title ?? this.title,
      historicalReasons: historicalReasons ?? this.historicalReasons,
      assetPriceAtCreation: assetPriceAtCreation ?? this.assetPriceAtCreation,
      bearishAllocationAtCreation:
          bearishAllocationAtCreation ?? this.bearishAllocationAtCreation,
      bullishAllocationAtCreation:
          bullishAllocationAtCreation ?? this.bullishAllocationAtCreation,
      bearishAmountAtCreation:
          bearishAmountAtCreation ?? this.bearishAmountAtCreation,
      bullishAmountAtCreation:
          bullishAmountAtCreation ?? this.bullishAmountAtCreation,
      bearishAllocation: bearishAllocation ?? this.bearishAllocation,
      bullishAllocation: bullishAllocation ?? this.bullishAllocation,
      bearishAmount: bearishAmount ?? this.bearishAmount,
      bullishAmount: bullishAmount ?? this.bullishAmount,
      authorAssetAllocationEdge:
          authorAssetAllocationEdge ?? this.authorAssetAllocationEdge,
      assetPriceAtCancellation:
          assetPriceAtCancellation ?? this.assetPriceAtCancellation,
      assetPriceAtExpiration:
          assetPriceAtExpiration ?? this.assetPriceAtExpiration,
      priceTarget: priceTarget ?? this.priceTarget,
      percentChangeTarget: percentChangeTarget ?? this.percentChangeTarget,
      percentChangeCaptured:
          percentChangeCaptured ?? this.percentChangeCaptured,
      riskRating: riskRating ?? this.riskRating,
      term: term ?? this.term,
      isExpired: isExpired ?? this.isExpired,
      reasonsIsEditable: reasonsIsEditable ?? this.reasonsIsEditable,
      isEditable: isEditable ?? this.isEditable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedDDAt: updatedDDAt ?? this.updatedDDAt,
      deletedAt: deletedAt ?? this.deletedAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      expiresAt: expiresAt ?? this.expiresAt,
      user: user ?? this.user,
      text: text ?? this.text,
      asset: asset ?? this.asset,
      relatedDueDiligence: relatedDueDiligence ?? this.relatedDueDiligence,
      orders: orders ?? this.orders,
    );
  }

  factory DueDiligence.fromJson(Map<String, dynamic> json) {
    return DueDiligence(
      dueDiligenceKey: json['dueDiligenceKey'],
      userKey: json['userKey'],
      assetKey: json['assetKey'],
      textKey: json['textKey'],
      symbol: json['symbol'],
      cancelledReason: json['cancelledReason'],
      riskRatingReason: json['riskRatingReason'],
      title: json['title'],
      historicalReasons: json['historicalReasons']
          ?.map<DueDiligenceReason>((o) => DueDiligenceReason.fromJson(o))
          .toList(),
      assetPriceAtCreation: json['assetPriceAtCreation']?.toDouble(),
      bearishAllocationAtCreation:
          json['bearishAllocationAtCreation']?.toDouble(),
      bullishAllocationAtCreation:
          json['bullishAllocationAtCreation']?.toDouble(),
      bearishAmountAtCreation: json['bearishAmountAtCreation']?.toDouble(),
      bullishAmountAtCreation: json['bullishAmountAtCreation']?.toDouble(),
      bearishAllocation: json['bearishAllocation']?.toDouble(),
      bullishAllocation: json['bullishAllocation']?.toDouble(),
      bearishAmount: json['bearishAmount']?.toDouble(),
      bullishAmount: json['bullishAmount']?.toDouble(),
      authorAssetAllocationEdge: json['authorAssetAllocationEdge'] != null
          ? AuthorAssetAllocationEdge.fromJson(
              json['authorAssetAllocationEdge'])
          : null,
      assetPriceAtCancellation: json['assetPriceAtCancellation']?.toDouble(),
      assetPriceAtExpiration: json['assetPriceAtExpiration']?.toDouble(),
      priceTarget: json['priceTarget']?.toDouble(),
      percentChangeTarget: json['percentChangeTarget']?.toDouble(),
      percentChangeCaptured: json['percentChangeCaptured']?.toDouble(),
      riskRating: json['riskRating'],
      term: json['term'] != null ? TERM.values.byName(json['term']) : null,
      isExpired: json['isExpired'],
      reasonsIsEditable: json['reasonsIsEditable'],
      isEditable: json['isEditable'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      updatedDDAt: json['updatedDDAt'] != null
          ? DateTime.parse(json['updatedDDAt'])
          : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      cancelledAt: json['cancelledAt'] != null
          ? DateTime.parse(json['cancelledAt'])
          : null,
      expiresAt:
          json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      text: json['text'] != null ? TextModel.fromJson(json['text']) : null,
      asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
      relatedDueDiligence: json['relatedDueDiligence']
          ?.map<DueDiligence>((o) => DueDiligence.fromJson(o))
          .toList(),
      orders: json['orders']?.map<Order>((o) => Order.fromJson(o)).toList(),
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['dueDiligenceKey'] = dueDiligenceKey;
    data['userKey'] = userKey;
    data['assetKey'] = assetKey;
    data['textKey'] = textKey;
    data['symbol'] = symbol;
    data['cancelledReason'] = cancelledReason;
    data['riskRatingReason'] = riskRatingReason;
    data['title'] = title;
    data['historicalReasons'] =
        historicalReasons?.map((item) => item.toJson()).toList();
    data['assetPriceAtCreation'] = assetPriceAtCreation;
    data['bearishAllocationAtCreation'] = bearishAllocationAtCreation;
    data['bullishAllocationAtCreation'] = bullishAllocationAtCreation;
    data['bearishAmountAtCreation'] = bearishAmountAtCreation;
    data['bullishAmountAtCreation'] = bullishAmountAtCreation;
    data['bearishAllocation'] = bearishAllocation;
    data['bullishAllocation'] = bullishAllocation;
    data['bearishAmount'] = bearishAmount;
    data['bullishAmount'] = bullishAmount;
    data['authorAssetAllocationEdge'] = authorAssetAllocationEdge?.toJson();
    data['assetPriceAtCancellation'] = assetPriceAtCancellation;
    data['assetPriceAtExpiration'] = assetPriceAtExpiration;
    data['priceTarget'] = priceTarget;
    data['percentChangeTarget'] = percentChangeTarget;
    data['percentChangeCaptured'] = percentChangeCaptured;
    data['riskRating'] = riskRating;
    data['term'] = term?.name;
    data['isExpired'] = isExpired;
    data['reasonsIsEditable'] = reasonsIsEditable;
    data['isEditable'] = isEditable;
    data['createdAt'] = createdAt?.toString();
    data['updatedAt'] = updatedAt?.toString();
    data['updatedDDAt'] = updatedDDAt?.toString();
    data['deletedAt'] = deletedAt?.toString();
    data['cancelledAt'] = cancelledAt?.toString();
    data['expiresAt'] = expiresAt?.toString();
    data['user'] = user?.toJson();
    data['text'] = text?.toJson();
    data['asset'] = asset?.toJson();
    data['relatedDueDiligence'] =
        relatedDueDiligence?.map((item) => item.toJson()).toList();
    data['orders'] = orders?.map((item) => item.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DueDiligence &&
            (identical(other.dueDiligenceKey, dueDiligenceKey) ||
                const DeepCollectionEquality()
                    .equals(other.dueDiligenceKey, dueDiligenceKey)) &&
            (identical(other.userKey, userKey) ||
                const DeepCollectionEquality()
                    .equals(other.userKey, userKey)) &&
            (identical(other.assetKey, assetKey) ||
                const DeepCollectionEquality()
                    .equals(other.assetKey, assetKey)) &&
            (identical(other.textKey, textKey) ||
                const DeepCollectionEquality()
                    .equals(other.textKey, textKey)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.cancelledReason, cancelledReason) ||
                const DeepCollectionEquality()
                    .equals(other.cancelledReason, cancelledReason)) &&
            (identical(other.riskRatingReason, riskRatingReason) ||
                const DeepCollectionEquality()
                    .equals(other.riskRatingReason, riskRatingReason)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.historicalReasons, historicalReasons) ||
                const DeepCollectionEquality()
                    .equals(other.historicalReasons, historicalReasons)) &&
            (identical(other.assetPriceAtCreation, assetPriceAtCreation) ||
                const DeepCollectionEquality().equals(
                    other.assetPriceAtCreation, assetPriceAtCreation)) &&
            (identical(other.bearishAllocationAtCreation, bearishAllocationAtCreation) ||
                const DeepCollectionEquality().equals(
                    other.bearishAllocationAtCreation,
                    bearishAllocationAtCreation)) &&
            (identical(other.bullishAllocationAtCreation, bullishAllocationAtCreation) ||
                const DeepCollectionEquality().equals(
                    other.bullishAllocationAtCreation,
                    bullishAllocationAtCreation)) &&
            (identical(other.bearishAmountAtCreation, bearishAmountAtCreation) ||
                const DeepCollectionEquality().equals(
                    other.bearishAmountAtCreation, bearishAmountAtCreation)) &&
            (identical(other.bullishAmountAtCreation, bullishAmountAtCreation) ||
                const DeepCollectionEquality().equals(
                    other.bullishAmountAtCreation, bullishAmountAtCreation)) &&
            (identical(other.bearishAllocation, bearishAllocation) ||
                const DeepCollectionEquality()
                    .equals(other.bearishAllocation, bearishAllocation)) &&
            (identical(other.bullishAllocation, bullishAllocation) ||
                const DeepCollectionEquality()
                    .equals(other.bullishAllocation, bullishAllocation)) &&
            (identical(other.bearishAmount, bearishAmount) ||
                const DeepCollectionEquality()
                    .equals(other.bearishAmount, bearishAmount)) &&
            (identical(other.bullishAmount, bullishAmount) ||
                const DeepCollectionEquality().equals(other.bullishAmount, bullishAmount)) &&
            (identical(other.authorAssetAllocationEdge, authorAssetAllocationEdge) || const DeepCollectionEquality().equals(other.authorAssetAllocationEdge, authorAssetAllocationEdge)) &&
            (identical(other.assetPriceAtCancellation, assetPriceAtCancellation) || const DeepCollectionEquality().equals(other.assetPriceAtCancellation, assetPriceAtCancellation)) &&
            (identical(other.assetPriceAtExpiration, assetPriceAtExpiration) || const DeepCollectionEquality().equals(other.assetPriceAtExpiration, assetPriceAtExpiration)) &&
            (identical(other.priceTarget, priceTarget) || const DeepCollectionEquality().equals(other.priceTarget, priceTarget)) &&
            (identical(other.percentChangeTarget, percentChangeTarget) || const DeepCollectionEquality().equals(other.percentChangeTarget, percentChangeTarget)) &&
            (identical(other.percentChangeCaptured, percentChangeCaptured) || const DeepCollectionEquality().equals(other.percentChangeCaptured, percentChangeCaptured)) &&
            (identical(other.riskRating, riskRating) || const DeepCollectionEquality().equals(other.riskRating, riskRating)) &&
            (identical(other.term, term) || const DeepCollectionEquality().equals(other.term, term)) &&
            (identical(other.isExpired, isExpired) || const DeepCollectionEquality().equals(other.isExpired, isExpired)) &&
            (identical(other.reasonsIsEditable, reasonsIsEditable) || const DeepCollectionEquality().equals(other.reasonsIsEditable, reasonsIsEditable)) &&
            (identical(other.isEditable, isEditable) || const DeepCollectionEquality().equals(other.isEditable, isEditable)) &&
            (identical(other.createdAt, createdAt) || const DeepCollectionEquality().equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) || const DeepCollectionEquality().equals(other.updatedAt, updatedAt)) &&
            (identical(other.updatedDDAt, updatedDDAt) || const DeepCollectionEquality().equals(other.updatedDDAt, updatedDDAt)) &&
            (identical(other.deletedAt, deletedAt) || const DeepCollectionEquality().equals(other.deletedAt, deletedAt)) &&
            (identical(other.cancelledAt, cancelledAt) || const DeepCollectionEquality().equals(other.cancelledAt, cancelledAt)) &&
            (identical(other.expiresAt, expiresAt) || const DeepCollectionEquality().equals(other.expiresAt, expiresAt)) &&
            (identical(other.user, user) || const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.text, text) || const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.asset, asset) || const DeepCollectionEquality().equals(other.asset, asset)) &&
            (identical(other.relatedDueDiligence, relatedDueDiligence) || const DeepCollectionEquality().equals(other.relatedDueDiligence, relatedDueDiligence)) &&
            (identical(other.orders, orders) || const DeepCollectionEquality().equals(other.orders, orders)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(dueDiligenceKey) ^
        const DeepCollectionEquality().hash(userKey) ^
        const DeepCollectionEquality().hash(assetKey) ^
        const DeepCollectionEquality().hash(textKey) ^
        const DeepCollectionEquality().hash(symbol) ^
        const DeepCollectionEquality().hash(cancelledReason) ^
        const DeepCollectionEquality().hash(riskRatingReason) ^
        const DeepCollectionEquality().hash(title) ^
        const DeepCollectionEquality().hash(historicalReasons) ^
        const DeepCollectionEquality().hash(assetPriceAtCreation) ^
        const DeepCollectionEquality().hash(bearishAllocationAtCreation) ^
        const DeepCollectionEquality().hash(bullishAllocationAtCreation) ^
        const DeepCollectionEquality().hash(bearishAmountAtCreation) ^
        const DeepCollectionEquality().hash(bullishAmountAtCreation) ^
        const DeepCollectionEquality().hash(bearishAllocation) ^
        const DeepCollectionEquality().hash(bullishAllocation) ^
        const DeepCollectionEquality().hash(bearishAmount) ^
        const DeepCollectionEquality().hash(bullishAmount) ^
        const DeepCollectionEquality().hash(authorAssetAllocationEdge) ^
        const DeepCollectionEquality().hash(assetPriceAtCancellation) ^
        const DeepCollectionEquality().hash(assetPriceAtExpiration) ^
        const DeepCollectionEquality().hash(priceTarget) ^
        const DeepCollectionEquality().hash(percentChangeTarget) ^
        const DeepCollectionEquality().hash(percentChangeCaptured) ^
        const DeepCollectionEquality().hash(riskRating) ^
        const DeepCollectionEquality().hash(term) ^
        const DeepCollectionEquality().hash(isExpired) ^
        const DeepCollectionEquality().hash(reasonsIsEditable) ^
        const DeepCollectionEquality().hash(isEditable) ^
        const DeepCollectionEquality().hash(createdAt) ^
        const DeepCollectionEquality().hash(updatedAt) ^
        const DeepCollectionEquality().hash(updatedDDAt) ^
        const DeepCollectionEquality().hash(deletedAt) ^
        const DeepCollectionEquality().hash(cancelledAt) ^
        const DeepCollectionEquality().hash(expiresAt) ^
        const DeepCollectionEquality().hash(user) ^
        const DeepCollectionEquality().hash(text) ^
        const DeepCollectionEquality().hash(asset) ^
        const DeepCollectionEquality().hash(relatedDueDiligence) ^
        const DeepCollectionEquality().hash(orders);
  }

  @override
  String toString() => 'DueDiligence(${toJson()})';
}

import 'package:collection/collection.dart';

class PortfolioSnapshotInput {
  final bool? mostRecent;
  const PortfolioSnapshotInput({this.mostRecent});
  PortfolioSnapshotInput copyWith({bool? mostRecent}) {
    return PortfolioSnapshotInput(
      mostRecent: mostRecent ?? this.mostRecent,
    );
  }

  factory PortfolioSnapshotInput.fromJson(Map<String, dynamic> json) {
    return PortfolioSnapshotInput(
      mostRecent: json['mostRecent'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['mostRecent'] = mostRecent;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PortfolioSnapshotInput &&
            (identical(other.mostRecent, mostRecent) ||
                const DeepCollectionEquality()
                    .equals(other.mostRecent, mostRecent)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(mostRecent);
  }

  @override
  String toString() => 'PortfolioSnapshotInput(${toJson()})';
}

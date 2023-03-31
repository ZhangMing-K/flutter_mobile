import 'package:iris_common/data/models/input/search_options.dart';
import 'package:collection/collection.dart';

class SearchInputModel {
  final String? name;
  final int? limit;
  final int? offset;
  final SearchOptions? options;
  const SearchInputModel({this.name, this.limit, this.offset, this.options});
  SearchInputModel copyWith(
      {String? name, int? limit, int? offset, SearchOptions? options}) {
    return SearchInputModel(
      name: name ?? this.name,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      options: options ?? this.options,
    );
  }

  factory SearchInputModel.fromJson(Map<String, dynamic> json) {
    return SearchInputModel(
      name: json['name'],
      limit: json['limit'],
      offset: json['offset'],
      options: json['options'] != null
          ? SearchOptions.fromJson(json['options'])
          : null,
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['limit'] = limit;
    data['offset'] = offset;
    data['options'] = options?.toJson();
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SearchInputModel &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality().equals(other.options, options)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(name) ^
        const DeepCollectionEquality().hash(limit) ^
        const DeepCollectionEquality().hash(offset) ^
        const DeepCollectionEquality().hash(options);
  }

  @override
  String toString() => 'SearchInputModel(${toJson()})';
}

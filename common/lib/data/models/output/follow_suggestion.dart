import 'package:iris_common/data/models/output/user.dart';
import 'package:iris_common/data/models/output/user_card.dart';
import 'package:collection/collection.dart';

class FollowSuggestion {
  final List<User>? users;
  final List<UserCard>? userCards;
  final String? carouselTitle;
  const FollowSuggestion({this.users, this.userCards, this.carouselTitle});
  FollowSuggestion copyWith(
      {List<User>? users, List<UserCard>? userCards, String? carouselTitle}) {
    return FollowSuggestion(
      users: users ?? this.users,
      userCards: userCards ?? this.userCards,
      carouselTitle: carouselTitle ?? this.carouselTitle,
    );
  }

  factory FollowSuggestion.fromJson(Map<String, dynamic> json) {
    return FollowSuggestion(
      users: json['users']?.map<User>((o) => User.fromJson(o)).toList(),
      userCards: json['userCards']
          ?.map<UserCard>((o) => UserCard.fromJson(o))
          .toList(),
      carouselTitle: json['carouselTitle'],
    );
  }

  Map toJson() {
    final data = <String, dynamic>{};
    data['users'] = users?.map((item) => item.toJson()).toList();
    data['userCards'] = userCards?.map((item) => item.toJson()).toList();
    data['carouselTitle'] = carouselTitle;
    return data;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FollowSuggestion &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)) &&
            (identical(other.userCards, userCards) ||
                const DeepCollectionEquality()
                    .equals(other.userCards, userCards)) &&
            (identical(other.carouselTitle, carouselTitle) ||
                const DeepCollectionEquality()
                    .equals(other.carouselTitle, carouselTitle)));
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        const DeepCollectionEquality().hash(users) ^
        const DeepCollectionEquality().hash(userCards) ^
        const DeepCollectionEquality().hash(carouselTitle);
  }

  @override
  String toString() => 'FollowSuggestion(${toJson()})';
}

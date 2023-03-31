import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class TopInvestorsController extends GetxController {
  final ISearchRepository repository;
  final IStorage storage = Get.find();
  final recommendedList = <User>[].obs;

  final RxList<User> topTraderOverall = <User>[].obs;
  final topTraderEquity = <User>[].obs;
  final topTraderOption = <User>[].obs;
  final topTraderCrypto = <User>[].obs;
  final topTraderMeme = <User>[].obs;
  final recentList = <User>[].obs;
  List<User> savedUsers = <User>[];

  String recommendedCursor = '';

  TopInvestorsController({required this.repository});

  String getCursor(FOLLOW_SUGGESTION_TYPE type) {
    if (type == FOLLOW_SUGGESTION_TYPE.FEATURED) {
      return recommendedCursor;
    } else {
      return '';
    }
  }

  void loadRecentList() {
    final usersFromStorage = storage.read('savedUsers');
    if (usersFromStorage != null) {
      final List<User> userList = List<User>.from(usersFromStorage.map((i) {
        if (i is User) return i;
        return User.fromJson(i);
      }));
      recentList.assignAll(userList);
    }
  }

  void loadRecommended() {
    _onLoadUsers(FOLLOW_SUGGESTION_TYPE.FEATURED);
    _onLoadTopInvestors();
  }

  markItemNoUnSeenCard(List<User> list, int userKey) {
    final len = list.length;
    for (var i = 0; i < len; i++) {
      final item = list[i];
      if (item.userKey == userKey) {
        User originUser = item;
        final StoriesMetaData newMetadata = originUser
            .storiesConnection!.metaData!
            .copyWith(areUnseenStories: false);
        final StoriesConnection newStoriesConnection =
            originUser.storiesConnection!.copyWith(metaData: newMetadata);
        final User newUser =
            originUser.copyWith(storiesConnection: newStoriesConnection);
        list.replaceIndex(newUser, i);
      }
    }
  }

  markItemNoUnSeenStories(int userKey) {
    markItemNoUnSeenCard(topTraderOverall, userKey);
    markItemNoUnSeenCard(topTraderEquity, userKey);
    markItemNoUnSeenCard(topTraderOption, userKey);
    markItemNoUnSeenCard(topTraderCrypto, userKey);
    markItemNoUnSeenCard(topTraderMeme, userKey);
  }

  void onError(err) {
    debugPrint(err.toString());
    Get.snackbar('Error', 'Can not perform search');
  }

  @override
  void onInit() {
    onLoadData();
    loadRecentList();
    super.onInit();
  }

  onLoadData() {
    loadRecommended();
  }

  void onSuccess(dynamic data, {required FOLLOW_SUGGESTION_TYPE type}) {
    if (type == FOLLOW_SUGGESTION_TYPE.FEATURED) {
      recommendedList.assignAll(data);
    }
  }

  void onSuccessTopInvestors(List<TopTraderData<User>> data) {
    final topTraderData = data.asMap();
    topTraderData.forEach((key, value) {
      final SEGMENT_TYPE type = value.type;
      final List<User> users = value.list;
      switch (type) {
        case SEGMENT_TYPE.ALL_POSITION_TYPES:
          topTraderOverall.assignAll(users);
          break;
        case SEGMENT_TYPE.EQUITY:
          topTraderEquity.assignAll(users);
          break;
        case SEGMENT_TYPE.OPTION:
          topTraderOption.assignAll(users);
          break;
        case SEGMENT_TYPE.CRYPTO:
          topTraderCrypto.assignAll(users);
          break;
        case SEGMENT_TYPE.MEME:
          topTraderMeme.assignAll(users);
          break;
        default:
      }
    });
  }

  void saveUserToRecent(User user) {
    final userKey = user.userKey;
    recentList.removeWhere((element) => element.userKey == userKey);
    recentList.insert(0, user);
    storage.write(
        key: 'savedUsers',
        value: recentList.map((element) => element.toJson()).toList());
  }

  Future<void> _onLoadTopInvestors(
      {QueryType queryType = QueryType.loadCache}) async {
    await repository.topInvestorsSuggestions(
      queryType: queryType,
      callback: (data) => onSuccessTopInvestors(data),
      onError: onError,
    );
  }

  Future<void> _onLoadUsers(FOLLOW_SUGGESTION_TYPE suggestionType,
      {QueryType queryType = QueryType.loadCache}) async {
    await repository.followSuggestions(
      suggestionType: suggestionType,
      cursor: getCursor(suggestionType),
      queryType: queryType,
      callback: (data) => onSuccess(data, type: suggestionType),
      onError: onError,
    );
  }
}

extension Rep<E> on List<E> {
  bool replaceIndex(E replacement, int index) {
    this[index] = replacement;
    return true;
  }
}

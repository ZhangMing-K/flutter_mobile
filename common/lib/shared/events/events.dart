import 'package:get/get.dart';

import '../../iris_common.dart';

//TODO: Change structure to modules to allow to use Workers inside
// your own GetxController
class Events {
  final userHide = Rx<UserHideEvent?>(null);
  final userSuspend = Rx<UserSuspendEvent?>(null);
  final userFollow = Rx<UserFollowEvent?>(null);
  final portfolioHide = Rx<PortfolioHideEvent?>(null);
  final textMute = Rx<TextMuteEvent?>(null);

  final portfoliosAdded = Rx<PortfoliosAddedEvent?>(null);
  final workspacePortfoliosUpdated = Rx<WorkspacePortfoliosUpdatedEvent?>(null);
  final portfoliosRemoved = Rx<PortfoliosRemovedEvent?>(null);
  final portfolioDeleted = Rx<PortfolioDeletedEvent?>(null);
  final workspaceBotUpdate = Rx<WorkspaceBotUpdateEvent?>(null);
  final workspacePermissionUpdate = Rx<WorkspacePermissionUpdateEvent?>(null);
  final workspaceUpdate = Rx<WorkspaceUpdateEvent?>(null);
}

class PortfolioDeletedEvent {
  Portfolio? portfolio;
  PortfolioDeletedEvent({this.portfolio});
}

class PortfolioHideEvent {
  TextModel? text;
  PortfolioHideEvent({this.text}); //change
}

class PortfoliosAddedEvent {
  List<Portfolio>? portfolios;
  PortfoliosAddedEvent({this.portfolios});
}

class PortfoliosRemovedEvent {
  List<Portfolio>? portfolios;
  PortfoliosRemovedEvent({this.portfolios});
}

enum TEXT_EVENT_TYPE {
  DELETE_TEXT,
  EDIT_TEXT,
  CREATE_TEXT,
  HIDE_TEXT,
  MUTE_TEXT
}

class TextCreateEvent {
  TextModel? text;
  API_STATUS? apiStatus;
  TextCreateEvent({this.text, this.apiStatus});
}

class TextDeleteEvent {
  TextModel? text;
  TextDeleteEvent({this.text});
}

class TextEditEvent {
  TextModel? text;
  API_STATUS? apiStatus;
  TextEditEvent({this.text, this.apiStatus});
}

class TextEvent {
  TEXT_EVENT_TYPE textEventType;
  TextModel? text;
  API_STATUS? apiStatus;
  TextEvent(this.textEventType, this.text, {this.apiStatus});
}

class TextMuteEvent {
  TextModel? text;
  TextMuteEvent({this.text}); //change
}

enum USER_EVENT_TYPE { EDIT_USER, SUSPEND_USER, HIDE_USER }

class UserEvent {
  DateTime? suspendedAt;
  UserRelation? authUserRelation;
  USER_EVENT_TYPE eventType;
  UserEvent(this.eventType, {this.suspendedAt, this.authUserRelation});
}

class UserFollowEvent {
  FOLLOW_STATUS? followStatus;
  UserFollowEvent({this.followStatus});
}

class UserHideEvent {
  User? user;
  UserHideEvent({this.user});
}

class UserSuspendEvent {
  User? user;
  UserSuspendEvent({this.user});
}

class WorkspaceBotUpdateEvent {
  Workspace? workspace;
  WorkspaceBotUpdateEvent({this.workspace});
}

class WorkspacePermissionUpdateEvent {
  Workspace? workspace;
  WorkspacePermissionUpdateEvent({this.workspace});
}

class WorkspacePortfoliosUpdatedEvent {
  List<Portfolio>? portfolios;
  int? workspaceKey;
  WorkspacePortfoliosUpdatedEvent({this.portfolios, this.workspaceKey});
}

class WorkspaceUpdateEvent {
  Workspace? workspace;
  WorkspaceUpdateEvent({this.workspace});
}

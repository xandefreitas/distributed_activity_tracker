import 'package:distributed_activity_tracker/common/models/activity.dart';

abstract class ActivityEvent extends Equatable {
  ActivityEvent();

  List<Object> get props => [];
}

class Equatable {}

class ActivityFetchEvent extends ActivityEvent {
  final String activityId;

  ActivityFetchEvent({required this.activityId});

  @override
  List<Object> get props => [activityId];
}

class ActivityRandomFetchEvent extends ActivityEvent {
  ActivityRandomFetchEvent();

  @override
  List<Object> get props => [];
}

class ActivityAddEvent extends ActivityEvent {
  final Activity activity;

  ActivityAddEvent({required this.activity});

  @override
  List<Object> get props => [activity];
}

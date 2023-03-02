import 'package:distributed_activity_tracker/common/models/activity.dart';

import 'activity_event.dart';

abstract class ActivityState extends Equatable {
  ActivityState();

  @override
  List<Object> get props => [];
}

abstract class ActivityLoadingState extends ActivityState {}

class ActivityInitial extends ActivityState {}

class ActivityFetchingState extends ActivityLoadingState {}

class ActivityFetchedState extends ActivityState {
  final Activity activity;

  ActivityFetchedState({required this.activity});

  @override
  List<Object> get props => [Activity];
}

class ActivityRandomFetchingState extends ActivityLoadingState {}

class ActivityRandomFetchedState extends ActivityState {
  final Activity activity;

  ActivityRandomFetchedState({required this.activity});

  @override
  List<Object> get props => [Activity];
}

class ActivityAddingState extends ActivityLoadingState {}

class ActivityAddedState extends ActivityState {
  final Activity response;

  ActivityAddedState({required this.response});

  @override
  List<Object> get props => [response];
}

class ActivityErrorState extends ActivityState {
  final String exception;
  final ActivityEvent event;

  ActivityErrorState({required this.exception, required this.event});

  @override
  List<Object> get props => [exception, event];
}

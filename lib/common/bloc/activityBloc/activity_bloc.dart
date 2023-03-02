import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/activity_webclient.dart';
import '../../util/error_util.dart';
import 'activity_event.dart';
import 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityWebClient activityWebClient;
  ActivityBloc()
      : activityWebClient = ActivityWebClient(),
        super(ActivityInitial()) {
    on<ActivityEvent>((event, emit) async {
      try {
        if (event is ActivityFetchEvent) {
          emit(ActivityFetchingState());
          final response = await activityWebClient.getActivityByKey(event.activityId);
          emit(ActivityFetchedState(activity: response));
        }
        if (event is ActivityRandomFetchEvent) {
          emit(ActivityRandomFetchingState());
          final response = await activityWebClient.getRandomActivity();
          emit(ActivityRandomFetchedState(activity: response));
        }
        if (event is ActivityAddEvent) {
          emit(ActivityAddingState());
          final response = await activityWebClient.submitSuggestion(event.activity);
          emit(ActivityAddedState(response: response));
        }
      } catch (e) {
        emit(ActivityErrorState(exception: ErrorUtil.validateException(e), event: event));
      }
    });
  }
}

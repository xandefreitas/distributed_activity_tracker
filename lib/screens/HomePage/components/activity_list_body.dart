import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/bloc/activityBloc/activity_bloc.dart';
import '../../../common/bloc/activityBloc/activity_state.dart';
import '../../../common/enums/activity_type_enum.dart';
import '../../../common/models/activity.dart';
import '../../../common/widgets/CustomSnackBar/custom_snackbar.dart';
import 'activity_list_item.dart';

class ActivityListBody extends StatefulWidget {
  final Function(bool) showActionButton;
  final String filterSelected;
  const ActivityListBody({
    super.key,
    required this.showActionButton,
    required this.filterSelected,
  });

  @override
  State<ActivityListBody> createState() => _ActivityListBodyState();
}

class _ActivityListBodyState extends State<ActivityListBody> {
  final List<Activity> activitiesList = [];
  final _scrollController = ScrollController();
  late double screenWidth;

  @override
  void initState() {
    _scrollController.addListener(() {
      setState(() {
        _scrollController.position.pixels < _scrollController.position.maxScrollExtent
            ? widget.showActionButton(false)
            : widget.showActionButton(true);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<ActivityBloc, ActivityState>(
      listener: (context, state) {
        if (state is ActivityAddedState) {
          if (activityNotInList(state.response)) {
            activitiesList.add(state.response);
            GoRouter.of(context).pop();
            showSuccessSnackBar('Activity added: ${state.response.activity}');
          } else {
            showAlertSnackBar('Activity key is already on the list');
          }
        }
      },
      builder: (context, state) {
        return Align(
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isLargeScreen ? screenWidth * 0.5 : double.infinity),
                child: ListView(controller: _scrollController, children: [
                  const SizedBox(
                    height: 16,
                  ),
                  ...activitiesList.where((element) {
                    if (widget.filterSelected == '') {
                      return true;
                    }
                    return element.type == widget.filterSelected;
                  }).map((e) {
                    final Color color = getActivityColor(e.type);
                    return ActivityListItem(
                      activity: e,
                      deleteActivity: deleteActivity,
                      updateActivity: updateActivity,
                      color: color,
                    );
                  }).toList(),
                ]),
              ),
              Visibility(
                visible: activitiesList.where((element) {
                  if (widget.filterSelected == '') {
                    return true;
                  }
                  return element.type == widget.filterSelected;
                }).isEmpty,
                child: Center(
                  child: const Text("No activities here yet, why don't you add some?").animate().fadeIn(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Color getActivityColor(String type) {
    return ActivityType.values.firstWhere((element) => element.value == type, orElse: () => ActivityType.blank).color;
  }

  void updateActivity(Activity activity) {
    for (var element in activitiesList) {
      if (element.key == activity.key) {
        element
          ..accessibility = activity.accessibility
          ..activity = activity.activity
          ..link = activity.link
          ..participants = activity.participants
          ..price = activity.price
          ..type = activity.type;
      }
    }
    showSuccessSnackBar('Activity updated: ${activity.activity}');
  }

  void deleteActivity(Activity activity) {
    setState(() {
      activitiesList.removeWhere((element) => element.key == activity.key);
    });
    popPage();
    showSuccessSnackBar('Activity deleted: ${activity.activity}');
  }

  void popPage() {
    GoRouter.of(context).pop();
  }

  void showSuccessSnackBar(String response) {
    hideSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SuccessSnackBar(
      title: 'Success!',
      subtitle: response,
      width: isLargeScreen ? screenWidth * 0.5 : double.infinity,
    ));
  }

  void showAlertSnackBar(String response) {
    hideSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(AlertSnackBar(
      title: 'Warning!',
      subtitle: response,
      width: isLargeScreen ? screenWidth * 0.5 : double.infinity,
    ));
  }

  void hideSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  bool activityNotInList(Activity activity) => !activitiesList.any((element) => element.key.contains(activity.key));

  bool get isLargeScreen => screenWidth > 620;
}

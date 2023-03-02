import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/bloc/activityBloc/activity_bloc.dart';
import '../../../common/bloc/activityBloc/activity_event.dart';
import '../../../common/models/activity.dart';

class ActivityAddButton extends StatefulWidget {
  const ActivityAddButton({
    super.key,
    required this.isEndOfTheList,
  });

  final bool isEndOfTheList;

  @override
  State<ActivityAddButton> createState() => _ActivityAddButtonState();
}

class _ActivityAddButtonState extends State<ActivityAddButton> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !widget.isEndOfTheList,
      child: FloatingActionButton(
        backgroundColor: Colors.deepOrange[300],
        onPressed: () => context.go(
          '/activity/new',
          extra: {'addNewActivity': addNewActivity},
        ),
        child: const Icon(Icons.add),
      ).animate().fadeIn().moveY(begin: 40).scaleXY(),
    );
  }

  addNewActivity(Activity activity) async {
    context.read<ActivityBloc>().add(ActivityAddEvent(activity: activity));
  }
}

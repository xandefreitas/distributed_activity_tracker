import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../common/models/activity.dart';

class ActivityListItem extends StatelessWidget {
  final Activity activity;
  final Color color;
  final Function(Activity) updateActivity;
  final Function(Activity) deleteActivity;

  const ActivityListItem({
    super.key,
    required this.activity,
    required this.color,
    required this.updateActivity,
    required this.deleteActivity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 8.0, right: 8.0),
      child: Material(
        elevation: 4,
        shadowColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: color,
          ),
        ),
        child: ListTile(
          title: Text(
            activity.activity,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            activity.type,
            style: TextStyle(color: color),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {
            context.go(
              '/activity/${activity.key}',
              extra: {
                'activity': activity,
                'updateActivity': updateActivity,
                'deleteActivity': deleteActivity,
                'color': color,
              },
            );
          },
        ),
      ),
    ).animate().moveX(begin: -320, curve: Curves.easeInCubic, duration: 400.ms).fadeIn();
  }
}

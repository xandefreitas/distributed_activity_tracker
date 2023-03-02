import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/models/activity.dart';
import '../../common/widgets/activity_form.dart';
import 'components/edit_activity_button.dart';

class ActivityPage extends StatefulWidget {
  final Activity activity;
  final Color color;
  final Function(Activity) updateActivity;
  final Function(Activity) deleteActivity;
  const ActivityPage({
    super.key,
    required this.activity,
    required this.color,
    required this.updateActivity,
    required this.deleteActivity,
  });

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: const Text('Activity Page'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () {
            GoRouter.of(context).pop();
          },
        ),
        actions: [
          EditActivityButton(
            isEditable: isEditable,
            onTap: onTap,
          ),
        ],
      ),
      body: ActivityForm(
        activity: widget.activity,
        isEditable: isEditable,
        callAction: isEditable ? widget.updateActivity : widget.deleteActivity,
      ),
    );
  }

  onTap() {
    setState(() {
      isEditable = !isEditable;
    });
  }
}

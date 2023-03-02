import 'package:distributed_activity_tracker/common/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../common/widgets/activity_form.dart';
import 'components/about_suggestion_button.dart';

class AddActivityPage extends StatelessWidget {
  final Function(Activity) addNewActivity;
  const AddActivityPage({
    super.key,
    required this.addNewActivity,
  });

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Activity'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrange[300],
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () {
            GoRouter.of(context).pop();
          },
        ),
        actions: const [
          AboutSuggestionButton(),
        ],
      ),
      body: ActivityForm(
        callAction: addNewActivity,
        isEditable: true,
        isAddingForm: true,
      ),
    );
  }
}

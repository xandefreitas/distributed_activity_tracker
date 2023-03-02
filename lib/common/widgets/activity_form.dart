import 'dart:math';

import 'package:distributed_activity_tracker/common/bloc/activityBloc/activity_bloc.dart';
import 'package:distributed_activity_tracker/common/bloc/activityBloc/activity_event.dart';
import 'package:distributed_activity_tracker/common/widgets/base_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_colors.dart';
import '../bloc/activityBloc/activity_state.dart';
import '../enums/activity_type_enum.dart';
import '../models/activity.dart';
import '../util/url_launcher_util.dart';
import 'CustomSnackBar/custom_snackbar.dart';
import 'activity_form_button.dart';

class ActivityForm extends StatefulWidget {
  final Activity? activity;
  final Function(Activity) callAction;
  final bool isEditable;
  final bool isAddingForm;

  const ActivityForm({
    required this.callAction,
    super.key,
    this.activity,
    this.isEditable = false,
    this.isAddingForm = false,
  });

  @override
  State<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  final _activityController = TextEditingController();
  final _typeController = TextEditingController();
  final _participantsController = TextEditingController();
  final _priceController = TextEditingController();
  final _linkController = TextEditingController();
  final _keyController = TextEditingController();
  final _accessibilityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Activity formActivity;
  late Size screenSize;
  bool _isLoading = false;

  @override
  void initState() {
    if (!widget.isAddingForm && widget.activity != null) {
      getFormInitialData(widget.activity!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityBloc, ActivityState>(
      listener: (context, state) {
        if (state is ActivityAddingState) {
          _isLoading = true;
        }
        if (state is ActivityRandomFetchingState) {
          _isLoading = true;
        }
        if (state is ActivityRandomFetchedState) {
          getFormInitialData(state.activity);
        }
        if (state is ActivityErrorState) {
          showErrorSnackBar(state.exception);
          _isLoading = false;
        }
      },
      builder: (context, state) {
        screenSize = MediaQuery.of(context).size;
        return _isLoading
            ? Center(
                child: Icon(
                  Icons.sync,
                  size: 40,
                  color: Colors.deepOrange[300],
                )
                    .animate(
                      onPlay: (controller) => controller.loop(period: 800.ms),
                    )
                    .rotate(begin: 1.0)
                    .fadeOut(),
              )
            : Form(
                key: _formKey,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: isLargeScreen ? screenSize.width * 0.75 : double.infinity),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _activityController,
                              decoration: const InputDecoration(
                                label: Text('activity'),
                                isDense: true,
                              ),
                              enabled: widget.isEditable,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: DropdownButton(
                                isExpanded: true,
                                hint: const Text('type'),
                                value: _typeController.text == '' ? null : _typeController.text,
                                items: ActivityType.values
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.value,
                                        child: Text(e.value),
                                      ),
                                    )
                                    .toList(),
                                onChanged: !widget.isEditable
                                    ? null
                                    : (value) {
                                        setState(() {
                                          if (value is String) {
                                            _typeController.text = value;
                                          }
                                        });
                                      },
                              ),
                            ),
                            TextFormField(
                              controller: _participantsController,
                              decoration: const InputDecoration(
                                label: Text('participants'),
                                isDense: true,
                              ),
                              enabled: widget.isEditable,
                            ),
                            TextFormField(
                              controller: _priceController,
                              decoration: const InputDecoration(
                                label: Text('price'),
                                isDense: true,
                              ),
                              enabled: widget.isEditable,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _linkController,
                                    decoration: const InputDecoration(
                                      label: Text('link'),
                                      isDense: true,
                                    ),
                                    enabled: widget.isEditable,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    UrlLauncherUtil().launchUrlLink(widget.activity?.link ?? '', showErrorSnackBar);
                                  },
                                  child: const Icon(Icons.open_in_new),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: _keyController.text.isNotEmpty,
                              child: TextFormField(
                                controller: _keyController,
                                decoration: const InputDecoration(
                                  label: Text('key'),
                                  isDense: true,
                                ),
                                enabled: false,
                              ),
                            ),
                            TextFormField(
                              controller: _accessibilityController,
                              decoration: const InputDecoration(
                                label: Text('accessibility'),
                                isDense: true,
                              ),
                              enabled: widget.isEditable,
                            ),
                            const SizedBox(height: 24),
                            Visibility(
                              visible: widget.isAddingForm,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: BaseButton(
                                        color: AppColors.white,
                                        icon: Icons.clear,
                                        onPressed: () {
                                          clearActivityForm();
                                        },
                                        buttonText: 'Clear Activity',
                                        textColor: Colors.orange,
                                        iconEffects: [
                                          FadeEffect(delay: 1000.ms, duration: 2400.ms, end: 0),
                                        ],
                                      ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      flex: 1,
                                      child: BaseButton(
                                        color: AppColors.white,
                                        onPressed: () {
                                          getRandomActivity();
                                        },
                                        buttonText: 'Randomize',
                                        textColor: Colors.purple[800],
                                        icon: Icons.casino,
                                        iconEffects: [ShakeEffect(delay: 1000.ms, duration: 2400.ms, curve: Curves.fastOutSlowIn, hz: 4)],
                                      ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
                                    ),
                                    if (widget.isAddingForm && isLargeScreen) const SizedBox(width: 8),
                                    if (widget.isAddingForm && isLargeScreen)
                                      Flexible(
                                        flex: 1,
                                        child: ActivityFormButton(
                                          isAddingForm: widget.isAddingForm,
                                          isEditable: widget.isEditable,
                                          onPressed: () {
                                            setFormActivity();
                                            widget.callAction(formActivity);
                                          },
                                        ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !widget.isAddingForm || !isLargeScreen,
                              child: ActivityFormButton(
                                isAddingForm: widget.isAddingForm,
                                isEditable: widget.isEditable,
                                onPressed: () {
                                  setFormActivity();
                                  widget.callAction(formActivity);
                                },
                              ).animate().fadeIn(delay: widget.isAddingForm ? 800.ms : 400.ms, duration: 600.ms),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ).animate().fadeIn();
      },
    );
  }

  void setFormActivity() {
    formActivity = Activity(
      activity: _activityController.text,
      type: _typeController.text,
      participants: int.tryParse(_participantsController.text) ?? 0,
      price: double.tryParse(_priceController.text) ?? 0.0,
      link: _linkController.text,
      key: _keyController.text != '' ? _keyController.text : Random().nextInt(10000).toString(),
      accessibility: double.tryParse(_accessibilityController.text) ?? 0.0,
    );
  }

  void getFormInitialData(Activity initialActivity) {
    _activityController.text = initialActivity.activity;
    _typeController.text = initialActivity.type;
    _participantsController.text = initialActivity.participants.toString();
    _priceController.text = initialActivity.price.toString();
    _linkController.text = initialActivity.link ?? '';
    _keyController.text = initialActivity.key;
    _accessibilityController.text = initialActivity.accessibility.toString();
    _isLoading = false;
  }

  void showErrorSnackBar(String response) {
    hideSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(
      title: 'Ops!',
      subtitle: response,
      width: isLargeScreen ? screenSize.width * 0.5 : double.infinity,
    ));
  }

  void clearActivityForm() {
    setState(() {
      _activityController.clear();
      _typeController.clear();
      _participantsController.clear();
      _priceController.clear();
      _linkController.clear();
      _keyController.clear();
      _accessibilityController.clear();
    });
  }

  void getRandomActivity() async {
    context.read<ActivityBloc>().add(ActivityRandomFetchEvent());
  }

  void hideSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  bool get isLargeScreen => screenSize.width > 620;
}

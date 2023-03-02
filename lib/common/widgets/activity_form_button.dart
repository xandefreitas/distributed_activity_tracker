import 'package:distributed_activity_tracker/common/widgets/base_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ActivityFormButton extends StatelessWidget {
  const ActivityFormButton({
    super.key,
    required this.isAddingForm,
    required this.isEditable,
    required this.onPressed,
  });

  final bool isAddingForm;
  final bool isEditable;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      buttonText: getButtonText(),
      icon: getButtonIcon(),
      onPressed: onPressed,
      color: getButtonColor(),
      iconEffects: [
        if (isAddScreen) ...[
          const FadeEffect(),
          MoveEffect(delay: 5000.ms, end: const Offset(80, 0), duration: 1600.ms),
        ],
        if (isUpdateScreen) RotateEffect(delay: 5000.ms, duration: 1600.ms),
        if (isDeleteScreen) ...[
          FadeEffect(delay: 800.ms, duration: 1600.ms),
          BlurEffect(delay: 5000.ms, duration: 1600.ms),
          Effect(delay: 1600.ms),
        ]
      ],
    );
  }

  String getButtonText() {
    if (isUpdateScreen) {
      return 'Update';
    }
    if (isAddScreen) {
      return 'Submit';
    }
    if (isDeleteScreen) {
      return 'Delete';
    }
    return '';
  }

  IconData getButtonIcon() {
    final text = getButtonText();
    switch (text) {
      case 'Update':
        return Icons.update;
      case 'Submit':
        return Icons.send;
      case 'Delete':
        return Icons.delete;
      default:
        return Icons.send;
    }
  }

  Color? getButtonColor() {
    final text = getButtonText();
    switch (text) {
      case 'Update':
        return Colors.grey[800];
      case 'Submit':
        return Colors.blue[800];
      case 'Delete':
        return Colors.red[800];
      default:
        return Colors.blue;
    }
  }

  bool get isUpdateScreen => isEditable && !isAddingForm;
  bool get isAddScreen => isAddingForm;
  bool get isDeleteScreen => !isEditable;
}

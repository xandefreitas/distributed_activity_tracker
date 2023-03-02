import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EditActivityButton extends StatelessWidget {
  const EditActivityButton({
    super.key,
    required this.isEditable,
    required this.onTap,
  });

  final bool isEditable;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: isEditable
            ? const Icon(Icons.edit_outlined, color: Colors.black26)
            : const Icon(Icons.edit)
                .animate(
                  onPlay: (controller) => controller.loop(count: 4),
                )
                .shake(),
      ),
    );
  }
}

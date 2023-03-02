import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BaseButton extends StatelessWidget {
  final String buttonText;
  final IconData icon;
  final Function() onPressed;
  final Color? color;
  final Color? textColor;
  final List<Effect>? iconEffects;

  const BaseButton({
    super.key,
    required this.buttonText,
    required this.icon,
    required this.onPressed,
    this.color,
    this.textColor,
    this.iconEffects,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: () {
        onPressed();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              buttonText,
              overflow: TextOverflow.fade,
              style: TextStyle(color: textColor),
            ),
            Animate(
              onPlay: (controller) => controller.loop(),
              effects: iconEffects,
              child: Icon(
                icon,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

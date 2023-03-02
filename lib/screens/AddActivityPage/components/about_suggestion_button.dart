import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutSuggestionButton extends StatelessWidget {
  const AboutSuggestionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.help,
                      size: 40,
                      color: Colors.deepOrange[300],
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              text: "Listed here are some guidelines to help with your submission:\n\n"),
                          TextSpan(
                              style: TextStyle(fontWeight: FontWeight.w600),
                              text:
                                  "- Activities should start with a verb in the form of a command (ex. 'Research ...', 'Invite ...', 'Create ...').\n"),
                          TextSpan(
                              style: TextStyle(fontWeight: FontWeight.w600),
                              text: "- Try to keep the activities general and without references to companies or name brand products\n\n"),
                          TextSpan(text: "Thank you again so much for your contribution! Contributors like you make this project possible."),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: const Icon(Icons.help)
            .animate(
              onPlay: (controller) => controller.loop(reverse: true, period: 1200.ms),
            )
            .shake()
            .scaleXY(end: 1.2),
      ),
    );
  }
}

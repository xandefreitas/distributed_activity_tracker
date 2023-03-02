import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/app_colors.dart';

class CustomSnackBarBody extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color? snackBarColor;
  const CustomSnackBarBody({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.snackBarColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: AppColors.white,
        ),
        color: snackBarColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  subtitle,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              icon,
              size: 40,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().moveX(delay: 400.ms, begin: MediaQuery.of(context).size.width, curve: Curves.fastOutSlowIn);
  }
}

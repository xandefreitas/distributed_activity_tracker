import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

enum ActivityType {
  blank('', AppColors.black, Icons.list),
  education('education', AppColors.education, Icons.menu_book),
  recreational('recreational', AppColors.recreational, Icons.gamepad),
  social('social', AppColors.social, Icons.person),
  diy('diy', AppColors.diy, Icons.handyman),
  charity('charity', AppColors.charity, Icons.card_giftcard),
  cooking('cooking', AppColors.cooking, Icons.dinner_dining),
  relaxation('relaxation', AppColors.relaxation, Icons.bed),
  music('music', AppColors.music, Icons.music_note),
  busywork('busywork', AppColors.busywork, Icons.work);

  final String value;
  final Color color;
  final IconData icon;
  const ActivityType(this.value, this.color, this.icon);
}

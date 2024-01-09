import 'package:flutter/material.dart';
import 'package:imdb_bloc/utils/colors.dart';

class AppTypography {
  AppTypography._();

  static const title = TextStyle(
    fontSize: 20,
    height: 24 / 20,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static const text = TextStyle(
    fontSize: 16,
    height: 20 / 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static const smallText = TextStyle(
    fontSize: 14,
    height: 18 / 14,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static final smallTextSecondary = smallText.copyWith(
    color: AppColors.grey,
  );
}

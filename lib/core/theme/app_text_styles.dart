import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get heading =>
      GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textColor);

  static TextStyle get bodyLarge =>
      GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textColor);

  static TextStyle get bodyMedium =>
      GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textColor);

  static TextStyle get bodySmall =>
      GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textColor);

  static TextStyle get hint =>
      GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.hintTextColor);

  static TextStyle get button =>
      GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white);

  static TextStyle get tabActive =>
      GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.white);

  static TextStyle get tabInactive =>
      GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.hintTextColor);

  static TextStyle get moodLabel =>
      GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textColor);

  static TextStyle get sliderLabel =>
      GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.hintTextColor);

  static TextStyle get chipSelected =>
      GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.white);

  static TextStyle get chipUnselected =>
      GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textColor);

  static TextStyle get calendarMonth =>
      GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textColor);

  static TextStyle get calendarYear =>
      GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.hintTextColor);

  static TextStyle get calendarDay =>
      GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textColor);

  static TextStyle get calendarWeekday =>
      GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.hintTextColor);

  static TextStyle get dateTime =>
      GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.hintTextColor);
}

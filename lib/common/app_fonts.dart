import 'package:flutter/material.dart';

import 'app_colors.dart';


class AppFonts{
  static const String pretendard = 'Pretendard';
  static const String scdream = 'SCDream';

  static const FontWeight extraBold = FontWeight.w900;
  static const FontWeight bold = FontWeight.w800;
  static const FontWeight semiBold = FontWeight.w700;
  static const FontWeight medium = FontWeight.w600;
  static const FontWeight regular = FontWeight.w500;
  static const FontWeight light = FontWeight.w400;
  static const FontWeight extraLight = FontWeight.w300;
  static const FontWeight thin = FontWeight.w200;



  //Pretendard

  static TextStyle preExtraBold(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
        fontFamily: pretendard,
        fontWeight: extraBold,
        fontSize: size,
        color: color,
        decoration: TextDecoration.none,
    );
  }

  static TextStyle preBold(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
      fontFamily: pretendard,
      fontWeight: bold,
      fontSize: size,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle preSemiBold(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
      fontFamily: pretendard,
      fontWeight: semiBold,
      fontSize: size,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle preMedium(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
      fontFamily: pretendard,
      fontWeight: medium,
      fontSize: size,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle preRegular(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
      fontFamily: pretendard,
      fontWeight: regular,
      fontSize: size,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle preLight(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
      fontFamily: pretendard,
      fontWeight: light,
      fontSize: size,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle preExtraLight(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
      fontFamily: pretendard,
      fontWeight: extraLight,
      fontSize: size,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle preThin(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
      fontFamily: pretendard,
      fontWeight: thin,
      fontSize: size,
      color: color,
      decoration: TextDecoration.none,
    );
  }


  //SCDream

  static TextStyle scdExtraBold(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
      fontFamily: scdream,
      fontWeight: extraBold,
      fontSize: size,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle scdBold(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
      fontFamily: scdream,
      fontWeight: bold,
      fontSize: size,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle scdSemiBold(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
      fontFamily: scdream,
      fontWeight: semiBold,
      fontSize: size,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle scdMedium(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
      fontFamily: scdream,
      fontWeight: medium,
      fontSize: size,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle scdRegular(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
      fontFamily: scdream,
      fontWeight: regular,
      fontSize: size,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle scdLight(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
      fontFamily: scdream,
      fontWeight: light,
      fontSize: size,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle scdExtraLight(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
      fontFamily: scdream,
      fontWeight: extraLight,
      fontSize: size,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle scdThin(
      {double size = 18.0, Color color = AppColors.darkGray}) {
    return TextStyle(
      fontFamily: scdream,
      fontWeight: thin,
      fontSize: size,
      color: color,
      decoration: TextDecoration.none,
    );
  }

}
import 'package:flutter/material.dart';

import '../app_color.dart';
import 'dimens.dart';


class AppTextStyle {
  const AppTextStyle._();

  static const TextStyle _textStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontFamily: "Quicksand");

  static final TextStyle semiBoldStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize16,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle semiBoldMediumStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize18,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle semiBoldBigStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize20,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle semiBoldTitleStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize18,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle smallBoldStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize14,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle mediumBoldStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize18,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize22,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle moneyBoldStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize30,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle regularStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize14,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle smallStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize18,
    fontWeight: FontWeight.w300,
  );
  static final TextStyle regularBlandStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize14,
    color: AppColors.kBlackLight,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle buttonTextStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize16,
    fontWeight: FontWeight.w700,
  );

  //Phần text add

  static TextStyle conditionStyle = TextStyle(
      color: AppColors.kPrimaryColor,
      fontWeight: FontWeight.w500,
      fontSize: Dimens.fontSize14,
      fontFamily: "Quicksand");
  static TextStyle conditionNomalStyle = TextStyle(
      color: AppColors.doveGray,
      fontWeight: FontWeight.w400,
      fontSize: Dimens.fontSize14,
      fontFamily: "Quicksand");

  static final TextStyle textButtonSmallStyle = _textStyle.copyWith(
      color: Colors.white,
      fontSize: Dimens.fontSize14,
      fontWeight: FontWeight.w500);

  static final TextStyle bodyStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize18,
  );
  static final TextStyle bodySmallStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize16,
  );
  static final TextStyle bodySmall14Style = _textStyle.copyWith(
    fontSize: Dimens.fontSize14,
  );
  static final TextStyle bodySmallDescriptionStyle = _textStyle.copyWith(
      fontSize: Dimens.fontSize12, color: AppColors.kBlackLight);

  static final TextStyle bodyStyle500 = TextStyle(
      color: Colors.black,
      fontSize: Dimens.fontSize18,
      fontWeight: FontWeight.w500);

  static final TextStyle bodyMediumStyle500 = TextStyle(
      color: Colors.black,
      fontSize: Dimens.fontSize16,
      fontWeight: FontWeight.w500);
  static final TextStyle bodySmallStyle500 =
      TextStyle(fontSize: Dimens.fontSize14, fontWeight: FontWeight.w500);

  static final TextStyle textChartSmallStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize10,
  );
  static final TextStyle bodySmallLightStyle = _textStyle.copyWith(
      fontSize: Dimens.fontSize16, color: AppColors.kBlackLight);

  static final TextStyle descriptionStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize16,
  );
  static TextStyle bottomStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle blandBodyStyle = TextStyle(
      color: AppColors.kBlackLight,
      fontWeight: FontWeight.w500,
      fontSize: Dimens.fontSize16,
      fontFamily: "Quicksand");

  static final TextStyle textDescriptionStyle = _textStyle.copyWith(
      color: Colors.black,
      fontSize: Dimens.fontSize12,
      fontWeight: FontWeight.w500);
}

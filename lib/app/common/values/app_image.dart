import 'package:flutter/material.dart';
import 'style/dimens.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImages {
  ///add app images here
  const AppImages._();

  static SizedBox svg(
    String name, {
    Color? color,
    double? width,
    double? height,
    Widget Function(BuildContext context)? placeholderBuilder,
    String defaultImage = "",
    BoxFit fit = BoxFit.contain,
  }) {
    return SizedBox(
      width: width ?? Dimens.fontSize20,
      height: height ?? Dimens.fontSize20,
      child: SvgPicture.asset(
        name,
        color: color,
        fit: fit,
        allowDrawingOutsideViewBox: true,
      ),
    );
  }

  static const Map<String, List<double>> _svgImageSize = {};

  static Widget svgUrl(String name,
      {Color? color,
      double? width,
      double? height,
      BoxFit fit = BoxFit.contain,
      bool circle = false,
      Widget? placeholderWidget,
      Map<String, String>? header,
      EdgeInsets padding = const EdgeInsets.all(6.0)}) {
    return Padding(
      padding: padding,
      child: SvgPicture.network(
        name,
        color: color,
        placeholderBuilder: (context) => placeholderWidget ?? Container(),
        width: width,
        height: height,
        fit: fit,
        headers: header,
      ),
    );
  }

  //auth
  static const String user_icon = 'assets/icons/user_icon.svg';
  static const String home_icon = 'assets/icons/home_icon.svg';
  static const String login = 'assets/images/login.svg';
  static const String bulb = 'assets/images/bulb.svg';
  static const String drum = 'assets/images/drum.svg';
  static const String error = 'assets/images/error.svg';
}

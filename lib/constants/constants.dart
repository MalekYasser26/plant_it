
import 'package:flutter/material.dart';

double getResponsiveSize(BuildContext context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = scaleFactor * fontSize;
  double lowerLimit = fontSize * 0.8;
  double upperLimit = fontSize * 1.2;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double w = MediaQuery.of(context).size.width;
  if (w <= 550) {
    return w / 400; // Mobile breakpoint
  } else if (w <= 900) {
    return w / 700; // Tablet breakpoint
  } else {
    return w / 1000; // Desktop breakpoint
  }
}
  abstract class AppColors {
  static const Color darkGreen= const Color(0xFF267168);
  static const Color darkGreenL= const Color(0xFF2B7D74);
  static const Color normGreen= const Color(0xFF4C9A8D);
  static const Color lightGreen= const Color(0xFF6FA59E);
  static const Color lighterGreen= const Color(0xFF92B9A4);
  static const Color barelyGreen= const Color(0xFFB7D7B2);
  static const Color basicallyWhite= const Color(0xFFEFF0EA);
  static const Color greyish= const Color(0xFFD3D3D3);
}
abstract class ImagesCust{
  static const String logo = "assets/images/logo.png";
  static const String facebookLogo = "assets/images/facebookLogo.png";
  static const String googleLogo = "assets/images/googleLogo.png";
}
String? accesstoken;
const String baseUrl = 'https://e078-197-43-97-29.ngrok-free.app/api';


import 'package:flutter/material.dart';
import 'package:plant_it/features/cart/presentation/views/cart_view.dart';
import 'package:plant_it/features/favourites/presentation/views/favourites_view.dart';
import 'package:plant_it/features/home/presentation/views/home_view.dart';
import 'package:plant_it/features/profile/presentation/views/profile_view.dart';

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
  static const Color offWhite= const Color(0xFFF8F9EF);
}
abstract class ImagesCust{
  static const String logo = "assets/images/logo.png";
  static const String facebookLogo = "assets/images/facebookLogo.png";
  static const String googleLogo = "assets/images/googleLogo.png";
}
abstract class IconsCust{
  static const String cartIcon = "assets/icons/cart_icon.svg";
  static const String favIcon = "assets/icons/fav_icon.svg";
  static const String homeIcon = "assets/icons/home_icon.svg";
  static const String profileIcon = "assets/icons/profile_icon.svg";
}
final List<Widget> pages = [
  const ProfileView(),
  const HomeView(),
  const FavouritesView(),
  const CartView(),
];
String? accesstoken;
const String baseUrl = 'https://e078-197-43-97-29.ngrok-free.app/api';


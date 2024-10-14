import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:plant_it/features/auth/presentation/views/log_in_view.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:plant_it/features/cust_nav_bar/presentation/views/cust_nav_bar_selection_view.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_cubit.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_plants_cubit.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product_cubit.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:plant_it/features/ratings_cubit/ratings_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override


  Widget build(BuildContext context) {
    var sCubit = context.read<AuthCubit>();
    var pCubit = context.read<ProfileCubit>();
    var hCubit = context.read<HomeProductsCubit>();
    var rCubit = context.read<RatingsCubit>();
    var lCubit = context.read<LikedPlantsCubit>();
    var l2Cubit = context.read<LikedCubit>();
    var cCubit = context.read<CartCubit>();
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.darkGreen,
                  AppColors.darkGreenL,
                  AppColors.normGreen,
                  AppColors.lightGreen,
                  AppColors.lighterGreen,
                  AppColors.barelyGreen,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: ()async {
                  final prefs = await SharedPreferences.getInstance();
                  if (prefs.getString("accessToken") != null &&
                      prefs.getString("accessToken")!.isNotEmpty) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              CustNavBarSelectionView(currentIndex: 1)),
                    );
                    lCubit.getRecentlyLikedProducts(sCubit.userID, true);
                    pCubit.getRecentlySavedProducts(true);
                    hCubit.fetchProducts(
                        l2Cubit.getLikedProducts(sCubit.userID), true);
                    lCubit.getProductSuggestions(true);
                    pCubit.getRecentlyPurchasedProducts(true, sCubit.userID);
                    cCubit.getCartItems();
                    rCubit.getProductRatings(true);
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()));
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 100,
                  ),
                  backgroundColor: AppColors.basicallyWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: getResponsiveSize(context, fontSize: 18),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: AppColors.darkGreenL,
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagesCust.logo,
                height: 97,
                width: 100,
              ),
              Text(
                "Plant-it",
                style: TextStyle(
                    fontSize: getResponsiveSize(context, fontSize: 32),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

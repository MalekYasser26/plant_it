import 'dart:async'; // For Timer
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
  bool _visible = true; // Initial state
  late Timer _timer;    // Timer to toggle animation

  @override
  void initState() {
    super.initState();
    _startFadingAnimation();
    var sCubit = context.read<AuthCubit>();
    var pCubit = context.read<ProfileCubit>();
    var hCubit = context.read<HomeProductsCubit>();
    var rCubit = context.read<RatingsCubit>();
    var lCubit = context.read<LikedPlantsCubit>();
    var l2Cubit = context.read<LikedCubit>();
    var cCubit = context.read<CartCubit>();
    _checkAuthenticationAndLoadData(sCubit, pCubit, hCubit, rCubit, lCubit, l2Cubit, cCubit);
  }

  // Start the fading animation loop
  void _startFadingAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _visible = !_visible; // Toggle visibility every second
        });
      }
    });
  }

  // Stop the animation when data is fully loaded
  void _stopFadingAnimation() {
    _timer.cancel(); // Stop the periodic timer
  }

  // Asynchronously check authentication and load data
  Future<void> _checkAuthenticationAndLoadData(
      AuthCubit sCubit,
      ProfileCubit pCubit,
      HomeProductsCubit hCubit,
      RatingsCubit rCubit,
      LikedPlantsCubit lCubit,
      LikedCubit l2Cubit,
      CartCubit cCubit
      ) async {
    final prefs = await SharedPreferences.getInstance();
    int? userID = prefs.getInt("userID");

    // Move cubit initialization outside async gaps

    if (prefs.getString("accessToken") != null &&
        prefs.getString("accessToken")!.isNotEmpty) {
      await sCubit.refreshToken();
      await lCubit.getRecentlyLikedProducts(userID!, true);
      await pCubit.getRecentlySavedProducts(true);
      await hCubit.fetchProducts(
          l2Cubit.getLikedProducts(userID), true);
      await lCubit.getProductSuggestions(true);
      await pCubit.getRecentlyPurchasedProducts(true, userID);
      await cCubit.getCartItems();
      await rCubit.getProductRatings(true);

      _stopFadingAnimation();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => CustNavBarSelectionView(currentIndex: 1)),
        );
      }
    } else {
      Timer(const Duration(seconds: 5), () {
        _stopFadingAnimation();
        if (mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const LoginView()));
        }
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Dispose of the timer when the widget is destroyed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          AnimatedOpacity(
            opacity: _visible ? 1 : 0, // Use the toggling _visible value
            duration: const Duration(seconds: 1),
            child: Column(
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
          ),
        ],
      ),
    );
  }
}

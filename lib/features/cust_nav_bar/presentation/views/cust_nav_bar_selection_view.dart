import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/cart/presentation/views/cart_view.dart';
import 'package:plant_it/features/cust_nav_bar/presentation/views/cust_nav_bar_view.dart';
import 'package:plant_it/features/favourites/presentation/views/favourites_view.dart';
import 'package:plant_it/features/home/presentation/views/home_view.dart';
import 'package:plant_it/features/profile/presentation/views/profile_view.dart';

class CustNavBarSelectionView extends StatefulWidget {
  @override
  _CustNavBarSelectionViewState createState() => _CustNavBarSelectionViewState();
}

class _CustNavBarSelectionViewState extends State<CustNavBarSelectionView> {
  int _currentIndex = 0;

  // Define the pages you want to navigate between
  final List<Widget> _pages = [
    const ProfileView(),
    const HomeView(),
    const FavouritesView(),
    const CartView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.basicallyWhite,
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
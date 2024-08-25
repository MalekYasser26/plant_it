import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/cust_nav_bar/presentation/views/cust_nav_bar_view.dart';

class CustNavBarSelectionView extends StatefulWidget {
   int currentIndex ;

   CustNavBarSelectionView({super.key, required this.currentIndex});
  @override
  _CustNavBarSelectionViewState createState() => _CustNavBarSelectionViewState();
}

class _CustNavBarSelectionViewState extends State<CustNavBarSelectionView> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.basicallyWhite,
      body: pages[widget.currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
      ),
    );
  }
}
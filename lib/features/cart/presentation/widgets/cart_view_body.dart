import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/cart/presentation/widgets/cart_filled.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: CustAppBar(text: "Your cart",
        implyLeading: false,
        ),
        body:  const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: CartFilled()
          ),
        ),
      ),
    );
  }
}



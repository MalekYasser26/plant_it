import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/login_button.dart';
import 'package:plant_it/features/cart/presentation/widgets/cart_item.dart';
import 'package:plant_it/features/checkout/presentation/views/checkout_view.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: AppBar(
          backgroundColor: AppColors.basicallyWhite,
          title: const Text(
            "Your cart",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 20), // Add padding to the top
                    itemBuilder: (context, index) => const CartItem(),
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 30),
                    itemCount: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Total Price : 22222\$",
                    style: GoogleFonts.montserrat(
                      fontSize: getResponsiveSize(context, fontSize: 20),
                      color: Colors.white,
                    ),
                  ),
                ),
                CustButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckoutView(),
                      ),
                    );
                  },
                  text: "Proceed to purchase ",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

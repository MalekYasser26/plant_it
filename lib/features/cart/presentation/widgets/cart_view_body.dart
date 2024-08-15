import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
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
          scrolledUnderElevation: 0.0,
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
                    itemBuilder: (context, index) =>  CartItem(
                      index: index+1,
                    ),
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 30),
                    itemCount: 6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        height: getResponsiveSize(context, fontSize: 55),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCDCDC),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Order total\n ',
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: getResponsiveSize(context, fontSize: 12),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkGreenL),
                                // Default text color
                                children: [
                                  TextSpan(
                                    text: 'EGP',
                                    style: TextStyle(
                                        fontFamily: "Raleway",
                                        fontSize:
                                        getResponsiveSize(context, fontSize: 12),
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                    // Color for "Sign in"

                                  ),
                                  TextSpan(
                                    text: ' 4470',
                                    style: TextStyle(
                                        fontFamily: "Raleway",
                                        fontSize:
                                        getResponsiveSize(context, fontSize: 14),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    // Color for "Sign in"

                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: SizedBox(
                          width: getResponsiveSize(context, fontSize: 350),
                          height: getResponsiveSize(context, fontSize: 55),
                          child: ElevatedButton(
                            onPressed: () {
                              print("checkout");
                              Navigator.push(context, MaterialPageRoute(builder:(context) => const CheckoutView(),));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFDCDCDC),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            child: Text("Checkout",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize:
                                    getResponsiveSize(context, fontSize: 18),
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

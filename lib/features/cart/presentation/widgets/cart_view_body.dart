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
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF66BB6A),
                Color(0xFF43A047),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    height: kToolbarHeight,
                    decoration: const BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: getResponsiveSize(context, fontSize: 35),
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Cart",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize:
                              getResponsiveSize(context, fontSize: 35),
                              color: Colors.black),
                        ),
                        const SizedBox()
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>  const CartItem(),
                          separatorBuilder: (context, index) => const SizedBox(height: 15,),
                          itemCount: 5)),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Total Price : 22222\$",style: GoogleFonts.montserrat(
                        fontSize: getResponsiveSize(context, fontSize: 20),
                        color: Colors.white
                    ),),
                  ),
                  CustButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutView(),));
                  }, text: "Proceed to purchase ")

                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}

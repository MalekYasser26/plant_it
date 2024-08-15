import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Summary",
          style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.bold,
            fontSize: getResponsiveSize(context, fontSize: 20),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF8F9EF),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal", style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize:getResponsiveSize(context, fontSize: 15),
                      fontWeight: FontWeight.w300,
                    ),),
                    const Row(
                      children: [
                        Text(
                          "EGP ",
                          style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          "222 ",
                          style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Shipping fee", style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize:getResponsiveSize(context, fontSize: 15),
                      fontWeight: FontWeight.w300,
                    ),),
                    Text("FREE", style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize:getResponsiveSize(context, fontSize: 15),
                        fontWeight: FontWeight.bold,
                        color: AppColors.normGreen
                    ),),

                  ],
                ),
                const SizedBox(height: 5),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Total',
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: getResponsiveSize(context, fontSize: 18),
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkGreenL),
                        // Default text color
                        children: [
                          TextSpan(
                            text: ' Inclu. VAT',
                            style: TextStyle(
                                fontFamily: "Raleway",
                                fontSize:
                                getResponsiveSize(context, fontSize: 12),
                                fontWeight: FontWeight.bold,
                                color: AppColors.greyish),
                            // Color for "Sign in"

                          ),
                        ],
                      ),
                    ),

                    const Row(
                      children: [
                        Text(
                          "EGP ",
                          style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          "222 ",
                          style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}

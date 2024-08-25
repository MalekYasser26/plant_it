import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/recent_purchased_frame.dart';

class RecentPurchasesView extends StatelessWidget {
  const RecentPurchasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: const CustAppBar(text: "Recent purchases",
          implyLeading: true,
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
                    itemBuilder: (context, index) =>  RecentPurchasedFrame(
                      imagePath: 'assets/images/plant${index + 1}.png',
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

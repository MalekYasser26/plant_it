import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/login_button.dart';

import 'cust_checkout_text_field.dart';

class CheckoutViewBody extends StatelessWidget {
  const CheckoutViewBody({super.key});

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
                            size: getResponsiveFontSize(context, fontSize: 35),
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Checkout",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize:
                              getResponsiveFontSize(context, fontSize: 35),
                              color: Colors.black),
                        ),
                        const SizedBox()
                      ],
                    ),
                  ),
                  const SizedBox(height: 50,),
                  CustCheckoutTextField(text: "Address", custIcon: IconButton(
                      onPressed: () {
                      print('ss');
                      },
                      icon : const Icon(Icons.edit),
                  ),
                  phone: false,
                  ),
                  const SizedBox(height: 20,),
                  CustCheckoutTextField(text: "Phone", custIcon: IconButton(
                    onPressed: () {
                      print('ss');
                    },
                    icon : const Icon(Icons.edit),
                  ),
                    phone: true,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Products : 123",style:  GoogleFonts.montserrat(
                              fontSize:  getResponsiveFontSize(context, fontSize: 22),
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Fees : 10\$",style:  GoogleFonts.montserrat(
                              fontSize:  getResponsiveFontSize(context, fontSize: 22),
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Delivery : 20\$",style:  GoogleFonts.montserrat(
                              fontSize:  getResponsiveFontSize(context, fontSize: 22),
                            ),),
                          ),


                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Total Price : 50\$",style:  GoogleFonts.montserrat(
                              fontSize:  getResponsiveFontSize(context, fontSize: 22),
                              fontWeight: FontWeight.bold
                            ),),
                          ),



                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20,),
                  CustButton(onPressed: () {
                  }, text: "Buy")

                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}

import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/cust_nav_bar/presentation/views/cust_nav_bar_selection_view.dart';

class PlantsOrderedView extends StatelessWidget {
  const PlantsOrderedView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: CustAppBar(
          text: "Checkout ",
          implyLeading: true,
          methodNeededtoCall: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => CustNavBarSelectionView(currentIndex: 0),),
            (route) => false,
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset("assets/images/plantOrderSuccess.png",
                        height: 250,
                        width: 200,
                      ),
                      const SizedBox(height: 15,),
                      Text("Your plants are on the way!",style: TextStyle(
                          fontFamily: "Poor Story",
                          fontSize: getResponsiveSize(context, fontSize: 30),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFADABAB)
                      ),),
                    ],
                  ),
                ),
                // Flexible(
                //   child: SizedBox(
                //     width: getResponsiveSize(context, fontSize: 350),
                //     height: getResponsiveSize(context, fontSize: 55),
                //     child: ElevatedButton(
                //       onPressed: () {
                //          Navigator.push(context, MaterialPageRoute(builder: (context) => const TrackOrderView(),));
                //       },
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: const Color(0xFFDCDCDC),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(15),
                //         ),
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 20, vertical: 10),
                //       ),
                //       child: Text(
                //         "Trace order",
                //         style: TextStyle(
                //           fontFamily: "Poppins",
                //           fontSize:
                //           getResponsiveSize(context, fontSize: 18),
                //           color: Colors.black,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

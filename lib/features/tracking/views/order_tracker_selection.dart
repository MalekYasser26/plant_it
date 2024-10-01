import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';

class OrderTrackerSelection extends StatelessWidget {
  const OrderTrackerSelection({super.key});

  @override
  Widget build(BuildContext context) {
    var oCubit = context.read<ProfileCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: CustAppBar(
          text: "Orders Status ",
          implyLeading: true,
        ),
        body:  Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Column(
              children: [
                // Expanded(
                //   child: ListView.separated(
                //     physics: const BouncingScrollPhysics(),
                //       itemBuilder: (context, index) => ListTile(
                //             title:  Text("Order ${index+1} "),
                //         onTap: () {
                //               List orderStatusesID = oCubit.orderStatuses.entries.map( (entry) => (entry.key)).toList() ;
                //           Navigator.push(context, MaterialPageRoute(builder: (context) =>  TrackOrderView(id: orderStatusesID[index],),));
                //         },
                //         shape: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10),
                //           borderSide: const BorderSide(color : AppColors.normGreen)
                //         ),
                //         leading: const Icon(Icons.shopping_bag_outlined,color: AppColors.darkGreenL,),
                //           ),
                //       separatorBuilder: (context, index) => const SizedBox(
                //             height: 20,
                //           ),
                //       itemCount: oCubit.orderStatuses.length),
                // )
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Flexible(
                            child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.lighterGreen,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                 Text("Pending",style:  TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: getResponsiveSize(context, fontSize: 20),
                                ),),
                                const SizedBox(height: 10,),
                                Flexible(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: ListView.separated(
                                          physics: const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) =>Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("DATE ORDERED : ${oCubit.groupDatesByStatus()['Pending']![index]}",
                                                style:  TextStyle(
                                                  fontFamily: "Poor Story",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: getResponsiveSize(context, fontSize: 17),
                                                ),
                                              ),
                                            ),
                                          itemCount: oCubit.groupDatesByStatus()['Pending']!.length,
                                          separatorBuilder: (context, index) => const SizedBox(height: 10,),
                                  
                                        ),
                                      ),
                                      Image.asset('assets/images/pending_state.png'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                                                          ),
                          ),
                          const SizedBox(height: 20,),
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.lightGreen,
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                   Text("Shipped",style:  TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: getResponsiveSize(context, fontSize: 20),
                                  ),),
                                  const SizedBox(height: 10,),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: ListView.separated(
                                            physics: const BouncingScrollPhysics(),
                                              itemBuilder: (context, index) =>Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("DATE ORDERED : ${oCubit.groupDatesByStatus()['Shipped']![index]}",
                                                  style:  TextStyle(
                                                    fontFamily: "Poor Story",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: getResponsiveSize(context, fontSize: 17),
                                                  ),
                                                )
                                              ),
                                            itemCount: oCubit.groupDatesByStatus()['Shipped']!.length,
                                            separatorBuilder: (context, index) => const SizedBox(height: 10,),

                                          ),
                                        ),
                                        Image.asset('assets/images/shipped_state.png'),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.normGreen,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                   Text("Delivered",style:  TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: getResponsiveSize(context, fontSize: 20),
                                  ),),
                                  const SizedBox(height: 10,),
                                  Flexible(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: ListView.separated(
                                            physics: const BouncingScrollPhysics(),
                                          
                                            itemBuilder: (context, index) =>Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("DATE ORDERED : ${oCubit.groupDatesByStatus()['Delivered']![index]}",
                                                  style:  TextStyle(
                                                    fontFamily: "Poor Story",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: getResponsiveSize(context, fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                            itemCount: oCubit.groupDatesByStatus()['Delivered']!.length,
                                            separatorBuilder: (context, index) => const SizedBox(height: 10,),
                                          
                                          ),
                                        ),
                                        Image.asset('assets/images/delivered_state.png'),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

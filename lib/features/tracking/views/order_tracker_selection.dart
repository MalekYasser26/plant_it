import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:plant_it/features/tracking/views/track_order_view.dart';

class OrderTrackerSelection extends StatelessWidget {
  const OrderTrackerSelection({super.key});

  @override
  Widget build(BuildContext context) {
    var oCubit = context.read<ProfileCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: CustAppBar(
          text: "Select order to track ",
          implyLeading: true,
        ),
        body: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => ListTile(
                            title:  Text("Order ${index+1} "),
                        onTap: () {
                              List orderStatusesID = oCubit.orderStatuses.entries.map( (entry) => (entry.key)).toList() ;
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  TrackOrderView(id: orderStatusesID[index],),));
                        },
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color : AppColors.normGreen)
                        ),
                        leading: const Icon(Icons.shopping_bag_outlined,color: AppColors.darkGreenL,),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                      itemCount: oCubit.orderStatuses.length),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

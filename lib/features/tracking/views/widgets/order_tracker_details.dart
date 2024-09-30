import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:plant_it/features/tracking/views/widgets/order_status.dart';

class OrderTrackerDetails extends StatelessWidget {
  final int id ;
  const OrderTrackerDetails({
    super.key, required this.id,
  });

  @override
  Widget build(BuildContext context) {
    var oCubit = context.read<ProfileCubit>();
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child:   Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OrderStatus(text: 'Pending',isCompleted: true,isLast: false,subtext: "Your request is still pending.",),
            OrderStatus(text: 'Shipped',isCompleted: oCubit.orderStatuses[id] == "Delivered" ||oCubit.orderStatuses[id] == "Shipped"?true : false,isLast: false,subtext: "Your order has been shipped!",),
            OrderStatus(text: 'Delivered',isCompleted: oCubit.orderStatuses[id] == "Delivered"?true:false,isLast: true,subtext: "Your order has arrived , take care !",),


          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:plant_it/features/tracking/views/widgets/order_status.dart';

class OrderTrackerDetails extends StatelessWidget {
  const OrderTrackerDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child:  const Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OrderStatus(text: 'Accepted',isCompleted: true,isLast: false,subtext: "Your request has been approved",),
            OrderStatus(text: 'Order Preparing',isCompleted: true,isLast: false,subtext: "The order is prepared for receip",),
            OrderStatus(text: 'Departed',isCompleted: false,isLast: false,subtext: "The parcels left the company",),
            OrderStatus(text: 'In Transit',isCompleted: false,isLast: true,subtext: "Parcel has been delivered",),


          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/tracking/views/widgets/order_status.dart';

class OrderTrackerDetails extends StatelessWidget {
  const OrderTrackerDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.barelyGreen,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child:  Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                "Details",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize:
                  getResponsiveSize(context, fontSize: 18),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const OrderStatus(text: 'Accepted',isCompleted: true,isLast: false,subtext: "Your request has been approved",),
            const OrderStatus(text: 'Order Preparing',isCompleted: true,isLast: false,subtext: "The order is prepared for receip",),
            const OrderStatus(text: 'Departed',isCompleted: false,isLast: false,subtext: "The parcels left the company",),
            const OrderStatus(text: 'In Transit',isCompleted: false,isLast: true,subtext: "Parcel has been delivered",),


          ],
        ),
      ),
    );
  }
}

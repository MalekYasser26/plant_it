import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/tracking/views/widgets/order_tracker_details.dart';

class TrackOrderView extends StatelessWidget {
  const TrackOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: CustAppBar(
          text: "Track order ",
          implyLeading: true,
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 15.0),
            child: Column(
              children: [
                OrderTrackerDetails(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/recent_purchased_frame.dart';

class RecentPurchasesSection extends StatelessWidget {
  const RecentPurchasesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent purchases",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: getResponsiveSize(context, fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () {
                  print("show all");
                },
                style: const ButtonStyle(
                  backgroundColor:
                  WidgetStatePropertyAll(AppColors.greyish),
                ),
                child: Text(
                  "Show all",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w300,
                    fontSize: getResponsiveSize(context, fontSize: 15),
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => RecentPurchasedFrame(
                imagePath: 'assets/images/plant${index+1}.png',
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 12,),
              itemCount: 3,
            ),
          )
        ],
      ),
    );
  }
}

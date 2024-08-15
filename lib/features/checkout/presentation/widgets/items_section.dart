import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/checkout_item.dart';

class ItemsSection extends StatelessWidget {
  const ItemsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Items",
          style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.bold,
            fontSize: getResponsiveSize(context, fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,  // Set a fixed height for the ListView
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return IntrinsicWidth(child: CheckoutItem(index: index+1));
            },
            separatorBuilder: (context, index) =>
            const SizedBox(width: 10),
            itemCount: 6,
          ),
        ),
      ],
    );
  }
}

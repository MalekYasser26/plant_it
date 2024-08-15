import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/address_info_widget.dart';

class AddressInfoSection extends StatelessWidget {
  const AddressInfoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Address & info",
              style: TextStyle(
                fontFamily: "Raleway",
                fontWeight: FontWeight.bold,
                fontSize: getResponsiveSize(context, fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {
                print("edit");
              },
              style: const ButtonStyle(
                backgroundColor:
                WidgetStatePropertyAll(AppColors.greyish),
              ),
              child: Text(
                "Edit",
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
        const SizedBox(height: 5,),
        Container(
          decoration: const BoxDecoration(
              color: Color(0xFFF8F9EF),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: const Column(
            children: [
              AddressInfoWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

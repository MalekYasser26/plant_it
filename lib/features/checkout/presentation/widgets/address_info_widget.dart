import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/line_text.dart';

class AddressInfoWidget extends StatelessWidget {
  final String address , phoneNum ;
  const AddressInfoWidget({
    super.key, required this.address, required this.phoneNum,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 5),
          child: Text(
            "Deliver to",
            style: TextStyle(
              fontFamily: "Raleway",
              fontSize:getResponsiveSize(context, fontSize: 15),

              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        LineText(
          icon: Icon(
            Icons.location_on,
            size: getResponsiveSize(context, fontSize: 30),
            color: Colors.grey,
          ),
          text: address,
        ),
        const SizedBox(height: 10,),
        LineText(
          icon: Icon(
            Icons.phone,
            size: getResponsiveSize(context, fontSize: 30),
            color: Colors.grey,

          ),
          text: "Phone number: $phoneNum ",

        ),
        const SizedBox(height: 10,),

      ],
    );
  }
}

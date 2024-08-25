import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class YourInfoSection extends StatelessWidget {
  const YourInfoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Your info",style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
          fontSize: getResponsiveSize(context, fontSize: 20),
        ),),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Phone number: +20 1076927763",style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.w300,
            fontSize: getResponsiveSize(context, fontSize: 15),
          ),),
        ),
        Text("Address: 13, Al-Doha st, Mansoura",style: TextStyle(
          fontFamily: "Raleway",
          fontWeight: FontWeight.w300,
          fontSize: getResponsiveSize(context, fontSize: 15),
        ),
          softWrap: true,
        ),

      ],
    );
  }
}

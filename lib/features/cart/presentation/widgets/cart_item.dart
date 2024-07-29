import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_it/constants/constants.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/image4.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 50),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "7nklish",
                  style: GoogleFonts.montserrat(
                    fontSize: getResponsiveFontSize(context, fontSize: 25),
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  "Quantity : 2",
                  style: GoogleFonts.montserrat(
                    fontSize: getResponsiveFontSize(context, fontSize: 20),
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Price : 10",
                  style: GoogleFonts.montserrat(
                    fontSize: getResponsiveFontSize(context, fontSize: 20),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

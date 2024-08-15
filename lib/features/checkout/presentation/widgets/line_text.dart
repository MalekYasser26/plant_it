import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class LineText extends StatelessWidget {
  final String text ;
  final Icon icon ;
  const LineText({
    super.key, required this.text, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: "Raleway",
                fontSize:
                getResponsiveSize(context, fontSize: 18),
              ),
              softWrap: true,
              maxLines: 3, // Adjust this value as needed
              overflow: TextOverflow.ellipsis, // Show full text
            ),
          ),
        ],
      ),
    );
  }
}

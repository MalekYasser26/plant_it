import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class TextDescOrderStatus extends StatelessWidget {
  const TextDescOrderStatus({
    super.key,
    required this.isCompleted,
    required this.text,
    required this.subtext,
  });

  final bool isCompleted;
  final String text;
  final String subtext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  !isCompleted ? const EdgeInsets.symmetric(horizontal: 8.0) :const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize:
              getResponsiveSize(context, fontSize: 18),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 8.0),
          child:  Text(
            subtext,
            softWrap: true,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize:
              getResponsiveSize(context, fontSize: 14),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )
        ),
      ],
    );
  }
}

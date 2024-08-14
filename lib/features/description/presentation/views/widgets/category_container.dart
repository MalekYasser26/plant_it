import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  final String text ;
  const CategoryContainer({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFD9D9D9),
      ),
      padding: const EdgeInsets.all(8),
      child:  Text(
        text,
        style: const TextStyle(
          fontFamily: "Raleway",
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),

      ),
    );
  }
}


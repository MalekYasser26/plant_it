import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/cartEmpty.png",
          height: 200,
          width: 150,
        ),
        const SizedBox(height: 15,),
        Text("You have no orders yet",style: TextStyle(
            fontFamily: "Poor Story",
            fontSize: getResponsiveSize(context, fontSize: 30),
            fontWeight: FontWeight.w400,
            color: const Color(0xFFADABAB)
        ),)
      ],
    );
  }
}

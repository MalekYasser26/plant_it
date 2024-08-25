import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class HiBrunoSection extends StatelessWidget {
  const HiBrunoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          minRadius: 30,
          maxRadius: 40,
          child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/images/bruno.png')),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Hi Bruno ! ",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize:
                      getResponsiveSize(context, fontSize: 18),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.edit,color: Colors.black,))
                ],
              ),
              Text(
                "100 followers    76 following",
                style: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w400,
                    fontSize:
                    getResponsiveSize(context, fontSize: 15),
                    color: const Color(0xFF545454)),
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class IconsConnectionOrderStatus extends StatelessWidget {
  const IconsConnectionOrderStatus({
    super.key,
    required this.isCompleted,
    required this.isLast,
  });

  final bool isCompleted;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isCompleted==true ?const Padding(
          padding:  EdgeInsets.only(left :5.0),
          child: Icon(
            Icons.check_circle,
            color: AppColors.darkGreen,
            size: 40,
          ),
        ) :const Icon(
          Icons.circle,
          color: AppColors.lighterGreen,
          size: 50,
        ),
        isLast==false ?  Padding(
          padding:  isCompleted==true? const EdgeInsets.only(left: 5.0) :EdgeInsets.zero,
          child:MediaQuery.of(context).size.height>750 ?const Text(
            "l\nl\nl\nl\nl",
            style: TextStyle(
                color: AppColors.lighterGreen,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ) :
          const Text(
            "l",
            style: TextStyle(
                color: AppColors.lighterGreen,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ) : const SizedBox.shrink(),
      ],
    );
  }
}

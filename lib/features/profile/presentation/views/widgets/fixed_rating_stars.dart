import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:plant_it/constants/constants.dart';

class FixedRatingStars extends StatelessWidget {
  final int rating ;
  const FixedRatingStars({
    super.key, required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return RatingStars(
      axis: Axis.horizontal,
      value: rating*1.0,
      starCount: 5,
      starSize: getResponsiveSize(context, fontSize: 15),
      starSpacing: 5,
      valueLabelVisibility: false,
      starOffColor: Colors.blueGrey.withOpacity(0.5),
      starColor: const Color(0xFFFFCB45),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class CustRatingStars extends StatefulWidget {
  const CustRatingStars({super.key});

  @override
  State<CustRatingStars> createState() => _CustRatingStarsState();
}

class _CustRatingStarsState extends State<CustRatingStars> {
  double value = 1;
  @override
  Widget build(BuildContext context) {
    return RatingStars(
      axis: Axis.horizontal,
      value: value,
      onValueChanged: (v) {
        setState(() {
          value = v;
        });
      },
      starCount: 5,
      starSize: 20,
      maxValue: 5,
      starSpacing: 2,
      valueLabelVisibility: false,
      animationDuration: const Duration(milliseconds: 1000),
      valueLabelPadding: const EdgeInsets.symmetric(
          vertical: 1, horizontal: 8),
      valueLabelMargin: const EdgeInsets.only(right: 8),
      starOffColor: Colors.blueGrey.withOpacity(0.5),
      starColor: const Color(0xFFFFCB45),
      angle: 12,
    );

  }
}

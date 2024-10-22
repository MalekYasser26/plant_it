import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/ratings_cubit/ratings_cubit.dart'; // Import Bloc

class CustRatingStars extends StatefulWidget {
  final int productId;

  const CustRatingStars({super.key, required this.productId});

  @override
  State<CustRatingStars> createState() => _CustRatingStarsState();
}

class _CustRatingStarsState extends State<CustRatingStars> {
  double value = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingsCubit, RatingsState>(
      builder: (context, state) {
        var rCubit = context.read<RatingsCubit>();
        if (state is AddRatingLoadingState || state is AddRatingSuccessfulState) {
          return Row(
            children: [
              RatingStars(
                axis: Axis.horizontal,
                value: value,
                onValueChanged: (v) {
                  setState(() {
                    value = v;
                    rCubit.isRatingFound(widget.productId) == -1  ?
                    rCubit.addProductRating(productId: widget.productId, rating: v.round()) :
                    rCubit.editProductRating(productId: widget.productId, rating: v.round()) ;
                    //print(rCubit.isRatingFound(widget.productId));
                  });
                },
                starCount: 5,
                starSize: 20,
                maxValue: 5,
                starSpacing: 2,
                valueLabelVisibility: false,
                animationDuration: const Duration(milliseconds: 1000),
                valueLabelPadding:
                const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                valueLabelMargin: const EdgeInsets.only(right: 8),
                starOffColor: Colors.blueGrey.withOpacity(0.5),
                starColor: const Color(0xFFFFCB45),
                angle: 12,
              ),
              state is AddRatingLoadingState ? const SizedBox(
                height: 10,
                width: 10,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.normGreen,

                  ),
                ),
              ) :const SizedBox.shrink()

            ],
          );
        }
        if (state is GetUserRatingSuccessState){
          return RatingStars(
            axis: Axis.horizontal,
            value: state.userRating*1.0,
            onValueChanged: (v) {
              setState(() {
                value = v;
                if (state.userRating >0&&state.userRating<=5) {
                  rCubit.editProductRating(
                      productId: widget.productId, rating: v.round());
                }else {
                  rCubit.addProductRating(
                      productId: widget.productId, rating: v.round());
                }
                //print(rCubit.isRatingFound(widget.productId));
              });
            },
            starCount: 5,
            starSize: 20,
            maxValue: 5,
            starSpacing: 2,
            valueLabelVisibility: false,
            animationDuration: const Duration(milliseconds: 1000),
            valueLabelPadding:
            const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
            valueLabelMargin: const EdgeInsets.only(right: 8),
            starOffColor: Colors.blueGrey.withOpacity(0.5),
            starColor: const Color(0xFFFFCB45),
            angle: 12,
          );
        }
        return Column(
          children: [
            RatingStars(
              axis: Axis.horizontal,
              value: value,
              onValueChanged: (v) {
                setState(() {
                  value = v; // Update the rating value
                });
              },
              starCount: 5,
              starSize: 20,
              maxValue: 5,
              starSpacing: 2,
              valueLabelVisibility: false,
              animationDuration: const Duration(milliseconds: 1000),
              valueLabelPadding:
              const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
              valueLabelMargin: const EdgeInsets.only(right: 8),
              starOffColor: Colors.blueGrey.withOpacity(0.5),
              starColor: const Color(0xFFFFCB45),
              angle: 12,
            ),
          ],
        );

      },
    );
  }

}

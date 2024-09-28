part of 'ratings_cubit.dart';

@immutable
sealed class RatingsState {}

final class RatingsInitial extends RatingsState {}
final class ProductRatingLoadingState extends RatingsState {}
final class ProductRatingSuccessfulState extends RatingsState {}
final class ProductRatingFailureState extends RatingsState {}
final class AddRatingLoadingState extends RatingsState {}
final class AddRatingSuccessfulState extends RatingsState {
}
final class AddRatingFailureState extends RatingsState {
  final String message ;

  AddRatingFailureState({required this.message});
}
class GetUserRatingLoadingState extends RatingsState {}
class GetUserRatingSuccessState extends RatingsState {
  final num userRating;

  GetUserRatingSuccessState({
    required this.userRating,
  });
}
class GetUserRatingFailureState extends RatingsState {}



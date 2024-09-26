part of 'ratings_cubit.dart';

@immutable
sealed class RatingsState {}

final class RatingsInitial extends RatingsState {}
final class ProductRatingLoadingState extends RatingsState {}
final class ProductRatingSuccessfulState extends RatingsState {}
final class ProductRatingFailureState extends RatingsState {}

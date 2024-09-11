part of 'liked_plants_cubit.dart';

@immutable
sealed class LikedPlantsState {}

final class LikedPlantsInitial extends LikedPlantsState {}
final class RecentlyLikedLoadingState extends LikedPlantsState {}
final class RecentlyLikedSuccessfulState extends LikedPlantsState {
  final List<RecentlyLikedProductModel> products;
  RecentlyLikedSuccessfulState(this.products);
}
final class RecentlyLikedFailureState extends LikedPlantsState {}

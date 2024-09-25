part of 'liked_plants_cubit.dart';

@immutable
sealed class LikedPlantsState {}

final class LikedPlantsInitial extends LikedPlantsState {}
final class RecentlyLikedLoadingState extends LikedPlantsState {}
final class RecentlyLikedFailureState extends LikedPlantsState {}
final class SuggestedProductLoadingState extends LikedPlantsState {}
final class SuggestedProductFailureState extends LikedPlantsState {}
final class LikedSuggestedPlantsCombinedState extends LikedPlantsState {
  final List<ProductSuggestionModel> productSuggestions;
  final List<RecentlyLikedProductModel> recentlyLikedProducts;
  final int totalItems;

  LikedSuggestedPlantsCombinedState({
    required this.productSuggestions,
    required this.recentlyLikedProducts,
    required this.totalItems,
  });
}


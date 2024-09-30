part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ProfileLoadingState extends ProfileState {}
final class ProfileSuccessfulState extends ProfileState {}
final class ProfileFailureState extends ProfileState {
}
final class RecentlySavedLoadingState extends ProfileState {}

// Updated to hold List<RecentlySavedProductModel>
class RecentlySavedSuccessfulState extends ProfileState {
  final List<RecentlySavedProductModel> savedProducts; // Updated name

  RecentlySavedSuccessfulState(this.savedProducts);
}

final class RecentlySavedFailureState extends ProfileState {}
final class RecentlyPurchasedLoadingState extends ProfileState {}
final class RecentlyPurchasedSuccessState extends ProfileState {}
final class RecentlyPurchasedFailureState extends ProfileState {}

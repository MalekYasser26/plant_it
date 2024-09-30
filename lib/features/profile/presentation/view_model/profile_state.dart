part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ProfileLoadingState extends ProfileState {}
final class ProfileSuccessfulState extends ProfileState {}
final class ProfileFailureState extends ProfileState {
}
final class RecentlySavedPurchasedLoadingState extends ProfileState {}

// Updated to hold List<RecentlySavedProductModel>
class RecentlySavedPurchasedSuccessfulState extends ProfileState {
  final List<RecentlySavedProductModel> savedProducts; // Updated name

  RecentlySavedPurchasedSuccessfulState(this.savedProducts);
}

final class RecentlySavedPurchasedFailureState extends ProfileState {}


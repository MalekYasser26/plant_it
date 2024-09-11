part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ProfileLoadingState extends ProfileState {}
final class ProfileSuccessfulState extends ProfileState {}
final class ProfileFailureState extends ProfileState {}
final class RecentlySavedLoadingState extends ProfileState {}
final class RecentlySavedSuccessfulState extends ProfileState {
  final List<RecentlySavedProductModel> products;
  RecentlySavedSuccessfulState(this.products);
}
final class RecentlySavedFailureState extends ProfileState {}


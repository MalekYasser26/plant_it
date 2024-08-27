part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ProfileLoadingState extends ProfileState {}
final class ProfileSuccessfulState extends ProfileState {}
final class ProfileFailureState extends ProfileState {}

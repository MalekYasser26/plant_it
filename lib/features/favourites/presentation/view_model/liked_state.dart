part of 'liked_cubit.dart';

sealed class LikedState {}

final class LikedInitial extends LikedState {}
final class LikeLoadingState extends LikedState {}
final class LikeSuccessState extends LikedState {}
final class LikeFailureState extends LikedState {}

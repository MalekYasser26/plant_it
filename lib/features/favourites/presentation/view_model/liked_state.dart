part of 'liked_cubit.dart';

sealed class LikedState {}

final class LikedInitial extends LikedState {}
final class LoadLikeLoadingState extends LikedState {}
final class LoadLikeSuccessState extends LikedState {}
final class LoadLikeFailureState extends LikedState {}
final class AddLikeLoadingState extends LikedState {}
final class AddLikeSuccessState extends LikedState {}
final class AddLikeFailureState extends LikedState {}
final class RemoveLikeLoadingState extends LikedState {}
final class RemoveLikeSuccessState extends LikedState {}
final class RemoveLikeFailureState extends LikedState {}



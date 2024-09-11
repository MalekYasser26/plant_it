part of 'liked_cubit.dart';

sealed class LikedState {
  int likeCounter;
  int productID ;
  LikedState({required this.likeCounter,required this.productID});
}
final class LikedInitial extends LikedState {
  @override

  LikedInitial() : super(likeCounter: 0,productID: -1);
}
final class LoadLikeLoadingState extends LikedState {
  LoadLikeLoadingState({required super.likeCounter, required super.productID});
}
final class LoadLikeSuccessState extends LikedState {
  LoadLikeSuccessState({required super.likeCounter, required super.productID});
}
final class LoadLikeFailureState extends LikedState {
  LoadLikeFailureState({required super.likeCounter, required super.productID});
}
final class AddLikeLoadingState extends LikedState {
  AddLikeLoadingState({required super.likeCounter, required super.productID});
}
class AddLikeSuccessState extends LikedState {
  @override
  final int likeCounter;
  @override
  final int productID;
  AddLikeSuccessState({required this.productID,required this.likeCounter}) : super(likeCounter: 0, productID: -1);
}
final class AddLikeFailureState extends LikedState {
  AddLikeFailureState({required super.likeCounter, required super.productID});
}
final class RemoveLikeLoadingState extends LikedState {
  RemoveLikeLoadingState({required super.likeCounter, required super.productID});
}
class RemoveLikeSuccessState extends LikedState {
  @override
  final int likeCounter;
  @override
  final int productID;

  RemoveLikeSuccessState({required this.likeCounter,required this.productID}) : super(likeCounter: 0,productID: -1);
}
final class RemoveLikeFailureState extends LikedState {
  RemoveLikeFailureState({required super.likeCounter, required super.productID});
}





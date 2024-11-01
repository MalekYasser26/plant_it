part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
final class UpdateUICartState extends CartState {}

final class CartLoadingState extends CartState {}

final class CartSuccessfulStateEmpty extends CartState {}

class CartSuccessfulStateFilled extends CartState {
  final List<CartItemModel> cartItems;

  CartSuccessfulStateFilled({required this.cartItems});
}

final class CartFailureState extends CartState {}

final class UpdateCartLoadingState extends CartState {}

final class UpdateCartSuccessState extends CartState {}

final class UpdateCartFailureState extends CartState {
  final String errogMsg;

  UpdateCartFailureState(this.errogMsg);
}

final class AddCartItemLoadingState extends CartState {}

final class AddCartItemSuccessfulState extends CartState {}

final class AddCartItemFailureState extends CartState {
  final String errorMsg;

  AddCartItemFailureState(this.errorMsg);

}

final class RemoveCartItemLoadingState extends CartState {}
final class EditItemDone extends CartState {}

final class RemoveCartItemSuccessfulState extends CartState {
  final int productID ;

  RemoveCartItemSuccessfulState(this.productID);
}

final class RemoveCartItemFailureState extends CartState {
  final String errorMsg;

  RemoveCartItemFailureState(this.errorMsg);
}
final class CheckAvailabilityLoadingState extends CartState {}
final class CheckAvailabilitySuccessfulState extends CartState {}
final class CheckAvailabilityFailureState extends CartState {
  final String name;
  final int quantity;
   CheckAvailabilityFailureState( this.name, this.quantity);
}



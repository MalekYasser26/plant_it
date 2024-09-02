part of 'single_product_cubit.dart';

@immutable
sealed class SingleProductState {}

final class SingleProductInitial extends SingleProductState {}
final class SingleProductLoadingState extends SingleProductState {}
final class SingleProductSuccessfulState extends SingleProductState {
  final SingleProduct product ;
  SingleProductSuccessfulState(this.product);

}
final class SingleProductFailureState extends SingleProductState {}

part of 'products_cubit.dart';

class ProductsState {}

final class ProductsInitial extends ProductsState {}
final class ProductsLoadingState extends ProductsState {}
final class ProductsSuccessfulState extends ProductsState {
  final List<Product> products;

  ProductsSuccessfulState(this.products);
}
final class ProductsFailureState extends ProductsState {}
final class SingleProductLoadingState extends ProductsState {}
final class SingleProductSuccessfulState extends ProductsState {
  final Product product ;
  SingleProductSuccessfulState(this.product);

}
final class SingleProductFailureState extends ProductsState {}

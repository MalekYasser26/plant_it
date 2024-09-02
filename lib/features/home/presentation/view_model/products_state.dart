part of 'products_cubit.dart';

class ProductsState {}

final class ProductsInitial extends ProductsState {}
final class ProductsLoadingState extends ProductsState {}
final class ProductsSuccessfulState extends ProductsState {
  final List<HomeProduct> products;

  ProductsSuccessfulState(this.products);
}
final class ProductsFailureState extends ProductsState {}


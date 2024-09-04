part of 'home_product_cubit.dart';

class HomeProductState {}

// Initial state for product loading
final class ProductsInitial extends HomeProductState {}

// Loading state for fetching products
final class ProductsLoadingState extends HomeProductState {}

// State when products are successfully fetched
final class ProductsSuccessfulState extends HomeProductState {
  final List<HomeProduct> products;

  ProductsSuccessfulState(this.products);
}

// State when fetching products fails
final class ProductsFailureState extends HomeProductState {}

// Loading state for search
final class SearchLoadingState extends HomeProductState {}

// State when search results are successfully fetched
final class SearchSuccessfulState extends HomeProductState {
  final List<HomeProduct> products;

  SearchSuccessfulState(this.products);
}

// State when no products are found for a search query
final class SearchEmptyState extends HomeProductState {}

// State when searching for products fails
final class SearchFailureState extends HomeProductState {}

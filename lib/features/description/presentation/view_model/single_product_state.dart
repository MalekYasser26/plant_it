part of 'single_product_cubit.dart';

@immutable
sealed class SingleProductState {
  final SingleProduct product ;
  final int productID ;

  const SingleProductState({required this.product,required this.productID});

}

final class SingleProductInitial extends SingleProductState {
  @override
  final SingleProduct product;

   SingleProductInitial(this.product) : super(product: product, productID: product.id);
}

final class SingleProductLoadingState extends SingleProductState {
  @override
  final SingleProduct product;

  SingleProductLoadingState(this.product) : super(product: product, productID: product.id);
}

final class SingleProductSuccessfulState extends SingleProductState {
  @override
  final SingleProduct product;

  SingleProductSuccessfulState(this.product): super(product: product, productID: product.id);
}

final class SingleProductFailureState extends SingleProductState {
  @override
  final SingleProduct product;

  SingleProductFailureState(this.product): super(product: product, productID: product.id);
}

final class ProductImagesLoadingState extends SingleProductState {
  @override
  final SingleProduct product;

  ProductImagesLoadingState(this.product): super(product: product, productID: product.id);
}

final class ProductImagesSuccessfulState extends SingleProductState {
  @override
  final SingleProduct product;

  ProductImagesSuccessfulState(this.product): super(product: product, productID: product.id);
}

final class ProductImagesFailureState extends SingleProductState {
  @override
  final SingleProduct product;

  ProductImagesFailureState(this.product): super(product: product, productID: product.id);
}

final class BookmarkLoadingState extends SingleProductState {
  @override
  final SingleProduct product;

  BookmarkLoadingState(this.product): super(product: product, productID: product.id);
}

final class BookmarkSuccessfulState extends SingleProductState {
  @override
  final SingleProduct product;

  BookmarkSuccessfulState(this.product): super(product: product, productID: product.id);
}

final class BookmarkFailureState extends SingleProductState {
  @override
  final SingleProduct product;

  BookmarkFailureState(this.product): super(product: product, productID: product.id);
}

final class AddBookmarkLoadingState extends SingleProductState {
  @override
  final SingleProduct product;

  AddBookmarkLoadingState(this.product): super(product: product, productID: product.id);
}

final class AddBookmarkSuccessfulState extends SingleProductState {
  @override
  final SingleProduct product;

  AddBookmarkSuccessfulState({required this.product}): super(product: product, productID: product.id);
}

final class AddBookmarkFailureState extends SingleProductState {
  @override
  final SingleProduct product;

  AddBookmarkFailureState(this.product): super(product: product, productID: product.id);
}

final class RemoveBookmarkLoadingState extends SingleProductState {
  @override
  final SingleProduct product;

  RemoveBookmarkLoadingState(this.product): super(product: product, productID: product.id);
}

final class RemoveBookmarkSuccessfulState extends SingleProductState {
  @override
  final SingleProduct product;

  RemoveBookmarkSuccessfulState({required this.product}): super(product: product, productID: product.id);
}

final class RemoveBookmarkFailureState extends SingleProductState {
  @override
  final SingleProduct product ;

  RemoveBookmarkFailureState(this.product): super(product: product, productID: product.id);

}

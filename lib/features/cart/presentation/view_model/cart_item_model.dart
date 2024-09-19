class CartItemModel{
  final String name,image ;
  final double price ;
  final int productID ;
  int quantity ;

  CartItemModel({required this.name, required this.price, required this.quantity,required this.productID,required this.image});
}
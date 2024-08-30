class Product {
  final int id;
  final String productName;
  final String price;
  final String? bio;
  final int availableStock;
  final int likesCounter;
  final int imagesCounter;

  Product({
    required this.id,
    required this.productName,
    required this.price,
    this.bio,
    required this.availableStock,
    required this.likesCounter,
    required this.imagesCounter,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['product_name'],
      price: json['price'],
      bio: json['bio'],
      availableStock: json['available_stock'],
      likesCounter: json['likes_counter'],
      imagesCounter: json['images_counter'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'price': price,
      'bio': bio,
      'available_stock': availableStock,
      'likes_counter': likesCounter,
      'images_counter': imagesCounter,
    };
  }
}

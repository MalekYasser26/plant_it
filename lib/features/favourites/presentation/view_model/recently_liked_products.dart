class RecentlyLikedProductModel {
  final int id;
  final String productName;
  final double price;
  final String image;

  RecentlyLikedProductModel({
    required this.id,
    required this.productName,
    required this.price,
    required this.image,
  });

  factory RecentlyLikedProductModel.fromJson(Map<String, dynamic> json) {
    // Extract product details from the nested "product" object
    final product = json['product'] as Map<String, dynamic>;
    final String productImage = product['productImage'] ?? "assets/images/placeholder.png";

    return RecentlyLikedProductModel(
      id: json['productId'] ?? -1 ,
      productName: product['productName'] ?? 'Unknown',
      price: product['price'] ?? -1,
      image: productImage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'price': price,
      'image': image,
    };
  }
}

class RecentlySavedProductModel {
  final int id;
  final String productName;
  final double price;
  final String image;

  RecentlySavedProductModel({
    required this.id,
    required this.productName,
    required this.price,
    required this.image,
  });

  factory RecentlySavedProductModel.fromJson(Map<String, dynamic> json) {
    // Extract product details from the nested "product" object
    final product = json['product'] as Map<String, dynamic>;
    final String productImage = product['productImage'] ?? "assets/images/placeholder.png";

    return RecentlySavedProductModel(
      id: json['id'],
      productName: product['productName'] ?? 'Unknown',
      price: product['price'],
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

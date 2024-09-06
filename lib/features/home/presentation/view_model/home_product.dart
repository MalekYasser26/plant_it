class HomeProduct {
  final int id;
  final String productName;
  final String price;
  int likesCounter;
  final String image;

  HomeProduct({
    required this.id,
    required this.productName,
    required this.price,
    required this.likesCounter,
    required this.image,
  });

  factory HomeProduct.fromJson(Map<String, dynamic> json) {
    final imagesList = json['images'] as List<dynamic>?;
    final String imageUrl = (imagesList != null && imagesList.isNotEmpty)
        ? imagesList[0]['img_url'] ?? "assets/images/placeholder.png"
        : "assets/images/placeholder.png"; // Ensure valid image URL after search

    return HomeProduct(
      id: json['id'],
      productName: json['product_name'],
      price: json['price'],
      likesCounter: json['likes_counter'],
      image: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'price': price,
      'likes_counter': likesCounter,
      'image': image,
    };
  }
}

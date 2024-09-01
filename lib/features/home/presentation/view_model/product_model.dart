class Product {
  final int id;
  final String productName;
  final String price;
  final int likesCounter;
  final int imagesCounter;
  final String image;

  Product({
    required this.id,
    required this.productName,
    required this.price,
    required this.likesCounter,
    required this.imagesCounter,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Safely handle the images field
    final imagesList = json['images'] as List<dynamic>?;
    final String imageUrl = (imagesList != null && imagesList.isNotEmpty)
        ? imagesList[0]['img_url'] ?? "assets/images/plant1.png"
        : "assets/images/plant1.png"; // Fallback if images are null or empty

    return Product(
      id: json['id'],
      productName: json['product_name'],
      price: json['price'],
      likesCounter: json['likes_counter'],
      imagesCounter: json['images_counter'],
      image: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'price': price,
      'likes_counter': likesCounter,
      'images_counter': imagesCounter,
      'image': image,
    };
  }
}

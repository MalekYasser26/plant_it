class HomeProduct {
  final int id;
  final String productName;
  final String price;
  final int likesCounter;
  final String image;

  HomeProduct({
    required this.id,
    required this.productName,
    required this.price,
    required this.likesCounter,
    required this.image,
  });

  factory HomeProduct.fromJson(Map<String, dynamic> json) {
    // Safely handle the images field and validate the image URL
    final imagesList = json['images'] as List<dynamic>?;
    String imageUrl = "assets/images/placeholder.png"; // Fallback image path

    if (imagesList != null && imagesList.isNotEmpty) {
      String? fetchedImageUrl = imagesList[0]['img_url'];
      if (fetchedImageUrl != null && fetchedImageUrl.isNotEmpty) {
        imageUrl = fetchedImageUrl;
      }
    }

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

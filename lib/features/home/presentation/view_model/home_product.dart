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
    // Check if the images field exists and is not null before casting
    final List<dynamic>? imagesList = json['images'] as List<dynamic>?;

    // Debugging: Print the entire json to check the structure
    print("Full JSON: $json");
    print("Images field: ${json['image']}");

    // Default placeholder image if the images list is empty or null
    String imageUrl = json['image'] ??"assets/images/plant6.png";

    // Check if imagesList is not null and contains at least one item
    if (imagesList != null && imagesList.isNotEmpty) {
      final imageMap = imagesList[0] as Map<String, dynamic>?;

      if (imageMap != null && imageMap.containsKey('img_url')) {
        // Use the provided image URL if available
        imageUrl = imageMap['img_url'] ?? imageUrl;
        print('Extracted Image URL: $imageUrl');
      } else {
        print('No valid img_url found in the images list');
      }
    }

    return HomeProduct(
      id: json['id'],
      productName: json['product_name'],
      price: json['price'],
      likesCounter: json['likes_counter'],
      image: imageUrl, // Use the extracted image URL or fallback to placeholder
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

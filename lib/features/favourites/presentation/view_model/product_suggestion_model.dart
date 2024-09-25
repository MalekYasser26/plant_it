class ProductSuggestionModel {
  final int id;
  final String productName;
  final double price;
  final int likesCounter;
  final String? image;  // Image field can be nullable

  ProductSuggestionModel({
    required this.id,
    required this.productName,
    required this.price,
    required this.likesCounter,
    this.image,  // Nullable image field
  });

  // Factory method to create an instance from JSON
  factory ProductSuggestionModel.fromJson(Map<String, dynamic> json) {
    return ProductSuggestionModel(
      id: json['id'],
      productName: json['productName'],
      price: (json['price'] as num).toDouble(),  // Convert price to double
      likesCounter: json['likesCounter'],
      image: json['image'] != null ? json['image']['imgUrl'] : null,  // Safely handle null image
    );
  }

  // Method to convert the object back to JSON (for caching)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'price': price,
      'likesCounter': likesCounter,
      'image': image,
    };
  }
}

class RecentlySavedProductModel {
  final int id;
  final String name;
  final double price;
  final String? imgUrl;

  RecentlySavedProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.imgUrl,
  });

  // Factory method to create an instance from JSON
  factory RecentlySavedProductModel.fromJson(Map<String, dynamic> json) {
    return RecentlySavedProductModel(
      id: json['product']['id'],
      name: json['product']['productName'],
      price: (json['product']['price'] as num).toDouble(),
      imgUrl: json['product']['image'] != null ? json['product']['image']['imgUrl'] : null,
    );
  }

  // Method to convert instance to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imgUrl': imgUrl,
    };
  }
}

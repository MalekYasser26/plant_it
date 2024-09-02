class SingleProduct {
  final int id;
  final String productName;
  final String price;
  final String bio;
  final int availableStock;
  final int likesCounter;
  final int imagesCounter;
  final List<ProductImage> images;
  final List<ProductCategory> productCategories;

  SingleProduct({
    required this.id,
    required this.productName,
    required this.price,
    required this.bio,
    required this.availableStock,
    required this.likesCounter,
    required this.imagesCounter,
    required this.images,
    required this.productCategories,
  });

  factory SingleProduct.fromJson(Map<String, dynamic> json) {
    // Parse images
    final List<ProductImage> imagesList = (json['images'] as List<dynamic>?)
        ?.map((image) => ProductImage.fromJson(image))
        .toList() ?? [];

    // Parse categories
    final List<ProductCategory> categoriesList = (json['productcategory'] as List<dynamic>?)
        ?.map((category) => ProductCategory.fromJson(category['category']))
        .toList() ?? [];

    return SingleProduct(
      id: json['id'],
      productName: json['product_name'],
      price: json['price'],
      bio: json['bio'],
      availableStock: json['available_stock'],
      likesCounter: json['likes_counter'],
      imagesCounter: json['images_counter'],
      images: imagesList,
      productCategories: categoriesList,
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
      'images': images.map((image) => image.toJson()).toList(),
      'productcategory': productCategories.map((category) => category.toJson()).toList(),
    };
  }
}

class ProductImage {
  final int? imgOrder;
  final String imgUrl;

  ProductImage({
    required this.imgUrl,
    this.imgOrder,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      imgUrl: json['img_url'],
      imgOrder: json['img_order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img_order': imgOrder,
      'img_url': imgUrl,
    };
  }
}

class ProductCategory {
  final String name;

  ProductCategory({
    required this.name,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      name: json['Name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
    };
  }
}

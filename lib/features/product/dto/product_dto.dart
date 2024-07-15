class ProductDto {
  final int id;
  final String productName;
  final int categoryId;
  final int campaignId;
  final String gender;
  final double price;
  final String description;
  final int stockQuantity;
  final String imageUrl;
  final int size;
  final String color;
  final String status;
  final List<ProductDto>? recommendations;

  ProductDto({
    required this.id,
    required this.productName,
    required this.categoryId,
    required this.campaignId,
    required this.gender,
    required this.price,
    required this.description,
    required this.stockQuantity,
    required this.imageUrl,
    required this.size,
    required this.color,
    required this.status,
    this.recommendations,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    var recommendList = json['recommendations'] as List<dynamic>?;
    List<ProductDto>? recommend = recommendList
        ?.map((product) => ProductDto.fromJson(product as Map<String, dynamic>))
        .toList();

    return ProductDto(
      id: json['id'],
      productName: json['productName'],
      categoryId: json['categoryId'],
      campaignId: json['campaignId'],
      gender: json['gender'],
      price: json['price'],
      description: json['description'],
      stockQuantity: json['stockQuantity'],
      imageUrl: json['imageUrl'] ?? 'https://example.com/image1.jpg',
      size: json['size'],
      color: json['color'],
      status: json['status'],
      recommendations: recommend,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'categoryId': categoryId,
      'campaignId': campaignId,
      'gender': gender,
      'price': price,
      'description': description,
      'stockQuantity': stockQuantity,
      'imageUrl': imageUrl,
      'size': size,
      'color': color,
      'status': status,
      'recommend': recommendations?.map((product) => product.toJson()).toList(),
    };
  }
}

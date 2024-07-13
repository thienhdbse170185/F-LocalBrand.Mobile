class ProductDto {
  final int id;
  final String productName;
  final int categoryId;
  final int campaignId;
  final String gender;
  final int price;
  final String description;
  final int stockQuantity;
  final String imageUrl;
  final int size;
  final String color;
  final String status;

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
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
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
    };
  }
}

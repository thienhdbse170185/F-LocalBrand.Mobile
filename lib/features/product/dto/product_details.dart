import 'dart:convert';

// Product DTO
class ProductDetailsDTO {
  final int id;
  final String productName;
  final String? subCategory;
  final String gender;
  final double price;
  final String description;
  final int stockQuantity;
  final String imageUrl;
  final int size;
  final String color;
  final String status;
  final DateTime? createDate;
  final CampaignDTO campaign;
  final CategoryDTO category;
  final List<ProductRecommendationDTO> productsRecommendation;

  ProductDetailsDTO({
    required this.id,
    required this.productName,
    this.subCategory,
    required this.gender,
    required this.price,
    required this.description,
    required this.stockQuantity,
    required this.imageUrl,
    required this.size,
    required this.color,
    required this.status,
    this.createDate,
    required this.campaign,
    required this.category,
    required this.productsRecommendation,
  });

  factory ProductDetailsDTO.fromJson(Map<String, dynamic> json) {
    return ProductDetailsDTO(
      id: json['id'],
      productName: json['productName'],
      subCategory: json['subCategory'],
      gender: json['gender'],
      price: json['price'].toDouble(),
      description: json['description'],
      stockQuantity: json['stockQuantity'],
      imageUrl: json['imageUrl'],
      size: json['size'],
      color: json['color'],
      status: json['status'],
      createDate: json['createDate'] != null
          ? DateTime.parse(json['createDate'])
          : null,
      campaign: CampaignDTO.fromJson(json['campaign']),
      category: CategoryDTO.fromJson(json['category']),
      productsRecommendation: (json['productsRecommendation'] as List<dynamic>)
          .map((e) => ProductRecommendationDTO.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'subCategory': subCategory,
      'gender': gender,
      'price': price,
      'description': description,
      'stockQuantity': stockQuantity,
      'imageUrl': imageUrl,
      'size': size,
      'color': color,
      'status': status,
      'createDate': createDate?.toIso8601String(),
      'campaign': campaign.toJson(),
      'category': category.toJson(),
      'productsRecommendation':
          productsRecommendation.map((e) => e.toJson()).toList(),
    };
  }
}

// Campaign DTO
class CampaignDTO {
  final int id;
  final String campaignName;

  CampaignDTO({
    required this.id,
    required this.campaignName,
  });

  factory CampaignDTO.fromJson(Map<String, dynamic> json) {
    return CampaignDTO(
      id: json['id'],
      campaignName: json['campaignName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'campaignName': campaignName,
    };
  }
}

// Category DTO
class CategoryDTO {
  final int id;
  final String categoryName;
  final String description;

  CategoryDTO({
    required this.id,
    required this.categoryName,
    required this.description,
  });

  factory CategoryDTO.fromJson(Map<String, dynamic> json) {
    return CategoryDTO(
      id: json['id'],
      categoryName: json['categoryName'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryName': categoryName,
      'description': description,
    };
  }
}

// Product Recommendation DTO
class ProductRecommendationDTO {
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
  final DateTime? createDate;

  ProductRecommendationDTO({
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
    this.createDate,
  });

  factory ProductRecommendationDTO.fromJson(Map<String, dynamic> json) {
    return ProductRecommendationDTO(
      id: json['id'],
      productName: json['productName'],
      categoryId: json['categoryId'],
      campaignId: json['campaignId'],
      gender: json['gender'],
      price: json['price'].toDouble(),
      description: json['description'],
      stockQuantity: json['stockQuantity'],
      imageUrl: json['imageUrl'],
      size: json['size'],
      color: json['color'],
      createDate: json['createDate'] != null
          ? DateTime.parse(json['createDate'])
          : null,
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
      'createDate': createDate?.toIso8601String(),
    };
  }
}

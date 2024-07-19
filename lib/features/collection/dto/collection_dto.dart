import 'dart:convert';

import 'package:f_localbrand/features/product/dto/product_dto.dart';

class CollectionDto {
  final int id;
  final String collectionName;
  final String status;
  final List<dynamic>
      products; // Bạn có thể thay đổi kiểu của danh sách nếu có một lớp sản phẩm cụ thể

  CollectionDto({
    required this.id,
    required this.collectionName,
    required this.status,
    required this.products,
  });

  // Chuyển đổi từ JSON sang đối tượng CollectionDto
  factory CollectionDto.fromJson(Map<String, dynamic> json) {
    return CollectionDto(
      id: json['id'] as int,
      collectionName: json['collectionName'] as String,
      status: json['status'] as String,
      products: (json['products'] as List<dynamic>)
          .map((productJson) =>
              ProductDto.fromJson(productJson as Map<String, dynamic>))
          .toList(),
    );
  }

  // Chuyển đổi từ đối tượng CollectionDto sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionName': collectionName,
      'status': status,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

import 'package:f_localbrand/features/product/dto/product_dto.dart';

class CategoryDto {
  final int id;
  final String category;
  final String description;
  final String status;
  final List<ProductDto>? products;

  CategoryDto(
      this.id, this.category, this.description, this.status, this.products);

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List<dynamic>?;
    List<ProductDto>? products = productList
        ?.map((product) => ProductDto.fromJson(product as Map<String, dynamic>))
        .toList();

    return CategoryDto(
      json['id'],
      json['categoryName'],
      json['description'],
      json['status'],
      products,
    );
  }
}

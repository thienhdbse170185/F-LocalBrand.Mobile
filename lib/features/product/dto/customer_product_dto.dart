import 'package:f_localbrand/features/product/dto/product_dto.dart';

class CustomerProductDto {
  final int id;
  final int customerId;
  final int productId;
  final String buyDate;
  String status;
  final ProductDto product;

  CustomerProductDto({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.buyDate,
    required this.status,
    required this.product,
  });

  factory CustomerProductDto.fromJson(Map<String, dynamic> json) {
    return CustomerProductDto(
      id: json['id'],
      customerId: json['customerId'],
      productId: json['productId'],
      buyDate: json['buyDate'],
      status: json['status'],
      product: ProductDto.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'productId': productId,
      'buyDate': buyDate,
      'status': status,
      'product': product.toJson(),
    };
  }
}

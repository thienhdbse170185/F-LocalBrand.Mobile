import 'package:f_localbrand/features/product/dto/product_dto.dart';

class ProductOrderDto {
  final int quantity;
  final double price;
  final ProductDto product;

  ProductOrderDto({
    required this.quantity,
    required this.price,
    required this.product,
  });

  factory ProductOrderDto.fromJson(Map<String, dynamic> json) {
    return ProductOrderDto(
      quantity: json['quantity'],
      price: json['price'],
      product: ProductDto.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'price': price,
      'product': product.toJson(),
    };
  }
}

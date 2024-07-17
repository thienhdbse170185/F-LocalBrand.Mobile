import 'package:f_localbrand/features/product/dto/product_dto.dart';

class OrderDetailsDTO {
  final int orderId;
  final int productId;
  final int quantity;
  final double price;
  final ProductDto product;

  OrderDetailsDTO({
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.product,
  });

  factory OrderDetailsDTO.fromJson(Map<String, dynamic> json) {
    return OrderDetailsDTO(
      orderId: json['orderId'],
      productId: json['productId'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      product: ProductDto.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'productId': productId,
      'quantity': quantity,
      'price': price,
      'product': product.toJson(),
    };
  }

  @override
  String toString() {
    return 'OrderDetailsDTO{orderId: $orderId, productId: $productId, quantity: $quantity, price: $price, product: ${product.toString()}}';
  }
}

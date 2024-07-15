import 'package:f_localbrand/features/cart/dto/cart_product_dto.dart';

class CartDto {
  final List<ProductCartDto> items;
  final double totalCartValue;
  final int totalItems;

  CartDto({
    required this.items,
    required this.totalCartValue,
    required this.totalItems,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List<dynamic>;
    List<ProductCartDto> items = itemsList
        .map((item) => ProductCartDto.fromJson(item as Map<String, dynamic>))
        .toList();

    return CartDto(
      items: items,
      totalCartValue: json['totalCartValue'],
      totalItems: json['totalItems'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'totalCartValue': totalCartValue,
      'totalItems': totalItems,
    };
  }
}

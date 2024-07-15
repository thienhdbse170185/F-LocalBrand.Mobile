class SimplifiedProductCartDto {
  final int id;
  final int quantity;

  SimplifiedProductCartDto({
    required this.id,
    required this.quantity,
  });

  factory SimplifiedProductCartDto.fromJson(Map<String, dynamic> json) {
    return SimplifiedProductCartDto(
      id: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': id,
      'quantity': quantity,
    };
  }
}

class OrderDto {
  final List<SimplifiedProductCartDto> items;
  final String paymentMethod;

  OrderDto({required this.items, this.paymentMethod = 'string'});

  factory OrderDto.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    List<SimplifiedProductCartDto> items =
        itemsList.map((i) => SimplifiedProductCartDto.fromJson(i)).toList();
    return OrderDto(
      items: items,
      paymentMethod: json['paymentMethod'] ?? 'string',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': items.map((item) => item.toJson()).toList(),
      'paymentMethod': paymentMethod,
    };
  }
}

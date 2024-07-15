class ProductCartDto {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final String image;
  final double totalPrice;

  ProductCartDto({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.totalPrice,
  });

  factory ProductCartDto.fromJson(Map<String, dynamic> json) {
    return ProductCartDto(
      id: json['productId'],
      name: json['productName'],
      price: json['productPrice'],
      quantity: json['quantity'],
      image: json['productImage'] ?? "https://via.placeholder.com/150",
      totalPrice: json['totalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': id,
      'productName': name,
      'productPrice': price,
      'quantity': quantity,
      'productImage': image,
      'totalPrice': totalPrice,
    };
  }
}

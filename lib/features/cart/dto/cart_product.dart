class ProductCartDto {
  final String id;
  final String name;
  final String image;
  final int quantity;
  final double price;
  final double size;

  ProductCartDto(
      this.id, this.name, this.image, this.quantity, this.price, this.size);
}

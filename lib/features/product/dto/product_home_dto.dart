class ProductHomeDto {
  final int id;
  final String name;
  final String? image;
  final double price;

  ProductHomeDto({
    required this.id,
    required this.name,
    this.image,
    required this.price,
  });
}

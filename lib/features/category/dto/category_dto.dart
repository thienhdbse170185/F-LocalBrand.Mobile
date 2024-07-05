class CategoryDto {
  final int id;
  final String category;
  final String description;

  CategoryDto(
    this.id,
    this.category,
    this.description,
  );

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      json['category']['id'] ?? 0,
      json['category']['category'] ?? "",
      json['category']['description'] ?? "",
    );
  }
}

import 'package:f_localbrand/features/category/data/category_api_client.dart';
import 'package:f_localbrand/features/category/dto/category_dto.dart';

class CategoryRepository {
  final CategoryApiClient categoryApiClient;

  CategoryRepository({required this.categoryApiClient});

  Future<List<CategoryDto>> getCategories() async {
    try {
      List<CategoryDto> result =
          categoryApiClient.getCategories() as List<CategoryDto>;
      return result;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<CategoryDto>> getCategoriesProducts() async {
    try {
      List<CategoryDto> result =
          categoryApiClient.getCategoriesProducts() as List<CategoryDto>;
      return result;
    } catch (e) {
      print(e);
    }
    return [];
  }
}

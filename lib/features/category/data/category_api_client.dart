import 'package:dio/dio.dart';
import 'package:f_localbrand/features/category/dto/category_dto.dart';

class CategoryApiClient {
  final Dio dio;
  const CategoryApiClient(this.dio);

  Future<List<CategoryDto>> getCategories() async {
    try {
      final response = await dio.get('/categories');
      if (response.statusCode == 200) {
        List<CategoryDto> result =
            (response.data['result']['categories'] as List)
                .map((e) => CategoryDto.fromJson(e))
                .toList();
        return result;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<CategoryDto>> getCategoriesProducts() async {
    try {
      final response = await dio.get('/categories/products');
      if (response.statusCode == 200) {
        List<CategoryDto> result =
            (response.data['result']['categories'] as List)
                .map((e) => CategoryDto.fromJson(e))
                .toList();
        return result;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}

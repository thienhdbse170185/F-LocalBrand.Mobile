import 'package:dio/dio.dart';
import 'package:f_localbrand/features/product/dto/product_dto.dart';

class ProductApiClient {
  ProductApiClient(this.dio);

  final Dio dio;

  Future<dynamic> fetchProductsByFilter(String filter) async {
    try {
      final products = await dio.get('/products/$filter');
      return products;
    } catch (e) {
      print(e);
    }
  }

  Future<List<ProductDto>> fetchProductNewest() async {
    try {
      final response = await dio.get('/products/latest/4');
      if (response.statusCode == 200) {
        final result = response.data['result'];
        if (result != null && result.containsKey('products')) {
          return (result['products'] as List)
              .map((e) => ProductDto.fromJson(e))
              .toList();
        }
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<ProductDto>> fetchProductBestseller() async {
    try {
      final campaigns = await dio.get('/products/best-seller/4');
      if (campaigns.statusCode == 200) {
        return (campaigns.data as List)
            .map((e) => ProductDto.fromJson(e))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}

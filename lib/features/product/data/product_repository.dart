import 'package:f_localbrand/features/product/data/product_api_client.dart';
import 'package:f_localbrand/features/product/dto/product_dto.dart';

class ProductRepository {
  final ProductApiClient productApiClient;

  const ProductRepository({required this.productApiClient});

  Future<dynamic> getProductsByFilter(String filter) async {
    try {
      final result = await productApiClient.fetchProductsByFilter(filter);
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getProductsNewest() async {
    try {
      final result =
          productApiClient.fetchProductNewest();
      return result;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<ProductDto>> getProductsBestseller() async {
    try {
      List<ProductDto> result =
          productApiClient.fetchProductBestseller() as List<ProductDto>;
      return result;
    } catch (e) {
      print(e);
    }
    return [];
  }
}

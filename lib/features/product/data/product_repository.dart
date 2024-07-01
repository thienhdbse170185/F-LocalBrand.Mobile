import 'package:f_localbrand/features/product/data/product_api_client.dart';

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
}

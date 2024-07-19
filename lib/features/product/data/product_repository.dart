import 'package:f_localbrand/features/product/data/product_api_client.dart';
import 'package:f_localbrand/features/product/dto/customer_product_dto.dart';
import 'package:f_localbrand/features/product/dto/product_details.dart';
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

  Future<List<ProductDto>> getProductsNewest() async {
    try {
      final result = productApiClient.fetchProductNewest();
      return result;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<ProductDto>> getProductsBestseller() async {
    try {
      final result = productApiClient.fetchProductBestseller();
      return result;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<ProductDto?> getProductDetail(int id) async {
    try {
      final result = productApiClient.fetchProductDetail(id);
      return result;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<CustomerProductDto>> getCustomerProduct(int id) async {
    try {
      final result = productApiClient.fetchCustomerProduct(id);
      return result;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<CustomerProductDto>> getCustomerProductRecommendations(
      int id) async {
    try {
      final result = productApiClient.fetchRecommendCustomerProduct(id);
      return result;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<ProductDetailsDTO>> fetchProductDetailsByName(String name) async {
    try {
      final result = productApiClient.fetchProductDetailsByName(name);
      return result;
    } catch (e) {
      print(e);
    }
    return [];
  }
}

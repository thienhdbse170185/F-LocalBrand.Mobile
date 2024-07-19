import 'package:dio/dio.dart';
import 'package:f_localbrand/features/product/dto/customer_product_dto.dart';
import 'package:f_localbrand/features/product/dto/product_details.dart';
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
        List<ProductDto> result = (response.data['result']['products'] as List)
            .map((e) => ProductDto.fromJson(e))
            .toList();
        return result;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<ProductDto>> fetchProductBestseller() async {
    try {
      final response = await dio.get('/products/best-seller/4');
      if (response.statusCode == 200) {
        List<ProductDto> result = (response.data['result']['products'] as List)
            .map((e) => ProductDto.fromJson(e))
            .toList();
        return result;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<ProductDto?> fetchProductDetail(int id) async {
    try {
      final response = await dio.get('/product/$id/product-recommendations');
      if (response.statusCode == 200) {
        return ProductDto.fromJson(response.data['result']['product']);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<CustomerProductDto>> fetchCustomerProduct(int id) async {
    try {
      final response = await dio.get('/customer/$id/customer-products');
      if (response.statusCode == 200) {
        List<CustomerProductDto> result =
            (response.data['result']['customerProducts'] as List)
                .map((e) => CustomerProductDto.fromJson(e))
                .toList();
        return result;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<CustomerProductDto>> fetchRecommendCustomerProduct(int id) async {
    try {
      final response =
          await dio.get('/customer/$id/products/product-recommended');
      if (response.statusCode == 200) {
        List<CustomerProductDto> result =
            (response.data['result']['customerProducts'] as List)
                .map((e) => CustomerProductDto.fromJson(e))
                .toList();
        return result;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<ProductDetailsDTO>> fetchProductDetailsByName(String name) async {
    try {
      final response = await dio.get('/products/filter?ProductName=$name');
      if (response.statusCode == 200) {
        List<ProductDetailsDTO> result =
            (response.data['result']['products'] as List)
                .map((e) => ProductDetailsDTO.fromJson(e))
                .toList();
        return result;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}

import 'package:dio/dio.dart';

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
}

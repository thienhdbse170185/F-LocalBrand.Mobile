import 'package:dio/dio.dart';
import 'package:f_localbrand/features/cart/dto/cart_dto.dart';
import 'package:f_localbrand/features/cart/dto/cart_product_dto.dart';

class CartApiClient {
  final Dio dio;
  const CartApiClient(this.dio);

  Future<bool> addToCart(int productID, int quantity) async {
    try {
      final response = await dio.post('/cart/add-to-cart',
          data: {'productId': productID, 'quantity': quantity});
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }

  Future<CartDto?> getCart() async {
    try {
      final response = await dio.get('/cart/get-customer-cart');
      if (response.statusCode == 200) {
        CartDto result = CartDto.fromJson(response.data['result']);
        return result;
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}

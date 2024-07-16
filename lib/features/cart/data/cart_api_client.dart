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
        if (response.data['result'] is String) {
          return null;
        }
        CartDto result = CartDto.fromJson(response.data['result']);
        return result;
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  Future<bool> updateCart(List<ProductCartDto> orderList) async {
    try {
      final response = await dio.put('/cart/update-cart', data: {
        'products': orderList
            .map((item) => {
                  'productId': item.id,
                  'quantity': item.quantity,
                })
            .toList()
      });
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      rethrow;
    }
    return false;
  }
}

import 'package:f_localbrand/features/cart/data/cart_api_client.dart';
import 'package:f_localbrand/features/cart/dto/cart_dto.dart';
import 'package:f_localbrand/features/cart/dto/cart_product_dto.dart';

class CartRepository {
  final CartApiClient cartApiClient;
  CartRepository({required this.cartApiClient});
  // List<ProductCartDto> cart = [];

  Future<bool> addToCart(int productID, int quantity) async {
    try {
      await cartApiClient.addToCart(productID, quantity);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CartDto?> getCart() async {
    try {
      CartDto? cart = await cartApiClient.getCart();
      return cart;
    } catch (e) {
      throw Exception(e);
    }
  }
}

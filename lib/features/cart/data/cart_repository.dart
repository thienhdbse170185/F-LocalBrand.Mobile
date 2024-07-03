import 'package:f_localbrand/features/cart/data/cart_api_client.dart';
import 'package:f_localbrand/features/cart/dto/cart_product.dart';

class CartRepository {
  final CartApiClient cartApiClient;
  CartRepository({required this.cartApiClient});
  List<ProductCartDto> cart = [];
  Future<bool> addToCart(ProductCartDto product) async {
    // Call the API or any async operation here
    cart.add(product);
    return true;
  }

  Future<List<ProductCartDto>> getCart() async {
    // Call the API or any async operation here
    return cart;
  }
}

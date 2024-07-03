import 'package:f_localbrand/features/cart/dto/cart_product.dart';
import 'package:f_localbrand/features/product/dto/product_home_dto.dart';

class CartRepository {
  List<ProductCartDto> cart = [];
  Future<void> addToCart(ProductCartDto product) async {
    // Call the API or any async operation here
    cart.add(product);
    // Return the result
  }
}

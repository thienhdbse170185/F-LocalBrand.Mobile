import 'package:f_localbrand/features/cart/dto/cart_product_dto.dart';
import 'package:f_localbrand/features/order/data/order_api_client.dart';
import 'package:f_localbrand/features/order/dto/order_dto.dart';

class OrderRepository {
  final OrderApiClient orderApiClient;
  OrderRepository({required this.orderApiClient});

  List<ProductCartDto> orderList = [];

  Future<String> addOrder(OrderDto order) async {
    try {
      return await orderApiClient.addOrder(order);
    } catch (e) {
      rethrow;
    }
  }

  bool addToOrderList(List<ProductCartDto> cartList) {
    orderList = cartList;
    return true;
  }
}

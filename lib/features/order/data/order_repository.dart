import 'package:f_localbrand/features/cart/dto/cart_product_dto.dart';
import 'package:f_localbrand/features/order/data/order_api_client.dart';
import 'package:f_localbrand/features/order/dto/order_details.dart';
import 'package:f_localbrand/features/order/dto/order_dto.dart';
import 'package:f_localbrand/features/order/dto/order_tracking_dto.dart';
import 'package:f_localbrand/features/product/dto/product_dto.dart';

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

  Future<List<OrderTrackingDTO>> getInprogressOrderTracking() async {
    try {
      return orderApiClient.getInprogressOrderTracking();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderDetailsDTO>> getOrderDetails(int orderId) async {
    try {
      return orderApiClient.getOrderDetails(orderId);
    } catch (e) {
      rethrow;
    }
  }
}

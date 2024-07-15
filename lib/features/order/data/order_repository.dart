import 'package:f_localbrand/features/order/data/order_api_client.dart';
import 'package:f_localbrand/features/order/dto/order_dto.dart';

class OrderRepository {
  final OrderApiClient orderApiClient;
  OrderRepository({required this.orderApiClient});

  Future<bool> addOrder(OrderDto order) async {
    try {
      return await orderApiClient.addOrder(order);
    } catch (e) {
      rethrow;
    }
  }
}

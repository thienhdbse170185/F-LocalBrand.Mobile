import 'package:dio/dio.dart';
import 'package:f_localbrand/features/order/dto/order_dto.dart';

class OrderApiClient {
  final Dio dio;
  OrderApiClient(this.dio);

  Future<bool> addOrder(OrderDto order) async {
    try {
      final request = order.toJson();
      final response = await dio.post('/order', data: request);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      rethrow;
    }
    return false;
  }
}

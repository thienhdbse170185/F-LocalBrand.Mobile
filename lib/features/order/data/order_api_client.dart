import 'package:dio/dio.dart';
import 'package:f_localbrand/features/order/dto/order_dto.dart';

class OrderApiClient {
  final Dio dio;
  OrderApiClient(this.dio);

  Future<String> addOrder(OrderDto order) async {
    try {
      final request = order.toJson();
      final response = await dio.post('/order', data: request);
      if (response.statusCode == 200) {
        return response.data['result'] as String;
      }
    } catch (e) {
      rethrow;
    }
    return "";
  }
}

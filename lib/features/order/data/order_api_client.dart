import 'package:dio/dio.dart';
import 'package:f_localbrand/features/order/dto/order_details.dart';
import 'package:f_localbrand/features/order/dto/order_dto.dart';
import 'package:f_localbrand/features/order/dto/order_tracking_dto.dart';
import 'package:f_localbrand/features/product/dto/product_dto.dart';

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
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['result'] as String);
      } else {
        throw Exception(e.message);
      }
    }
    return "";
  }

  Future<List<OrderTrackingDTO>> getInprogressOrderTracking() async {
    try {
      final response = await dio.get('/order/in-progress');
      if (response.statusCode == 200) {
        return (response.data['result'] as List)
            .map((e) => OrderTrackingDTO.fromJson(e))
            .toList();
      }
    } catch (e) {
      rethrow;
    }
    return [];
  }

  Future<OrderDetailsDto> getOrderDetails(int orderId) async {
    try {
      final response = await dio.get('/order/$orderId/details');
      if (response.statusCode == 200) {
        return OrderDetailsDto.fromJson(response.data['result']);
      }
    } catch (e) {
      rethrow;
    }
    return OrderDetailsDto(
        orderId: 0,
        customerId: 0,
        orderDate: DateTime.now(),
        totalAmount: 0,
        currentStatus: '',
        statusHistory: '',
        details: []);
  }

  Future<List<OrderTrackingDTO>> getOrderTrackingByOrderHistory(
      int customerId, String status) async {
    try {
      final response = await dio.get(
          '/order/order-history-status?CustomerId=$customerId&Status=$status');
      if (response.statusCode == 200) {
        return (response.data['result']['orders'] as List)
            .map((e) => OrderTrackingDTO.fromJson(e))
            .toList();
      }
    } catch (e) {
      rethrow;
    }
    return [];
  }
}

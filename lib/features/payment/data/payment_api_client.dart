import 'package:dio/dio.dart';
import 'package:f_localbrand/features/payment/dto/vnpay_response.dart';

class PaymentApiClient {
  final Dio dio;
  PaymentApiClient(this.dio);

  Future<String> checkPayment(VnpayResponse vnpayResponse) async {
    try {
      final requestUrl = '/order/check-payment?${vnpayResponse.toString()}';
      final response = await dio.get(requestUrl);
      if (response.statusCode == 200) {
        return response.data['result'] as String;
      }
    } catch (e) {
      rethrow;
    }
    return '';
  }
}
